/**
 * 更新時間：2026-02-06 15:01
 * 作者：AI Assistant
 * 摘要：ACUCOBOL-GT 程式遷移參考書產生器（help_book）
 *       從 .lst 列表檔提取完整的程式結構，產出 Markdown 遷移參考文件
 *
 * 更新歷程：
 *   2026-02-06 15:01 - 初版：支援 SELECT/FD/COPY/CALL/Screen Section/Paragraph 分析
 */
package com.hiscore.cobol.migration;

import java.io.*;
import java.nio.charset.Charset;
import java.nio.charset.CharsetDecoder;
import java.nio.charset.CodingErrorAction;
import java.nio.file.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.regex.*;
import java.util.stream.Collectors;

/**
 * ACUCOBOL-GT 程式遷移參考書（Migration Help Book）產生器
 *
 * 從原始列表檔(.lst)以文字分析方式提取：
 * - 程式識別資訊（PROGRAM-ID）
 * - 檔案清單（SELECT / FD）
 * - COPY 相依性
 * - 外部呼叫（CALL）
 * - 資料結構摘要
 * - 段落/區段清單（PROCEDURE DIVISION）
 * - ACUCOBOL 特有功能（Screen Section / GUI）
 * - 遷移風險與建議
 */
public class MigrationGuideGenerator {

    // ===== Regex Patterns =====
    private static final Pattern PAGE_HEADER = Pattern.compile(".*ACUCOBOL-GT.*Page:\\s*\\d+.*");
    private static final Pattern PROGRAM_ID = Pattern.compile("\\bPROGRAM-ID\\.?\\s+([\\w-]+)", Pattern.CASE_INSENSITIVE);
    private static final Pattern SELECT_STMT = Pattern.compile("\\bSELECT\\s+([\\w-]+)", Pattern.CASE_INSENSITIVE);
    private static final Pattern ASSIGN_TO = Pattern.compile("\\bASSIGN\\s+TO\\s+(\\w+)\\s+\"([^\"]+)\"", Pattern.CASE_INSENSITIVE);
    private static final Pattern ORGANIZATION = Pattern.compile("\\bORGANIZATION\\s+IS\\s+(\\w+)", Pattern.CASE_INSENSITIVE);
    private static final Pattern ACCESS_MODE = Pattern.compile("\\bACCESS\\s+(?:MODE\\s+(?:IS\\s+)?)?(SEQUENTIAL|RANDOM|DYNAMIC)", Pattern.CASE_INSENSITIVE);
    private static final Pattern RECORD_KEY = Pattern.compile("\\bRECORD\\s+KEY\\s+(?:IS\\s+)?([\\w-]+)", Pattern.CASE_INSENSITIVE);
    private static final Pattern ALTERNATE_KEY = Pattern.compile("\\bALTERNATE\\s+(?:RECORD\\s+)?KEY\\s+(?:IS\\s+)?([\\w-]+)", Pattern.CASE_INSENSITIVE);
    private static final Pattern FD_ENTRY = Pattern.compile("^\\s*FD\\s+([\\w-]+)", Pattern.CASE_INSENSITIVE);
    private static final Pattern COPY_STMT = Pattern.compile("\\bCOPY\\s+\"([^\"]+)\"", Pattern.CASE_INSENSITIVE);
    private static final Pattern CALL_STMT = Pattern.compile("\\bCALL\\s+\"([^\"]+)\"", Pattern.CASE_INSENSITIVE);
    private static final Pattern CALL_USING = Pattern.compile("\\bCALL\\s+\"([^\"]+)\"\\s+USING\\s+(.*)", Pattern.CASE_INSENSITIVE);
    private static final Pattern LEVEL_01 = Pattern.compile("^\\s*01\\s+([\\w-]+)", Pattern.CASE_INSENSITIVE);
    // DATA_ITEM 備用（未來詳細分析用）
    // private static final Pattern DATA_ITEM = Pattern.compile("^\\s*(\\d{2})\\s+([\\w-]+)\\s+PIC\\s+(.+?)(?:\\s|\\.|$)", Pattern.CASE_INSENSITIVE);
    private static final Pattern SCREEN_SECTION = Pattern.compile("\\bSCREEN\\s+SECTION", Pattern.CASE_INSENSITIVE);
    // SCREEN_CONTROL 備用（未來詳細分析用）
    // private static final Pattern SCREEN_CONTROL = Pattern.compile("\\bSCREEN-CONTROL\\b", Pattern.CASE_INSENSITIVE);
    private static final Pattern GUI_VERB = Pattern.compile("\\b(CREATE|DESTROY|MODIFY|INQUIRE)\\s+([\\w-]+)", Pattern.CASE_INSENSITIVE);
    private static final Pattern DIVISION = Pattern.compile("^\\s*([\\w-]+)\\s+DIVISION", Pattern.CASE_INSENSITIVE);
    private static final Pattern SECTION_DECL = Pattern.compile("^\\s{1,7}([\\w-]+)\\s+SECTION\\s*\\.?", Pattern.CASE_INSENSITIVE);
    private static final Pattern PARAGRAPH_DECL = Pattern.compile("^\\s{1,7}([A-Z][\\w-]*)\\.\\s*$", Pattern.CASE_INSENSITIVE);
    // PERFORM_STMT 備用（未來呼叫關係圖用）
    // private static final Pattern PERFORM_STMT = Pattern.compile("\\bPERFORM\\s+([A-Z][\\w-]+)", Pattern.CASE_INSENSITIVE);
    private static final Pattern COMPRESSION = Pattern.compile("\\bWITH\\s+COMPRESSION\\b", Pattern.CASE_INSENSITIVE);
    private static final Pattern LOCK_MODE = Pattern.compile("\\bLOCK\\s+(MANUAL|AUTOMATIC)\\b", Pattern.CASE_INSENSITIVE);
    private static final Pattern FILE_STATUS = Pattern.compile("\\bFILE\\s+STATUS\\s+(?:IS\\s+)?([\\w-]+)", Pattern.CASE_INSENSITIVE);
    private static final Pattern IS_EXTERNAL = Pattern.compile("\\bIS\\s+EXTERNAL\\b|\\bEXTERNAL\\b", Pattern.CASE_INSENSITIVE);
    private static final Pattern STATISTICS_MARKER = Pattern.compile("^STATISTICS\\s*$");
    // WORKING_STORAGE 備用
    // private static final Pattern WORKING_STORAGE = Pattern.compile("\\bWORKING-STORAGE\\s+SECTION", Pattern.CASE_INSENSITIVE);
    private static final Pattern LINKAGE_SECTION = Pattern.compile("\\bLINKAGE\\s+SECTION", Pattern.CASE_INSENSITIVE);
    private static final Pattern PROCEDURE_DIV = Pattern.compile("\\bPROCEDURE\\s+DIVISION", Pattern.CASE_INSENSITIVE);

    // ===== Data Models =====

    /** 檔案定義（SELECT + FD 合併） */
    public static class FileDefinition {
        String selectName;
        String assignType;      // DISK, PRINT, etc.
        String assignFile;      // 實體檔案名稱
        String organization;    // INDEXED, SEQUENTIAL, RELATIVE
        String accessMode;      // SEQUENTIAL, RANDOM, DYNAMIC
        String recordKey;
        List<String> alternateKeys = new ArrayList<>();
        boolean hasCompression;
        String lockMode;
        String fileStatus;
        boolean isExternal;
        String fdName;
        int selectLineNum;
        List<String> copyFiles = new ArrayList<>();
    }

    /** COPY 相依項 */
    public static class CopyDependency {
        String copyName;
        String context;     // SELECT, FD, WS, etc.
        int lineNum;
    }

    /** CALL 呼叫 */
    public static class CallReference {
        String programName;
        String usingClause;
        int lineNum;
        boolean inComment;
    }

    /** GUI 控制項 */
    public static class GuiControl {
        String verb;        // CREATE, DESTROY, MODIFY, INQUIRE
        String controlName;
        int lineNum;
        boolean inComment;
    }

    /** Paragraph/Section 定義 */
    public static class ProcedureEntry {
        String name;
        String type; // SECTION or PARAGRAPH
        int lineNum;
        List<String> performTargets = new ArrayList<>();
    }

    // ===== Main Analysis =====

    /**
     * 產生遷移參考書（Markdown 格式）
     */
    public void generate(Path inputLstPath, Path outputMdPath, Charset charset) throws IOException {
        List<String> lines = readLinesLenient(inputLstPath, charset);
        String fileName = inputLstPath.getFileName().toString();
        String baseName = fileName.contains(".") ? fileName.substring(0, fileName.lastIndexOf('.')) : fileName;

        // 分析各面向
        String programId = extractProgramId(lines);
        List<FileDefinition> files = extractFileDefinitions(lines);
        List<CopyDependency> copies = extractCopyDependencies(lines);
        List<CallReference> calls = extractCallReferences(lines);
        List<GuiControl> guiControls = extractGuiControls(lines);
        List<ProcedureEntry> procedures = extractProcedures(lines);
        Map<String, Integer> divisionLines = findDivisionLines(lines);
        List<String> level01Items = extractLevel01Items(lines);
        boolean hasScreenSection = hasScreenSection(lines);
        boolean hasLinkageSection = hasLinkageSection(lines);
        int totalLines = lines.size();

        // 產生 Markdown
        StringBuilder md = new StringBuilder();
        String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));

        // === Header ===
        md.append("# ").append(baseName).append(" 遷移參考書 (Migration Help Book)\n\n");
        md.append("> 產生時間：").append(timestamp).append("\n");
        md.append("> 來源檔案：").append(fileName).append("\n");
        md.append("> 列表總行數：").append(totalLines).append("\n\n");
        md.append("---\n\n");

        // === 1. 程式概要 ===
        md.append("## 1. 程式概要\n\n");
        md.append("| 項目 | 值 |\n|------|----|\n");
        md.append("| PROGRAM-ID | **").append(programId != null ? programId : "(未辨識)").append("** |\n");
        md.append("| 列表檔 | ").append(fileName).append(" |\n");
        md.append("| 原始碼行數 | ").append(totalLines).append(" |\n");
        md.append("| 檔案定義數 | ").append(files.size()).append(" |\n");
        md.append("| COPY 相依數 | ").append(copies.size()).append(" |\n");
        md.append("| 外部呼叫數 | ").append(calls.stream().filter(c -> !c.inComment).count()).append(" |\n");
        md.append("| 段落/區段數 | ").append(procedures.size()).append(" |\n");
        md.append("| GUI 操作數 | ").append(guiControls.stream().filter(g -> !g.inComment).count()).append(" |\n");
        md.append("| Screen Section | ").append(hasScreenSection ? "有" : "無").append(" |\n");
        md.append("| Linkage Section | ").append(hasLinkageSection ? "有" : "無").append(" |\n\n");

        // Division 行號
        if (!divisionLines.isEmpty()) {
            md.append("### Division 位置\n\n");
            md.append("| Division | 行號 |\n|----------|------|\n");
            for (Map.Entry<String, Integer> entry : divisionLines.entrySet()) {
                md.append("| ").append(entry.getKey()).append(" | ").append(entry.getValue()).append(" |\n");
            }
            md.append("\n");
        }

        // === 2. 檔案清單 ===
        md.append("## 2. 檔案清單 (File Inventory)\n\n");
        if (files.isEmpty()) {
            md.append("（未偵測到檔案定義）\n\n");
        } else {
            md.append("共 **").append(files.size()).append("** 個檔案定義\n\n");
            md.append("| # | SELECT 名稱 | 實體檔案 | 組織 | 存取模式 | Key | 壓縮 | Lock | External |\n");
            md.append("|---|-------------|----------|------|----------|-----|------|------|----------|\n");
            int idx = 0;
            for (FileDefinition fd : files) {
                idx++;
                md.append("| ").append(idx);
                md.append(" | ").append(fd.selectName);
                md.append(" | ").append(fd.assignFile != null ? fd.assignFile : "-");
                md.append(" | ").append(fd.organization != null ? fd.organization : "-");
                md.append(" | ").append(fd.accessMode != null ? fd.accessMode : "-");
                md.append(" | ").append(fd.recordKey != null ? fd.recordKey : "-");
                md.append(" | ").append(fd.hasCompression ? "Y" : "-");
                md.append(" | ").append(fd.lockMode != null ? fd.lockMode : "-");
                md.append(" | ").append(fd.isExternal ? "Y" : "-");
                md.append(" |\n");
            }
            md.append("\n");

            // 詳細檔案資訊（含 Alternate Keys）
            boolean hasAlternateKeys = files.stream().anyMatch(f -> !f.alternateKeys.isEmpty());
            if (hasAlternateKeys) {
                md.append("### 替代鍵 (Alternate Keys)\n\n");
                for (FileDefinition fd : files) {
                    if (!fd.alternateKeys.isEmpty()) {
                        md.append("- **").append(fd.selectName).append("**: ");
                        md.append(String.join(", ", fd.alternateKeys)).append("\n");
                    }
                }
                md.append("\n");
            }

            // ACUCOBOL 特殊檔案屬性
            md.append("### ACUCOBOL-GT 特殊檔案屬性（遷移注意）\n\n");
            md.append("以下屬性為 ACUCOBOL-GT 特有，遷移時需特別處理：\n\n");
            md.append("| 特性 | 說明 | 影響的檔案 | 遷移建議 |\n");
            md.append("|------|------|------------|----------|\n");

            List<String> compFiles = files.stream()
                    .filter(f -> f.hasCompression).map(f -> f.selectName)
                    .collect(Collectors.toList());
            md.append("| ASSIGN TO DISK | ACUCOBOL 磁碟檔案指定語法 | 全部 | 改為標準 ASSIGN TO 或環境設定 |\n");
            if (!compFiles.isEmpty()) {
                md.append("| WITH COMPRESSION | ACUCOBOL 內建壓縮 | ").append(String.join(", ", compFiles))
                  .append(" | 移除或改用外部壓縮方案 |\n");
            }
            List<String> lockFiles = files.stream()
                    .filter(f -> f.lockMode != null).map(f -> f.selectName + "(" + f.lockMode + ")")
                    .collect(Collectors.toList());
            if (!lockFiles.isEmpty()) {
                md.append("| LOCK MANUAL/AUTOMATIC | ACUCOBOL 鎖定模式 | ").append(String.join(", ", lockFiles))
                  .append(" | 依目標平台調整鎖定策略 |\n");
            }
            md.append("\n");
        }

        // === 3. COPY 相依性 ===
        md.append("## 3. COPY 相依性 (Copybook Dependencies)\n\n");
        if (copies.isEmpty()) {
            md.append("（未偵測到 COPY 語句）\n\n");
        } else {
            // 去重並分類
            Map<String, List<CopyDependency>> byName = new LinkedHashMap<>();
            for (CopyDependency c : copies) {
                byName.computeIfAbsent(c.copyName, k -> new ArrayList<>()).add(c);
            }
            md.append("共 **").append(copies.size()).append("** 個 COPY 語句，涵蓋 **")
              .append(byName.size()).append("** 個不同 copybook\n\n");

            // 依副檔名分類
            Map<String, List<String>> byExt = new TreeMap<>();
            for (String name : byName.keySet()) {
                String ext = name.contains(".") ? name.substring(name.lastIndexOf('.') + 1).toUpperCase() : "(無副檔名)";
                byExt.computeIfAbsent(ext, k -> new ArrayList<>()).add(name);
            }

            md.append("### 依類型分類\n\n");
            for (Map.Entry<String, List<String>> entry : byExt.entrySet()) {
                String ext = entry.getKey();
                String desc = switch (ext) {
                    case "SEL" -> "SELECT 定義";
                    case "WS" -> "Working-Storage 定義";
                    case "FD" -> "File Description 定義";
                    case "SL" -> "Screen/Layout 定義";
                    case "PS" -> "Procedure Section 定義";
                    case "DEF" -> "常數/定義";
                    default -> ext + " 類型";
                };
                md.append("#### ").append(ext).append(" — ").append(desc)
                  .append(" (").append(entry.getValue().size()).append(" 個)\n\n");
                for (String name : entry.getValue()) {
                    List<CopyDependency> refs = byName.get(name);
                    md.append("- `").append(name).append("` — 引用 ").append(refs.size()).append(" 次");
                    if (refs.size() <= 3) {
                        md.append(" (行: ").append(
                                refs.stream().map(r -> String.valueOf(r.lineNum)).collect(Collectors.joining(", "))
                        ).append(")");
                    }
                    md.append("\n");
                }
                md.append("\n");
            }
        }

        // === 4. 外部呼叫 ===
        md.append("## 4. 外部程式呼叫 (External CALLs)\n\n");
        List<CallReference> activeCalls = calls.stream().filter(c -> !c.inComment).collect(Collectors.toList());
        List<CallReference> commentedCalls = calls.stream().filter(c -> c.inComment).collect(Collectors.toList());

        if (activeCalls.isEmpty() && commentedCalls.isEmpty()) {
            md.append("（未偵測到 CALL 語句）\n\n");
        } else {
            if (!activeCalls.isEmpty()) {
                md.append("### 有效呼叫\n\n");
                md.append("| 程式名稱 | USING 參數 | 行號 |\n");
                md.append("|----------|------------|------|\n");
                for (CallReference c : activeCalls) {
                    md.append("| ").append(c.programName);
                    md.append(" | ").append(c.usingClause != null ? c.usingClause : "-");
                    md.append(" | ").append(c.lineNum).append(" |\n");
                }
                md.append("\n");
            }

            if (!commentedCalls.isEmpty()) {
                // 去重
                Map<String, Long> commentedCallCounts = commentedCalls.stream()
                        .collect(Collectors.groupingBy(c -> c.programName, Collectors.counting()));
                md.append("### 註解中的呼叫參考（歷史/備用程式）\n\n");
                md.append("| 程式名稱 | 出現次數 |\n|----------|----------|\n");
                for (Map.Entry<String, Long> entry : commentedCallCounts.entrySet()) {
                    md.append("| ").append(entry.getKey()).append(" | ").append(entry.getValue()).append(" |\n");
                }
                md.append("\n");
            }
        }

        // === 5. 資料結構摘要 ===
        md.append("## 5. 資料結構摘要 (Data Structure Summary)\n\n");
        if (!level01Items.isEmpty()) {
            md.append("### 01-Level 項目（共 ").append(level01Items.size()).append(" 個）\n\n");
            // 分類：FD record vs WS
            md.append("| # | 項目名稱 | 備註 |\n");
            md.append("|---|----------|------|\n");
            int itemIdx = 0;
            for (String item : level01Items) {
                itemIdx++;
                String note = "";
                // 嘗試判斷是否為 FD record
                for (FileDefinition fd : files) {
                    if (item.toUpperCase().contains(fd.selectName.replace("-MST", "").replace("-TMP", ""))) {
                        note = "FD " + fd.selectName + " record";
                        break;
                    }
                }
                md.append("| ").append(itemIdx).append(" | ").append(item)
                  .append(" | ").append(note).append(" |\n");
                if (itemIdx >= 200) {
                    md.append("| ... | 還有 ").append(level01Items.size() - 200).append(" 個項目 | |\n");
                    break;
                }
            }
            md.append("\n");
        }

        // === 6. PROCEDURE DIVISION 結構 ===
        md.append("## 6. PROCEDURE DIVISION 結構\n\n");
        if (procedures.isEmpty()) {
            md.append("（未偵測到段落或區段定義）\n\n");
        } else {
            List<ProcedureEntry> sections = procedures.stream()
                    .filter(p -> "SECTION".equals(p.type)).collect(Collectors.toList());
            List<ProcedureEntry> paragraphs = procedures.stream()
                    .filter(p -> "PARAGRAPH".equals(p.type)).collect(Collectors.toList());

            md.append("共 **").append(sections.size()).append("** 個 Section, **")
              .append(paragraphs.size()).append("** 個 Paragraph\n\n");

            if (!sections.isEmpty()) {
                md.append("### Sections\n\n");
                md.append("| # | Section 名稱 | 行號 |\n|---|-------------|------|\n");
                int sIdx = 0;
                for (ProcedureEntry s : sections) {
                    sIdx++;
                    md.append("| ").append(sIdx).append(" | ").append(s.name)
                      .append(" | ").append(s.lineNum).append(" |\n");
                }
                md.append("\n");
            }

            if (!paragraphs.isEmpty()) {
                md.append("### Paragraphs\n\n");
                md.append("<details><summary>展開全部 ").append(paragraphs.size()).append(" 個段落</summary>\n\n");
                md.append("| # | Paragraph 名稱 | 行號 |\n|---|---------------|------|\n");
                int pIdx = 0;
                for (ProcedureEntry p : paragraphs) {
                    pIdx++;
                    md.append("| ").append(pIdx).append(" | ").append(p.name)
                      .append(" | ").append(p.lineNum).append(" |\n");
                }
                md.append("\n</details>\n\n");
            }
        }

        // === 7. ACUCOBOL-GT GUI 功能 ===
        md.append("## 7. ACUCOBOL-GT GUI 功能分析\n\n");
        if (!hasScreenSection && guiControls.isEmpty()) {
            md.append("（未偵測到 GUI 相關功能）\n\n");
        } else {
            if (hasScreenSection) {
                md.append("### Screen Section\n\n");
                md.append("本程式包含 **SCREEN SECTION**，使用 ACUCOBOL-GT 的圖形化 Screen 定義。\n");
                md.append("此功能為 ACUCOBOL 特有，遷移時需要：\n\n");
                md.append("1. 改用目標平台的 UI 框架（如 Web UI、WPF、Java Swing）\n");
                md.append("2. 或使用 COBOL Screen Section 轉換工具\n\n");
            }

            List<GuiControl> activeGui = guiControls.stream().filter(g -> !g.inComment).collect(Collectors.toList());
            if (!activeGui.isEmpty()) {
                md.append("### GUI 操作清單\n\n");
                md.append("| 操作 | 控制項 | 行號 |\n|------|--------|------|\n");
                for (GuiControl g : activeGui) {
                    md.append("| ").append(g.verb.toUpperCase()).append(" | ").append(g.controlName)
                      .append(" | ").append(g.lineNum).append(" |\n");
                }
                md.append("\n");
            }
        }

        // === 8. 遷移風險評估 ===
        md.append("## 8. 遷移風險評估\n\n");
        md.append("### 風險矩陣\n\n");
        md.append("| 風險等級 | 項目 | 說明 | 遷移建議 |\n");
        md.append("|----------|------|------|----------|\n");

        // Screen Section = 高風險
        if (hasScreenSection) {
            md.append("| **高** | Screen Section GUI | ACUCOBOL 特有的圖形化畫面定義 | 需完整改寫為目標平台 UI |\n");
        }
        // GUI Controls = 高風險
        if (!guiControls.stream().filter(g -> !g.inComment).collect(Collectors.toList()).isEmpty()) {
            md.append("| **高** | GUI 控制項操作 | CREATE/DESTROY/MODIFY/INQUIRE | 需改用目標平台 API |\n");
        }
        // W$FONT = 中風險
        if (activeCalls.stream().anyMatch(c -> c.programName.startsWith("W$"))) {
            md.append("| **中** | ACUCOBOL 系統 CALL | W$FONT 等 ACUCOBOL 特有 API | 需找替代方案或移除 |\n");
        }
        // ASSIGN TO DISK = 中風險
        md.append("| **中** | ASSIGN TO DISK | ACUCOBOL 檔案指派語法 | 改為標準 ASSIGN 或使用環境變數 |\n");
        // WITH COMPRESSION = 中風險
        if (files.stream().anyMatch(f -> f.hasCompression)) {
            md.append("| **中** | WITH COMPRESSION | ACUCOBOL 檔案壓縮 | 移除或改用 OS 層級壓縮 |\n");
        }
        // LOCK mode = 低風險
        if (files.stream().anyMatch(f -> f.lockMode != null)) {
            md.append("| **低** | LOCK 模式 | 檔案鎖定策略 | 依目標平台調整 |\n");
        }
        // EXTERNAL = 低風險
        if (files.stream().anyMatch(f -> f.isExternal)) {
            md.append("| **低** | IS EXTERNAL | 外部共用檔案定義 | 驗證目標編譯器支援 |\n");
        }
        // COPY 相依 = 低風險
        md.append("| **低** | COPY 相依性 | ").append(copies.size()).append(" 個 copybook 引用 | 確保所有 copybook 遷移 |\n");
        md.append("\n");

        // === 9. 遷移檢核清單 ===
        md.append("## 9. 遷移檢核清單 (Migration Checklist)\n\n");
        md.append("- [ ] 確認目標 COBOL 編譯器 / 平台\n");
        md.append("- [ ] 收集所有 ").append(copies.stream().map(c -> c.copyName).distinct().count())
          .append(" 個 copybook 原始碼\n");
        md.append("- [ ] 改寫 ASSIGN TO DISK → 標準 ASSIGN 語法\n");
        if (files.stream().anyMatch(f -> f.hasCompression)) {
            md.append("- [ ] 處理 WITH COMPRESSION 替代方案\n");
        }
        if (files.stream().anyMatch(f -> f.lockMode != null)) {
            md.append("- [ ] 調整 LOCK 模式語法\n");
        }
        if (hasScreenSection) {
            md.append("- [ ] **重寫 Screen Section GUI**（最大工作量）\n");
        }
        if (activeCalls.stream().anyMatch(c -> c.programName.startsWith("W$"))) {
            md.append("- [ ] 替換 ACUCOBOL 系統 CALL（W$FONT 等）\n");
        }
        md.append("- [ ] 驗證所有 ").append(files.size()).append(" 個檔案 I/O 操作\n");
        md.append("- [ ] 單元測試所有 ").append(procedures.size()).append(" 個段落/區段\n");
        md.append("- [ ] 整合測試完整業務流程\n");
        md.append("- [ ] 效能基準比較\n\n");

        // === 10. 附錄 ===
        md.append("## 10. 附錄\n\n");
        md.append("### 產生工具資訊\n\n");
        md.append("- **工具**: HISCore COBOL Migration Guide Generator\n");
        md.append("- **來源**: ").append(inputLstPath.toAbsolutePath()).append("\n");
        md.append("- **產生時間**: ").append(timestamp).append("\n");
        md.append("- **分析方法**: 文字模式比對（regex-based），非完整語法分析\n");
        md.append("- **注意**: 因 ACUCOBOL-GT 方言差異，部分統計數據可能包含誤判，建議人工複核\n\n");

        // Write output
        Files.createDirectories(outputMdPath.getParent());
        Files.writeString(outputMdPath, md.toString(), java.nio.charset.StandardCharsets.UTF_8);

        // Print summary
        System.out.println("  遷移參考書已產生！");
        System.out.println("  輸出: " + outputMdPath.toAbsolutePath());
        System.out.println();
        System.out.println("  === 摘要 ===");
        System.out.println("  PROGRAM-ID: " + (programId != null ? programId : "(未辨識)"));
        System.out.println("  檔案定義: " + files.size());
        System.out.println("  COPY 相依: " + copies.size() + " (" +
                copies.stream().map(c -> c.copyName).distinct().count() + " 個 copybook)");
        System.out.println("  外部呼叫: " + activeCalls.size() + " (有效)");
        System.out.println("  段落/區段: " + procedures.size());
        System.out.println("  GUI 操作: " + guiControls.stream().filter(g -> !g.inComment).count());
        System.out.println("  Screen Section: " + (hasScreenSection ? "有" : "無"));
    }

    // ===== Extraction Methods =====

    private String extractProgramId(List<String> lines) {
        for (String line : lines) {
            if (PAGE_HEADER.matcher(line).matches()) continue;
            Matcher m = PROGRAM_ID.matcher(line);
            if (m.find()) return m.group(1);
        }
        return null;
    }

    /**
     * 提取 SELECT + FD 完整檔案定義
     * SELECT 區塊可能跨多行，以 '.' 結束
     */
    private List<FileDefinition> extractFileDefinitions(List<String> lines) {
        List<FileDefinition> result = new ArrayList<>();
        boolean inSelect = false;
        FileDefinition current = null;
        StringBuilder selectBlock = new StringBuilder();

        for (int i = 0; i < lines.size(); i++) {
            String line = lines.get(i);
            String trimmed = line.trim();

            // 跳過頁首和註解
            if (PAGE_HEADER.matcher(line).matches()) continue;
            if (isCommentLine(line)) continue;

            // SELECT 開始
            Matcher selectM = SELECT_STMT.matcher(trimmed);
            if (selectM.find() && !inSelect) {
                current = new FileDefinition();
                current.selectName = selectM.group(1);
                current.selectLineNum = i + 1;
                selectBlock = new StringBuilder(trimmed);
                inSelect = true;

                // 如果同一行就有 '.'
                if (trimmed.endsWith(".")) {
                    parseSelectBlock(selectBlock.toString(), current);
                    result.add(current);
                    inSelect = false;
                }
                continue;
            }

            // SELECT 續行
            if (inSelect && current != null) {
                selectBlock.append(" ").append(trimmed);
                if (trimmed.endsWith(".") || trimmed.contains(".")) {
                    parseSelectBlock(selectBlock.toString(), current);
                    result.add(current);
                    inSelect = false;
                }
                continue;
            }

            // FD 行
            Matcher fdM = FD_ENTRY.matcher(trimmed);
            if (fdM.find()) {
                String fdName = fdM.group(1);
                // 找到對應的 FileDefinition
                for (FileDefinition fd : result) {
                    if (fd.selectName.equalsIgnoreCase(fdName)) {
                        fd.fdName = fdName;
                        fd.isExternal = IS_EXTERNAL.matcher(trimmed).find();
                        break;
                    }
                }
            }
        }

        return result;
    }

    private void parseSelectBlock(String block, FileDefinition fd) {
        Matcher assignM = ASSIGN_TO.matcher(block);
        if (assignM.find()) {
            fd.assignType = assignM.group(1);
            fd.assignFile = assignM.group(2);
        }

        Matcher orgM = ORGANIZATION.matcher(block);
        if (orgM.find()) fd.organization = orgM.group(1).toUpperCase();

        Matcher accessM = ACCESS_MODE.matcher(block);
        if (accessM.find()) fd.accessMode = accessM.group(1).toUpperCase();

        Matcher keyM = RECORD_KEY.matcher(block);
        if (keyM.find()) fd.recordKey = keyM.group(1);

        Matcher altKeyM = ALTERNATE_KEY.matcher(block);
        while (altKeyM.find()) {
            fd.alternateKeys.add(altKeyM.group(1));
        }

        fd.hasCompression = COMPRESSION.matcher(block).find();

        Matcher lockM = LOCK_MODE.matcher(block);
        if (lockM.find()) fd.lockMode = lockM.group(1).toUpperCase();

        Matcher statusM = FILE_STATUS.matcher(block);
        if (statusM.find()) fd.fileStatus = statusM.group(1);
    }

    private List<CopyDependency> extractCopyDependencies(List<String> lines) {
        List<CopyDependency> result = new ArrayList<>();
        for (int i = 0; i < lines.size(); i++) {
            String line = lines.get(i);
            if (PAGE_HEADER.matcher(line).matches()) continue;
            Matcher m = COPY_STMT.matcher(line);
            while (m.find()) {
                CopyDependency cd = new CopyDependency();
                cd.copyName = m.group(1);
                cd.lineNum = i + 1;
                cd.context = guessContext(line, i, lines);
                result.add(cd);
            }
        }
        return result;
    }

    private String guessContext(String line, int lineIdx, List<String> lines) {
        String name = line.trim().toUpperCase();
        if (name.contains(".SEL")) return "SELECT";
        if (name.contains(".FD")) return "FD";
        if (name.contains(".WS")) return "WS";
        if (name.contains(".PS")) return "PROCEDURE";
        if (name.contains(".SL")) return "SCREEN";
        return "OTHER";
    }

    private List<CallReference> extractCallReferences(List<String> lines) {
        List<CallReference> result = new ArrayList<>();
        for (int i = 0; i < lines.size(); i++) {
            String line = lines.get(i);
            if (PAGE_HEADER.matcher(line).matches()) continue;
            boolean isComment = isCommentLine(line);

            Matcher m = CALL_USING.matcher(line);
            if (m.find()) {
                CallReference cr = new CallReference();
                cr.programName = m.group(1);
                cr.usingClause = m.group(2).trim();
                if (cr.usingClause.endsWith(".")) {
                    cr.usingClause = cr.usingClause.substring(0, cr.usingClause.length() - 1).trim();
                }
                cr.lineNum = i + 1;
                cr.inComment = isComment;
                result.add(cr);
                continue;
            }

            Matcher m2 = CALL_STMT.matcher(line);
            if (m2.find()) {
                CallReference cr = new CallReference();
                cr.programName = m2.group(1);
                cr.lineNum = i + 1;
                cr.inComment = isComment;
                result.add(cr);
            }
        }
        return result;
    }

    private List<GuiControl> extractGuiControls(List<String> lines) {
        List<GuiControl> result = new ArrayList<>();
        for (int i = 0; i < lines.size(); i++) {
            String line = lines.get(i);
            if (PAGE_HEADER.matcher(line).matches()) continue;
            boolean isComment = isCommentLine(line);

            Matcher m = GUI_VERB.matcher(line);
            while (m.find()) {
                // 排除非 GUI 的 CREATE（如 CREATE FROM 在註解中是 copybook 欄位描述）
                String verb = m.group(1).toUpperCase();
                String name = m.group(2);
                if (isComment && "CREATE".equals(verb) && name.equalsIgnoreCase("FROM")) continue;
                GuiControl gc = new GuiControl();
                gc.verb = verb;
                gc.controlName = name;
                gc.lineNum = i + 1;
                gc.inComment = isComment;
                result.add(gc);
            }
        }
        return result;
    }

    private List<ProcedureEntry> extractProcedures(List<String> lines) {
        List<ProcedureEntry> result = new ArrayList<>();
        boolean inProcDiv = false;

        for (int i = 0; i < lines.size(); i++) {
            String line = lines.get(i);
            if (PAGE_HEADER.matcher(line).matches()) continue;
            if (STATISTICS_MARKER.matcher(line.trim()).matches()) break;
            if (isCommentLine(line)) continue;

            if (PROCEDURE_DIV.matcher(line).find()) {
                inProcDiv = true;
                continue;
            }

            if (!inProcDiv) continue;

            // Section
            Matcher secM = SECTION_DECL.matcher(line);
            if (secM.find()) {
                String name = secM.group(1);
                // 排除 DATA DIVISION 的 sections
                if (!name.equalsIgnoreCase("FILE") && !name.equalsIgnoreCase("WORKING-STORAGE")
                        && !name.equalsIgnoreCase("LINKAGE") && !name.equalsIgnoreCase("SCREEN")
                        && !name.equalsIgnoreCase("COMMUNICATION") && !name.equalsIgnoreCase("REPORT")) {
                    ProcedureEntry pe = new ProcedureEntry();
                    pe.name = name;
                    pe.type = "SECTION";
                    pe.lineNum = i + 1;
                    result.add(pe);
                }
                continue;
            }

            // Paragraph
            Matcher paraM = PARAGRAPH_DECL.matcher(line);
            if (paraM.find()) {
                String name = paraM.group(1);
                // 排除 DIVISION 和常見非段落名
                if (!name.toUpperCase().contains("DIVISION") && !name.equalsIgnoreCase("FD")
                        && !name.equalsIgnoreCase("SD") && name.length() > 1) {
                    ProcedureEntry pe = new ProcedureEntry();
                    pe.name = name;
                    pe.type = "PARAGRAPH";
                    pe.lineNum = i + 1;
                    result.add(pe);
                }
            }
        }
        return result;
    }

    private Map<String, Integer> findDivisionLines(List<String> lines) {
        Map<String, Integer> result = new LinkedHashMap<>();
        for (int i = 0; i < lines.size(); i++) {
            String line = lines.get(i);
            if (PAGE_HEADER.matcher(line).matches()) continue;
            if (isCommentLine(line)) continue;
            Matcher m = DIVISION.matcher(line);
            if (m.find()) {
                String divName = m.group(1).toUpperCase() + " DIVISION";
                result.putIfAbsent(divName, i + 1);
            }
        }
        return result;
    }

    private List<String> extractLevel01Items(List<String> lines) {
        List<String> result = new ArrayList<>();
        for (int i = 0; i < lines.size(); i++) {
            String line = lines.get(i);
            if (PAGE_HEADER.matcher(line).matches()) continue;
            if (isCommentLine(line)) continue;
            Matcher m = LEVEL_01.matcher(line);
            if (m.find()) {
                String name = m.group(1);
                if (!name.equalsIgnoreCase("FILLER")) {
                    result.add(name);
                }
            }
        }
        return result;
    }

    private boolean hasScreenSection(List<String> lines) {
        for (String line : lines) {
            if (SCREEN_SECTION.matcher(line).find()) return true;
        }
        return false;
    }

    private boolean hasLinkageSection(List<String> lines) {
        for (String line : lines) {
            if (LINKAGE_SECTION.matcher(line).find()) return true;
        }
        return false;
    }

    private boolean isCommentLine(String line) {
        // 列表檔中的註解行：position 7 (0-indexed) = '*'
        if (line.length() > 7 && line.charAt(7) == '*') return true;
        String trimmed = line.trim();
        return trimmed.startsWith("*") || trimmed.startsWith("**");
    }

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

    // ===== CLI Entry Point =====

    public static void main(String[] args) throws IOException {
        if (args.length < 1) {
            System.out.println("用法: java MigrationGuideGenerator <input.lst> [output.md] [charset]");
            System.out.println();
            System.out.println("產生 ACUCOBOL-GT 程式遷移參考書 (Migration Help Book)");
            return;
        }

        Path inputPath = Paths.get(args[0]);
        String baseName = inputPath.getFileName().toString();
        baseName = baseName.contains(".") ? baseName.substring(0, baseName.lastIndexOf('.')) : baseName;

        Path outputPath = args.length >= 2
                ? Paths.get(args[1])
                : inputPath.getParent().resolveSibling("docs").resolve(baseName + "_migration_guide.md");

        Charset charset = Charset.forName(args.length >= 3 ? args[2] : "MS950");

        System.out.println("========================================");
        System.out.println("  ACUCOBOL-GT Migration Help Book 產生器");
        System.out.println("========================================");
        System.out.println();
        System.out.println("  輸入: " + inputPath.toAbsolutePath());
        System.out.println("  輸出: " + outputPath.toAbsolutePath());
        System.out.println("  編碼: " + charset.name());
        System.out.println();

        new MigrationGuideGenerator().generate(inputPath, outputPath, charset);
    }
}
