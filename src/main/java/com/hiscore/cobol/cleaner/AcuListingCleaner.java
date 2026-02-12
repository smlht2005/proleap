/**
 * 更新時間：2026-02-06 16:57
 * 作者：AI Assistant
 * 摘要：ACUCOBOL-GT 編譯器列表檔(.lst) 清理工具
 *       將 .lst 轉換為純 COBOL 原始碼(.cbl)，以供 ProLeap 解析
 *
 * 更新歷程：
 *   2026-02-06 17:08 - 新增 copybook 標頭偵測（ACUGUI.DEF 等檔名行），解決 WORKING-STORAGE 解析中斷
 *   2026-02-06 17:05 - 新增 SCREEN SECTION 註解化（ACUCOBOL GUI 定義），解除 PROCEDURE DIVISION 解析阻塞
 *   2026-02-06 16:57 - 新增 $ 編譯器指令註解化（$XFD, $IF, $SET 等），解決 ProLeap 解析中斷問題
 *   2026-02-06 14:50 - 重構：改用 TANDEM 格式策略，strip 前 7 字元序號區
 *   2026-02-06 14:40 - 修正列表檔欄位偏移問題
 *   2026-02-06 14:35 - 新增 *> 內嵌註解轉換、註解行 COPY 關鍵字清理
 *   2026-02-06 14:25 - 初版
 *
 * ACUCOBOL-GT 列表檔欄位格式（經分析確認）：
 *   Pos 0-5: hex address 或 6 空白 (seq area)
 *   Pos 6:   空白 (padding)
 *   Pos 7:   indicator (* 註解, 空白 正常, - 續行)
 *   Pos 8+:  code area (Area A/B)
 *
 * 清理策略：
 *   1. 移除頁首標頭行、頁首後空白行
 *   2. 移除結尾 STATISTICS 統計區段
 *   3. Strip 前 7 字元序號區 → 輸出適用 ProLeap TANDEM 格式
 *      (TANDEM: column 1 = indicator, columns 2+ = code)
 *   4. 將 COPY 語句改為註解（因列表已含展開內容）
 *   5. 將 $ 編譯器指令改為註解（$XFD, $IF, $SET 等 ACUCOBOL 專有指令）
 *   6. 將 SCREEN SECTION 內容全部註解化（ACUCOBOL GUI 定義 ProLeap 不支援）
 *   7. 將 *> 內嵌註解轉為傳統 * 註解
 *   8. 清理註解行中的 COPY/REPLACE 關鍵字
 */
package com.hiscore.cobol.cleaner;

import java.io.*;
import java.nio.charset.Charset;
import java.nio.charset.CharsetDecoder;
import java.nio.charset.CodingErrorAction;
import java.nio.file.*;
import java.util.*;
import java.util.regex.*;

public class AcuListingCleaner {

    // 列表序號區長度：6 hex/spaces + 1 padding space = 7
    private static final int SEQ_AREA_LENGTH = 7;

    // 頁首標頭模式
    private static final Pattern PAGE_HEADER_PATTERN =
            Pattern.compile(".*ACUCOBOL-GT.*Page:\\s*\\d+.*");

    // COPY 語句模式（strip 後的行，TANDEM 格式：column 1 = indicator, column 2+ = code）
    // 匹配：空白(indicator) + 可選空白 + COPY + 空白 + 內容
    private static final Pattern COPY_PATTERN =
            Pattern.compile("^\\s(\\s*COPY\\s+.*)$");

    // *> 內嵌註解模式（strip 後的行，TANDEM 格式）
    // 匹配：空白(indicator) + *> + 可選內容
    private static final Pattern INLINE_COMMENT_PATTERN =
            Pattern.compile("^\\s\\*>(.*)$");

    // Copybook 標頭行模式：展開的 copybook 含文字標頭非合法 COBOL
    // 匹配：空白(indicator) + 檔名（如 ACUGUI.DEF、HRRCB1IF.scr）
    private static final Pattern COPYBOOK_HEADER_PATTERN =
            Pattern.compile("^\\s[A-Za-z0-9_-]+\\.[A-Za-z]{2,4}(\\s.*|$)");

    // Copybook 說明文字模式：Copyright、Last modified 等非 COBOL 行
    private static final Pattern COPYBOOK_TEXT_PATTERN =
            Pattern.compile("^\\s.*(Copyright|Last modified|generated from" +
                    "|DO NOT modify|This is a generated file" +
                    "|Users of ACUCOBOL|may freely include).*$", Pattern.CASE_INSENSITIVE);

    // 非 COBOL 描述文字模式：含小寫單字 4+ 字元（COBOL 傳統全大寫）
    // 匹配：「MOUSE-FLAGS settings」「Mouse handling variables」等 copybook 標頭
    private static final Pattern LOWERCASE_WORD_PATTERN =
            Pattern.compile("^\\s.*\\b[a-z]{4,}\\b.*$");

    // 混合大小寫單字模式：大寫開頭+小寫 3+ 字元（如 Windows, Mouse, Command）
    // COBOL 識別字全大寫，混合大小寫 = 英文描述文字
    private static final Pattern MIXED_CASE_PATTERN =
            Pattern.compile("^\\s.*\\b[A-Z][a-z]{3,}\\b.*$");

    // STATISTICS 區段起始
    private static final String STATISTICS_MARKER = "STATISTICS";

    /**
     * 清理 ACUCOBOL-GT 列表檔，輸出純 COBOL 原始碼（TANDEM 格式）
     */
    public CleanResult clean(Path inputLstPath, Path outputCblPath, Charset charset) throws IOException {
        List<String> inputLines = readLinesLenient(inputLstPath, charset);
        List<String> outputLines = new ArrayList<>();

        int removedHeaders = 0;
        int removedBlanks = 0;
        int commentedCopys = 0;
        int commentedDollarDirectives = 0;
        int commentedScreenLines = 0;
        int convertedInlineComments = 0;
        int sanitizedComments = 0;
        int statisticsLinesRemoved = 0;
        boolean inStatistics = false;
        boolean inScreenSection = false;
        boolean inDataDivision = false;
        int blankAfterHeader = 0;

        for (int i = 0; i < inputLines.size(); i++) {
            String line = inputLines.get(i);

            // 1. 檢查 STATISTICS 區段
            if (!inStatistics && line.trim().equals(STATISTICS_MARKER)) {
                inStatistics = true;
                statisticsLinesRemoved++;
                continue;
            }
            if (inStatistics) {
                statisticsLinesRemoved++;
                continue;
            }

            // 2. 檢查頁首標頭
            if (PAGE_HEADER_PATTERN.matcher(line).matches()) {
                removedHeaders++;
                blankAfterHeader = 2;
                continue;
            }

            // 3. 移除頁首後的空白行
            if (blankAfterHeader > 0 && line.trim().isEmpty()) {
                blankAfterHeader--;
                removedBlanks++;
                continue;
            }
            blankAfterHeader = 0;

            // 4. Strip 前 7 字元序號區（轉為 TANDEM 格式）
            String stripped = stripSeqArea(line);

            // 5. 處理 COPY 語句 → 轉為 * 註解
            Matcher copyMatcher = COPY_PATTERN.matcher(stripped);
            if (copyMatcher.matches()) {
                // 將 indicator (column 1) 改為 '*'，使整行成為註解
                String copyContent = copyMatcher.group(1);
                outputLines.add("*" + copyContent);
                commentedCopys++;
                continue;
            }

            // 6. 處理 ACUCOBOL-GT $ 編譯器指令 ($XFD, $IF, $SET 等) → 轉為 * 註解
            //    strip 後格式：空白(indicator) + $XFD...
            if (stripped.length() >= 2 && stripped.charAt(0) == ' '
                    && stripped.substring(1).trim().startsWith("$")) {
                outputLines.add("*" + stripped.substring(1));
                commentedDollarDirectives++;
                continue;
            }

            // 7. 取得 code area 內容（去除 indicator 後 trim）
            String trimmedCode = stripped.length() > 1 ? stripped.substring(1).trim() : "";

            // 追蹤 DATA/PROCEDURE DIVISION 狀態（用於 copybook 標頭偵測）
            if (trimmedCode.startsWith("DATA") && trimmedCode.contains("DIVISION")) {
                inDataDivision = true;
            } else if (trimmedCode.startsWith("PROCEDURE") && trimmedCode.contains("DIVISION")) {
                inDataDivision = false;
            }

            // 8. Copybook 標頭 / 說明文字行 → 註解化
            //    展開的 copybook 頂部含有檔名行（如 ACUGUI.DEF）和
            //    說明文字（Copyright 等），非合法 COBOL，會導致解析中斷
            //    - 檔名模式（WORD.EXT）和 Copyright 等：全域偵測
            //    - 含小寫文字（非 COBOL）：僅在 DATA DIVISION 內偵測
            boolean hasNonCobolText = LOWERCASE_WORD_PATTERN.matcher(stripped).matches()
                    || MIXED_CASE_PATTERN.matcher(stripped).matches();
            boolean hasQuotes = stripped.contains("\"") || stripped.contains("'");
            String strUpper = stripped.toUpperCase();
            boolean hasCobolDataSyntax = strUpper.contains("PIC ")
                    || strUpper.contains("VALUE ") || strUpper.contains("SECTION")
                    || strUpper.contains("DIVISION");
            if (COPYBOOK_HEADER_PATTERN.matcher(stripped).matches()
                    || COPYBOOK_TEXT_PATTERN.matcher(stripped).matches()
                    || (inDataDivision && hasNonCobolText
                        && (!hasQuotes || !hasCobolDataSyntax))) {
                outputLines.add("*" + (stripped.length() > 1 ? stripped.substring(1) : ""));
                sanitizedComments++;
                continue;
            }

            // 9. SCREEN SECTION 註解化
            //    ACUCOBOL 的 SCREEN SECTION 含 GUI 定義（Frame, Label, FONT 等），
            //    ProLeap 完全不支援，需全部註解化以解除 PROCEDURE DIVISION 解析阻塞
            if (!inScreenSection && trimmedCode.startsWith("SCREEN")
                    && trimmedCode.contains("SECTION")) {
                inScreenSection = true;
                outputLines.add("* [SCREEN SECTION - ACUCOBOL GUI definitions commented for ProLeap]");
                commentedScreenLines++;
                continue;
            }
            if (inScreenSection) {
                if (trimmedCode.startsWith("PROCEDURE") && trimmedCode.contains("DIVISION")) {
                    inScreenSection = false;
                    outputLines.add(stripped); // 保留 PROCEDURE DIVISION 行
                } else {
                    // 註解化所有非註解行
                    if (stripped.length() >= 1 && stripped.charAt(0) != '*') {
                        outputLines.add("*" + (stripped.length() > 1 ? stripped.substring(1) : ""));
                    } else {
                        outputLines.add(stripped);
                    }
                    commentedScreenLines++;
                }
                continue;
            }

            // 9. 處理 *> 內嵌註解 → 轉為傳統 * 註解
            Matcher inlineMatcher = INLINE_COMMENT_PATTERN.matcher(stripped);
            if (inlineMatcher.matches()) {
                String commentText = inlineMatcher.group(1);
                outputLines.add("*" + commentText);
                convertedInlineComments++;
                continue;
            }

            // 10. 清理註解行中的前處理器關鍵字（TANDEM: column 1 = indicator）
            if (stripped.length() >= 1 && stripped.charAt(0) == '*') {
                String sanitized = sanitizeCommentLine(stripped);
                if (!sanitized.equals(stripped)) sanitizedComments++;
                outputLines.add(sanitized);
                continue;
            }

            // 11. 保留一般行
            outputLines.add(stripped);
        }

        // 以 UTF-8 寫入（ProLeap 預設讀取 UTF-8）
        Files.createDirectories(outputCblPath.getParent());
        Files.write(outputCblPath, outputLines, java.nio.charset.StandardCharsets.UTF_8);

        return new CleanResult(
                inputLines.size(), outputLines.size(),
                removedHeaders, removedBlanks, commentedCopys,
                commentedDollarDirectives, commentedScreenLines,
                convertedInlineComments, sanitizedComments,
                statisticsLinesRemoved
        );
    }

    // TANDEM 合法的 indicator 字元
    private static final String VALID_INDICATORS = " *-Dd/";

    /**
     * 去除列表序號區（前 7 字元），轉為 TANDEM 格式
     * TANDEM: column 1 = indicator, columns 2+ = code
     *
     * 若 strip 後第一字元不是合法 indicator，自動補上空白
     * （列表中展開的 copybook 內容可能沒有 indicator column）
     */
    private String stripSeqArea(String line) {
        if (line.length() <= SEQ_AREA_LENGTH) {
            return line.trim().isEmpty() ? "" : " " + line.trim();
        }
        String stripped = line.substring(SEQ_AREA_LENGTH);
        if (stripped.isEmpty()) return "";

        char firstChar = stripped.charAt(0);
        if (VALID_INDICATORS.indexOf(firstChar) < 0) {
            // 第一字元不是合法 indicator，補上空白使其成為 TANDEM 正常行
            stripped = " " + stripped;
        }
        return stripped;
    }

    /**
     * 清理註解行中的前處理器關鍵字
     */
    private String sanitizeCommentLine(String line) {
        if (line.length() <= 1) return line;
        String prefix = line.substring(0, 1); // '*' indicator
        String content = line.substring(1);
        content = content.replaceAll("\\bCOPY\\b", "C-PY");
        content = content.replaceAll("\\bREPLACE\\b", "REPL-CE");
        return prefix + content;
    }

    /**
     * 容錯模式讀取檔案
     */
    private List<String> readLinesLenient(Path path, Charset charset) throws IOException {
        CharsetDecoder decoder = charset.newDecoder()
                .onMalformedInput(CodingErrorAction.REPLACE)
                .onUnmappableCharacter(CodingErrorAction.REPLACE);

        List<String> lines = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(
                new InputStreamReader(Files.newInputStream(path), decoder))) {
            String line;
            while ((line = reader.readLine()) != null) {
                lines.add(line);
            }
        }
        return lines;
    }

    /**
     * 清理結果統計
     */
    public static class CleanResult {
        public final int totalInputLines;
        public final int totalOutputLines;
        public final int removedHeaders;
        public final int removedBlanks;
        public final int commentedCopys;
        public final int commentedDollarDirectives;
        public final int commentedScreenLines;
        public final int convertedInlineComments;
        public final int sanitizedComments;
        public final int statisticsLinesRemoved;

        public CleanResult(int totalInputLines, int totalOutputLines,
                           int removedHeaders, int removedBlanks,
                           int commentedCopys, int commentedDollarDirectives,
                           int commentedScreenLines, int convertedInlineComments,
                           int sanitizedComments, int statisticsLinesRemoved) {
            this.totalInputLines = totalInputLines;
            this.totalOutputLines = totalOutputLines;
            this.removedHeaders = removedHeaders;
            this.removedBlanks = removedBlanks;
            this.commentedCopys = commentedCopys;
            this.commentedDollarDirectives = commentedDollarDirectives;
            this.commentedScreenLines = commentedScreenLines;
            this.convertedInlineComments = convertedInlineComments;
            this.sanitizedComments = sanitizedComments;
            this.statisticsLinesRemoved = statisticsLinesRemoved;
        }

        @Override
        public String toString() {
            return String.format(
                    "=== 清理結果 ===\n" +
                    "輸入行數：%d\n" +
                    "輸出行數：%d\n" +
                    "移除頁首：%d\n" +
                    "移除空白行：%d\n" +
                    "註解化 COPY：%d\n" +
                    "註解化 $ 指令：%d\n" +
                    "註解化 SCREEN SECTION：%d\n" +
                    "*> 轉傳統註解：%d\n" +
                    "註解關鍵字清理：%d\n" +
                    "移除統計行：%d",
                    totalInputLines, totalOutputLines,
                    removedHeaders, removedBlanks,
                    commentedCopys, commentedDollarDirectives,
                    commentedScreenLines, convertedInlineComments,
                    sanitizedComments, statisticsLinesRemoved
            );
        }
    }

    /**
     * 命令列入口
     */
    public static void main(String[] args) throws IOException {
        if (args.length < 1) {
            System.out.println("用法: java AcuListingCleaner <input.lst> [output.cbl] [charset]");
            return;
        }

        Path inputPath = Paths.get(args[0]);
        Path outputPath = args.length >= 2
                ? Paths.get(args[1])
                : inputPath.getParent().resolveSibling("cbl").resolve(
                        inputPath.getFileName().toString().replaceFirst("\\.[^.]+$", ".cbl"));

        Charset charset = Charset.forName(args.length >= 3 ? args[2] : "MS950");

        AcuListingCleaner cleaner = new AcuListingCleaner();
        CleanResult result = cleaner.clean(inputPath, outputPath, charset);
        System.out.println(result);
    }
}
