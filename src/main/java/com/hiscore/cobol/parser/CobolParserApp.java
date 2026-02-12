/**
 * 更新時間：2026-02-06 16:57
 * 作者：AI Assistant
 * 摘要：COBOL 解析主程式 - 使用 ProLeap 解析清理後的 ACUCOBOL 原始碼
 *       產生 AST（抽象語法樹）與 ASG（抽象語意圖）
 *       支援三種模式：解析摘要、AST 報告、遷移參考書
 *
 * 更新歷程：
 *   2026-02-06 16:57 - 新增 ast 指令：產生完整 AST/ASG Markdown 報告
 *   2026-02-06 15:01 - 新增 help_book 遷移參考書產生功能
 *   2026-02-06 14:25 - 初版
 *
 * 使用方式：
 *   mvn exec:java -Dexec.args="list/HRMETKF.lst"                    # 解析摘要
 *   mvn exec:java -Dexec.args="ast list/HRMETKF.lst"                # AST 報告
 *   mvn exec:java -Dexec.args="help_book list/HRMETKF.lst"          # 遷移參考書
 *   java -jar target/cobol-parser-1.0.0-SNAPSHOT.jar list/HRMETKF.lst
 */
package com.hiscore.cobol.parser;

import com.hiscore.cobol.ast.AstGenerator;
import com.hiscore.cobol.cleaner.AcuListingCleaner;
import com.hiscore.cobol.cleaner.AcuListingCleaner.CleanResult;
import com.hiscore.cobol.migration.MigrationGuideGenerator;

import io.proleap.cobol.asg.metamodel.*;
import io.proleap.cobol.asg.metamodel.data.DataDivision;
import io.proleap.cobol.asg.metamodel.data.datadescription.DataDescriptionEntry;
import io.proleap.cobol.asg.metamodel.data.file.FileDescriptionEntry;
import io.proleap.cobol.asg.metamodel.data.file.FileSection;
import io.proleap.cobol.asg.metamodel.data.workingstorage.WorkingStorageSection;
import io.proleap.cobol.asg.metamodel.environment.EnvironmentDivision;
import io.proleap.cobol.asg.metamodel.identification.IdentificationDivision;
import io.proleap.cobol.asg.metamodel.identification.ProgramIdParagraph;
import io.proleap.cobol.asg.metamodel.procedure.ProcedureDivision;
import io.proleap.cobol.asg.metamodel.procedure.Paragraph;
import io.proleap.cobol.asg.metamodel.procedure.Section;
import io.proleap.cobol.asg.runner.impl.CobolParserRunnerImpl;
import io.proleap.cobol.preprocessor.CobolPreprocessor.CobolSourceFormatEnum;

import java.io.*;
import java.nio.charset.Charset;
import java.nio.file.*;
import java.util.List;

public class CobolParserApp {

    private static final String SEPARATOR = "=" .repeat(70);
    private static final String SUB_SEPARATOR = "-".repeat(50);

    public static void main(String[] args) {
        if (args.length < 1) {
            printUsage();
            return;
        }

        // 檢查 help_book 指令
        if (args[0].equalsIgnoreCase("help_book")) {
            runHelpBook(args);
            return;
        }

        // 檢查 ast 指令
        if (args[0].equalsIgnoreCase("ast")) {
            runAst(args);
            return;
        }

        String inputFile = args[0];
        String charsetName = args.length >= 2 ? args[1] : "MS950";
        String formatName = args.length >= 3 ? args[2] : "TANDEM";

        try {
            Path inputPath = Paths.get(inputFile);
            Charset charset = Charset.forName(charsetName);
            CobolSourceFormatEnum format = CobolSourceFormatEnum.valueOf(formatName);

            System.out.println(SEPARATOR);
            System.out.println("  HISCore COBOL Parser - ACUCOBOL-GT 列表檔解析工具");
            System.out.println(SEPARATOR);
            System.out.println();

            // Step 1: 清理列表檔
            System.out.println("[Step 1] 清理 ACUCOBOL-GT 列表檔...");
            Path cblDir = inputPath.getParent().resolveSibling("cbl");
            String baseName = getBaseName(inputPath);
            Path cleanedPath = cblDir.resolve(baseName + ".cbl");

            AcuListingCleaner cleaner = new AcuListingCleaner();
            CleanResult cleanResult = cleaner.clean(inputPath, cleanedPath, charset);
            System.out.println(cleanResult);
            System.out.println();

            // Step 2: 使用 ProLeap 解析 COBOL
            System.out.println("[Step 2] 使用 ProLeap 解析 COBOL (格式: " + format + ")...");
            System.out.println("  檔案: " + cleanedPath.toAbsolutePath());
            System.out.println();

            parseCobol(cleanedPath.toFile(), format);

        } catch (Exception e) {
            System.err.println("錯誤: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * 使用 ProLeap 解析 COBOL 檔案，輸出 AST/ASG 資訊
     * 啟用 ignoreSyntaxErrors 容忍 ACUCOBOL 特有語法
     */
    private static void parseCobol(File inputFile, CobolSourceFormatEnum format) {
        try {
            System.out.println("  正在解析（錯誤容忍模式），請稍候...");
            long startTime = System.currentTimeMillis();

            // 建立參數，啟用忽略語法錯誤
            io.proleap.cobol.asg.params.impl.CobolParserParamsImpl params =
                    new io.proleap.cobol.asg.params.impl.CobolParserParamsImpl();
            params.setFormat(format);
            params.setIgnoreSyntaxErrors(true);

            // 使用 ProLeap 解析器（帶參數）
            Program program = new CobolParserRunnerImpl().analyzeFile(inputFile, params);
            long elapsed = System.currentTimeMillis() - startTime;

            System.out.println("  解析完成！耗時: " + elapsed + " ms");
            System.out.println();

            // 輸出解析結果
            printProgramInfo(program);

        } catch (Exception e) {
            System.err.println();
            System.err.println("  [致命錯誤] 解析過程發生無法恢復的錯誤。");
            System.err.println("  原因: " + e.getMessage());
            System.err.println();
            e.printStackTrace();
        }
    }

    /**
     * 輸出解析後的程式結構資訊
     */
    private static void printProgramInfo(Program program) {
        if (program == null) {
            System.out.println("  [警告] 解析結果為空");
            return;
        }

        for (CompilationUnit compilationUnit : program.getCompilationUnits()) {
            System.out.println(SEPARATOR);
            System.out.println("  Compilation Unit: " + compilationUnit.getName());
            System.out.println(SEPARATOR);

            ProgramUnit programUnit = compilationUnit.getProgramUnit();
            if (programUnit == null) {
                System.out.println("  [警告] 無 ProgramUnit");
                continue;
            }

            // --- IDENTIFICATION DIVISION ---
            printIdentificationDivision(programUnit);

            // --- ENVIRONMENT DIVISION ---
            printEnvironmentDivision(programUnit);

            // --- DATA DIVISION ---
            printDataDivision(programUnit);

            // --- PROCEDURE DIVISION ---
            printProcedureDivision(programUnit);
        }
    }

    private static void printIdentificationDivision(ProgramUnit programUnit) {
        IdentificationDivision idDiv = programUnit.getIdentificationDivision();
        if (idDiv == null) return;

        System.out.println();
        System.out.println(SUB_SEPARATOR);
        System.out.println("  IDENTIFICATION DIVISION");
        System.out.println(SUB_SEPARATOR);

        ProgramIdParagraph programId = idDiv.getProgramIdParagraph();
        if (programId != null) {
            System.out.println("    PROGRAM-ID: " + programId.getName());
        }
    }

    private static void printEnvironmentDivision(ProgramUnit programUnit) {
        EnvironmentDivision envDiv = programUnit.getEnvironmentDivision();
        if (envDiv == null) return;

        System.out.println();
        System.out.println(SUB_SEPARATOR);
        System.out.println("  ENVIRONMENT DIVISION");
        System.out.println(SUB_SEPARATOR);
        System.out.println("    (已辨識)");
    }

    private static void printDataDivision(ProgramUnit programUnit) {
        DataDivision dataDiv = programUnit.getDataDivision();
        if (dataDiv == null) return;

        System.out.println();
        System.out.println(SUB_SEPARATOR);
        System.out.println("  DATA DIVISION");
        System.out.println(SUB_SEPARATOR);

        // File Section
        FileSection fileSection = dataDiv.getFileSection();
        if (fileSection != null) {
            List<FileDescriptionEntry> fdEntries = fileSection.getFileDescriptionEntries();
            System.out.println("    FILE SECTION: " + fdEntries.size() + " 個 FD 項目");
            for (FileDescriptionEntry fd : fdEntries) {
                System.out.println("      FD " + fd.getName());
            }
        }

        // Working-Storage Section
        WorkingStorageSection wsSection = dataDiv.getWorkingStorageSection();
        if (wsSection != null) {
            List<DataDescriptionEntry> entries = wsSection.getDataDescriptionEntries();
            System.out.println("    WORKING-STORAGE SECTION: " + entries.size() + " 個資料項目");

            // 只顯示 level 01 和 77 的項目
            int count01 = 0;
            int count77 = 0;
            for (DataDescriptionEntry entry : entries) {
                if (entry.getLevelNumber() != null) {
                    if (entry.getLevelNumber() == 1) {
                        count01++;
                        if (count01 <= 50) { // 限制顯示數量
                            System.out.println("      01 " + (entry.getName() != null ? entry.getName() : "(FILLER)"));
                        }
                    } else if (entry.getLevelNumber() == 77) {
                        count77++;
                    }
                }
            }
            if (count01 > 50) {
                System.out.println("      ... 還有 " + (count01 - 50) + " 個 01 level 項目");
            }
            System.out.println("    共 " + count01 + " 個 01-level, " + count77 + " 個 77-level 項目");
        }
    }

    private static void printProcedureDivision(ProgramUnit programUnit) {
        ProcedureDivision procDiv = programUnit.getProcedureDivision();
        if (procDiv == null) return;

        System.out.println();
        System.out.println(SUB_SEPARATOR);
        System.out.println("  PROCEDURE DIVISION");
        System.out.println(SUB_SEPARATOR);

        // Sections
        List<Section> sections = procDiv.getSections();
        if (sections != null && !sections.isEmpty()) {
            System.out.println("    Sections: " + sections.size());
            for (Section section : sections) {
                System.out.println("      SECTION " + section.getName());
            }
        }

        // Paragraphs
        List<Paragraph> paragraphs = procDiv.getParagraphs();
        if (paragraphs != null && !paragraphs.isEmpty()) {
            System.out.println("    Paragraphs: " + paragraphs.size());
            int displayCount = 0;
            for (Paragraph para : paragraphs) {
                displayCount++;
                if (displayCount <= 100) {
                    System.out.println("      " + para.getName());
                }
            }
            if (displayCount > 100) {
                System.out.println("      ... 還有 " + (displayCount - 100) + " 個段落");
            }
        }
    }

    private static String getBaseName(Path path) {
        String fileName = path.getFileName().toString();
        int dot = fileName.lastIndexOf('.');
        return dot > 0 ? fileName.substring(0, dot) : fileName;
    }

    /**
     * 執行 help_book 遷移參考書產生
     */
    private static void runHelpBook(String[] args) {
        if (args.length < 2) {
            System.err.println("錯誤: help_book 需要指定輸入檔案");
            System.err.println("用法: help_book <input.lst> [output.md] [charset]");
            return;
        }

        try {
            Path inputPath = Paths.get(args[1]);
            String baseName = getBaseName(inputPath);

            Path outputPath = args.length >= 3
                    ? Paths.get(args[2])
                    : inputPath.getParent().resolveSibling("docs").resolve(baseName + "_migration_guide.md");

            Charset charset = Charset.forName(args.length >= 4 ? args[3] : "MS950");

            System.out.println(SEPARATOR);
            System.out.println("  ACUCOBOL-GT Migration Help Book 產生器");
            System.out.println(SEPARATOR);
            System.out.println();
            System.out.println("  輸入: " + inputPath.toAbsolutePath());
            System.out.println("  輸出: " + outputPath.toAbsolutePath());
            System.out.println("  編碼: " + charset.name());
            System.out.println();

            long startTime = System.currentTimeMillis();
            new MigrationGuideGenerator().generate(inputPath, outputPath, charset);
            long elapsed = System.currentTimeMillis() - startTime;

            System.out.println();
            System.out.println("  耗時: " + elapsed + " ms");
            System.out.println(SEPARATOR);

        } catch (Exception e) {
            System.err.println("錯誤: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * 執行 ast 報告產生
     */
    private static void runAst(String[] args) {
        if (args.length < 2) {
            System.err.println("錯誤: ast 需要指定輸入檔案");
            System.err.println("用法: ast <input.lst> [output.md] [charset]");
            return;
        }

        try {
            String inputFile = args[1];
            String charsetName = args.length >= 4 ? args[3] : "MS950";
            String formatName = "TANDEM";

            Path inputPath = Paths.get(inputFile);
            Charset charset = Charset.forName(charsetName);
            CobolSourceFormatEnum format = CobolSourceFormatEnum.valueOf(formatName);
            String baseName = getBaseName(inputPath);

            Path outputPath = args.length >= 3
                    ? Paths.get(args[2])
                    : inputPath.getParent().resolveSibling("ast").resolve(baseName + "_ast.md");

            System.out.println(SEPARATOR);
            System.out.println("  COBOL AST/ASG Report 產生器");
            System.out.println(SEPARATOR);
            System.out.println();

            // Step 1: 清理列表檔
            System.out.println("[Step 1] 清理 ACUCOBOL-GT 列表檔...");
            Path cblDir = inputPath.getParent().resolveSibling("cbl");
            Path cleanedPath = cblDir.resolve(baseName + ".cbl");

            AcuListingCleaner cleaner = new AcuListingCleaner();
            CleanResult cleanResult = cleaner.clean(inputPath, cleanedPath, charset);
            System.out.println(cleanResult);
            System.out.println();

            // Step 2: 使用 ProLeap 解析 COBOL
            System.out.println("[Step 2] 使用 ProLeap 解析 COBOL (格式: " + format + ")...");
            System.out.println("  檔案: " + cleanedPath.toAbsolutePath());
            System.out.println();
            System.out.println("  正在解析（錯誤容忍模式），請稍候...");
            long startTime = System.currentTimeMillis();

            io.proleap.cobol.asg.params.impl.CobolParserParamsImpl params =
                    new io.proleap.cobol.asg.params.impl.CobolParserParamsImpl();
            params.setFormat(format);
            params.setIgnoreSyntaxErrors(true);

            Program program = new CobolParserRunnerImpl().analyzeFile(
                    cleanedPath.toFile(), params);
            long elapsed = System.currentTimeMillis() - startTime;

            System.out.println("  解析完成！耗時: " + elapsed + " ms");
            System.out.println();

            // Step 3: 產生 AST 報告
            System.out.println("[Step 3] 產生 AST 報告...");
            System.out.println("  輸出: " + outputPath.toAbsolutePath());

            new AstGenerator().generate(program, outputPath,
                    cleanedPath.getFileName().toString(), elapsed);

            System.out.println("  AST 報告產生完成！");
            System.out.println(SEPARATOR);

        } catch (Exception e) {
            System.err.println("錯誤: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private static void printUsage() {
        System.out.println("HISCore COBOL Parser - ACUCOBOL-GT 列表檔解析工具");
        System.out.println();
        System.out.println("用法:");
        System.out.println("  1) 解析 COBOL (摘要):");
        System.out.println("     mvn exec:java -Dexec.args=\"<input.lst> [charset] [format]\"");
        System.out.println();
        System.out.println("  2) 產生 AST 報告 (ast):");
        System.out.println("     mvn exec:java -Dexec.args=\"ast <input.lst> [output.md] [charset]\"");
        System.out.println();
        System.out.println("  3) 產生遷移參考書 (help_book):");
        System.out.println("     mvn exec:java -Dexec.args=\"help_book <input.lst> [output.md] [charset]\"");
        System.out.println();
        System.out.println("參數:");
        System.out.println("  input.lst  - ACUCOBOL-GT 編譯器列表檔路徑");
        System.out.println("  charset    - 檔案編碼 (預設: MS950, 可選: UTF-8, Big5)");
        System.out.println("  format     - COBOL 格式 (預設: TANDEM, 可選: FIXED, VARIABLE)");
        System.out.println();
        System.out.println("範例:");
        System.out.println("  mvn exec:java -Dexec.args=\"list/HRMETKF.lst\"");
        System.out.println("  mvn exec:java -Dexec.args=\"ast list/HRRCB1IF.lst\"");
        System.out.println("  mvn exec:java -Dexec.args=\"help_book list/HRMETKF.lst\"");
    }
}
