/**
 * 更新時間：2026-02-06 16:57
 * 作者：AI Assistant
 * 摘要：COBOL AST/ASG 報告產生器
 *       遍歷 ProLeap 解析後的 ASG（Abstract Semantic Graph），
 *       產生結構化 Markdown 報告，包含完整的程式結構樹狀圖
 *
 * 更新歷程：
 *   2026-02-06 16:57 - 初版
 */
package com.hiscore.cobol.ast;

import io.proleap.cobol.asg.metamodel.*;
import io.proleap.cobol.asg.metamodel.data.DataDivision;
import io.proleap.cobol.asg.metamodel.data.datadescription.DataDescriptionEntry;
import io.proleap.cobol.asg.metamodel.data.datadescription.DataDescriptionEntry.DataDescriptionEntryType;
import io.proleap.cobol.asg.metamodel.data.datadescription.DataDescriptionEntryGroup;
import io.proleap.cobol.asg.metamodel.data.datadescription.PictureClause;
import io.proleap.cobol.asg.metamodel.data.file.FileDescriptionEntry;
import io.proleap.cobol.asg.metamodel.data.file.FileSection;
import io.proleap.cobol.asg.metamodel.data.workingstorage.WorkingStorageSection;
import io.proleap.cobol.asg.metamodel.data.linkage.LinkageSection;
import io.proleap.cobol.asg.metamodel.environment.EnvironmentDivision;
import io.proleap.cobol.asg.metamodel.identification.IdentificationDivision;
import io.proleap.cobol.asg.metamodel.identification.ProgramIdParagraph;
import io.proleap.cobol.asg.metamodel.procedure.ProcedureDivision;
import io.proleap.cobol.asg.metamodel.procedure.Paragraph;
import io.proleap.cobol.asg.metamodel.procedure.Section;
import io.proleap.cobol.asg.metamodel.procedure.Statement;
import io.proleap.cobol.asg.metamodel.procedure.StatementTypeEnum;

import java.io.IOException;
import java.nio.file.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 遍歷 ProLeap ASG 樹，產生結構化 Markdown AST 報告
 */
public class AstGenerator {

    private static final DateTimeFormatter DT_FMT =
            DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    /**
     * 產生 AST 報告
     *
     * @param program      ProLeap 解析後的 Program 物件
     * @param outputPath   輸出 Markdown 檔案路徑
     * @param sourceFile   原始檔案名稱（用於報告標題）
     * @param parseTimeMs  解析耗時（毫秒）
     */
    public void generate(Program program, Path outputPath, String sourceFile,
                         long parseTimeMs) throws IOException {
        StringBuilder sb = new StringBuilder();

        if (program == null) {
            sb.append("# AST Report\n\n> 解析結果為空，無法產生報告。\n");
            Files.createDirectories(outputPath.getParent());
            Files.writeString(outputPath, sb.toString());
            return;
        }

        for (CompilationUnit cu : program.getCompilationUnits()) {
            ProgramUnit pu = cu.getProgramUnit();
            if (pu == null) continue;

            // 收集統計資訊
            AstStats stats = collectStats(pu);

            // 標題
            writeHeader(sb, cu.getName(), sourceFile, parseTimeMs);

            // 概覽表
            writeOverview(sb, stats);

            // IDENTIFICATION DIVISION
            writeIdentificationDivision(sb, pu);

            // ENVIRONMENT DIVISION
            writeEnvironmentDivision(sb, pu);

            // DATA DIVISION
            writeDataDivision(sb, pu, stats);

            // PROCEDURE DIVISION
            writeProcedureDivision(sb, pu, stats);

            // 語句類型統計
            writeStatementStats(sb, stats);
        }

        Files.createDirectories(outputPath.getParent());
        Files.writeString(outputPath, sb.toString());
    }

    // ========== Header ==========

    private void writeHeader(StringBuilder sb, String programName, String sourceFile,
                             long parseTimeMs) {
        sb.append("# COBOL AST Report: ").append(programName).append("\n\n");
        sb.append("> 產生時間: ").append(LocalDateTime.now().format(DT_FMT)).append("\n");
        sb.append("> 原始檔案: `").append(sourceFile).append("`\n");
        sb.append("> 解析工具: ProLeap COBOL Parser (TANDEM format)\n");
        sb.append("> 解析耗時: ").append(parseTimeMs).append(" ms\n\n");
    }

    // ========== Overview ==========

    private void writeOverview(StringBuilder sb, AstStats stats) {
        sb.append("## 概覽\n\n");
        sb.append("| 項目 | 數值 |\n");
        sb.append("|------|------|\n");
        sb.append("| PROGRAM-ID | ").append(stats.programId).append(" |\n");
        sb.append("| FD 項目 | ").append(stats.fdCount).append(" |\n");
        sb.append("| 01-Level 資料項目 | ").append(stats.level01Count).append(" |\n");
        sb.append("| 77-Level 資料項目 | ").append(stats.level77Count).append(" |\n");
        sb.append("| 全部資料項目 | ").append(stats.totalDataEntries).append(" |\n");
        sb.append("| Sections | ").append(stats.sectionCount).append(" |\n");
        sb.append("| Paragraphs | ").append(stats.paragraphCount).append(" |\n");
        sb.append("| 語句總數 | ").append(stats.totalStatements).append(" |\n");
        sb.append("\n");
    }

    // ========== IDENTIFICATION DIVISION ==========

    private void writeIdentificationDivision(StringBuilder sb, ProgramUnit pu) {
        IdentificationDivision idDiv = pu.getIdentificationDivision();
        sb.append("## IDENTIFICATION DIVISION\n\n");
        if (idDiv == null) {
            sb.append("(未解析)\n\n");
            return;
        }
        ProgramIdParagraph pid = idDiv.getProgramIdParagraph();
        if (pid != null) {
            sb.append("- **PROGRAM-ID**: `").append(pid.getName()).append("`\n");
        }
        sb.append("\n");
    }

    // ========== ENVIRONMENT DIVISION ==========

    private void writeEnvironmentDivision(StringBuilder sb, ProgramUnit pu) {
        EnvironmentDivision envDiv = pu.getEnvironmentDivision();
        sb.append("## ENVIRONMENT DIVISION\n\n");
        if (envDiv == null) {
            sb.append("(未解析)\n\n");
            return;
        }
        sb.append("- 已辨識（ACUCOBOL SELECT/ASSIGN 語句因 ProLeap 限制部分無法解析）\n\n");
    }

    // ========== DATA DIVISION ==========

    private void writeDataDivision(StringBuilder sb, ProgramUnit pu, AstStats stats) {
        DataDivision dataDiv = pu.getDataDivision();
        sb.append("## DATA DIVISION\n\n");
        if (dataDiv == null) {
            sb.append("(未解析)\n\n");
            return;
        }

        // FILE SECTION
        FileSection fileSection = dataDiv.getFileSection();
        if (fileSection != null) {
            List<FileDescriptionEntry> fdEntries = fileSection.getFileDescriptionEntries();
            sb.append("### FILE SECTION (").append(fdEntries.size()).append(" FD)\n\n");
            for (FileDescriptionEntry fd : fdEntries) {
                sb.append("#### FD ").append(fd.getName()).append("\n\n");
                sb.append("```\n");
                List<DataDescriptionEntry> entries = fd.getDataDescriptionEntries();
                if (entries != null) {
                    for (DataDescriptionEntry entry : entries) {
                        writeDataEntryTree(sb, entry, 0);
                    }
                }
                sb.append("```\n\n");
            }
        }

        // WORKING-STORAGE SECTION
        WorkingStorageSection wsSection = dataDiv.getWorkingStorageSection();
        if (wsSection != null) {
            List<DataDescriptionEntry> entries = wsSection.getDataDescriptionEntries();
            sb.append("### WORKING-STORAGE SECTION (").append(entries.size())
              .append(" 項目)\n\n");
            sb.append("```\n");
            for (DataDescriptionEntry entry : entries) {
                writeDataEntryTree(sb, entry, 0);
            }
            sb.append("```\n\n");
        } else {
            sb.append("### WORKING-STORAGE SECTION\n\n(未解析)\n\n");
        }

        // LINKAGE SECTION
        try {
            LinkageSection linkageSection = dataDiv.getLinkageSection();
            if (linkageSection != null) {
                List<DataDescriptionEntry> entries = linkageSection.getDataDescriptionEntries();
                sb.append("### LINKAGE SECTION (").append(entries.size())
                  .append(" 項目)\n\n");
                sb.append("```\n");
                for (DataDescriptionEntry entry : entries) {
                    writeDataEntryTree(sb, entry, 0);
                }
                sb.append("```\n\n");
            }
        } catch (Exception e) {
            // LinkageSection 可能不存在，忽略
        }
    }

    /**
     * 遞迴輸出資料項目樹狀結構
     */
    private void writeDataEntryTree(StringBuilder sb, DataDescriptionEntry entry, int depth) {
        if (entry == null) return;

        Integer level = entry.getLevelNumber();
        String name = entry.getName();
        String indent = "  ".repeat(depth);

        // 格式：level name PIC xxx
        sb.append(indent);
        if (level != null) {
            sb.append(String.format("%02d", level));
        } else {
            sb.append("??");
        }
        sb.append(" ").append(name != null ? name : "(FILLER)");

        // PIC clause (只有 GROUP 型別有)
        if (entry instanceof DataDescriptionEntryGroup) {
            DataDescriptionEntryGroup group = (DataDescriptionEntryGroup) entry;
            PictureClause pic = group.getPictureClause();
            if (pic != null && pic.getPictureString() != null) {
                sb.append("  PIC ").append(pic.getPictureString());
            }

            // REDEFINES
            if (group.getRedefinesClause() != null) {
                sb.append("  [REDEFINES]");
            }

            // OCCURS
            if (group.getOccursClauses() != null && !group.getOccursClauses().isEmpty()) {
                sb.append("  [OCCURS]");
            }

            sb.append("\n");

            // 遞迴子項目
            List<DataDescriptionEntry> subEntries = group.getDataDescriptionEntries();
            if (subEntries != null) {
                for (DataDescriptionEntry sub : subEntries) {
                    writeDataEntryTree(sb, sub, depth + 1);
                }
            }
        } else {
            // CONDITION (88) or RENAME (66)
            DataDescriptionEntryType type = entry.getDataDescriptionEntryType();
            if (type != null) {
                sb.append("  [").append(type).append("]");
            }
            sb.append("\n");
        }
    }

    // ========== PROCEDURE DIVISION ==========

    private void writeProcedureDivision(StringBuilder sb, ProgramUnit pu, AstStats stats) {
        ProcedureDivision procDiv = pu.getProcedureDivision();
        sb.append("## PROCEDURE DIVISION\n\n");
        if (procDiv == null) {
            sb.append("(未解析)\n\n");
            return;
        }

        // Sections
        List<Section> sections = procDiv.getSections();
        if (sections != null && !sections.isEmpty()) {
            sb.append("### Sections & Paragraphs\n\n");
            sb.append("| # | Section | Paragraph | 語句數 | 語句類型摘要 |\n");
            sb.append("|---|---------|-----------|--------|-------------|\n");

            int idx = 0;
            for (Section section : sections) {
                String sectionName = section.getName() != null ? section.getName() : "(unnamed)";
                List<Paragraph> paragraphs = section.getParagraphs();
                if (paragraphs != null && !paragraphs.isEmpty()) {
                    for (Paragraph para : paragraphs) {
                        idx++;
                        String paraName = para.getName() != null ? para.getName() : "(unnamed)";
                        List<Statement> stmts = para.getStatements();
                        int stmtCount = stmts != null ? stmts.size() : 0;
                        String stmtSummary = summarizeStatements(stmts);
                        sb.append("| ").append(idx)
                          .append(" | ").append(sectionName)
                          .append(" | ").append(paraName)
                          .append(" | ").append(stmtCount)
                          .append(" | ").append(stmtSummary)
                          .append(" |\n");
                    }
                } else {
                    idx++;
                    sb.append("| ").append(idx)
                      .append(" | ").append(sectionName)
                      .append(" | (無段落) | 0 | - |\n");
                }
            }
            sb.append("\n");
        }

        // Root-level paragraphs (不屬於任何 Section)
        List<Paragraph> rootParagraphs = procDiv.getParagraphs();
        if (rootParagraphs != null && !rootParagraphs.isEmpty()) {
            sb.append("### Root-Level Paragraphs\n\n");
            sb.append("| # | Paragraph | 語句數 | 語句類型摘要 |\n");
            sb.append("|---|-----------|--------|-------------|\n");
            int idx = 0;
            for (Paragraph para : rootParagraphs) {
                idx++;
                String paraName = para.getName() != null ? para.getName() : "(unnamed)";
                List<Statement> stmts = para.getStatements();
                int stmtCount = stmts != null ? stmts.size() : 0;
                String stmtSummary = summarizeStatements(stmts);
                sb.append("| ").append(idx)
                  .append(" | ").append(paraName)
                  .append(" | ").append(stmtCount)
                  .append(" | ").append(stmtSummary)
                  .append(" |\n");
            }
            sb.append("\n");
        }
    }

    /**
     * 將語句列表摘要為 "MOVE:3, PERFORM:2, IF:1" 格式
     */
    private String summarizeStatements(List<Statement> stmts) {
        if (stmts == null || stmts.isEmpty()) return "-";

        Map<String, Integer> counts = new LinkedHashMap<>();
        for (Statement stmt : stmts) {
            try {
                String typeName = stmt.getStatementType() != null
                        ? stmt.getStatementType().toString()
                        : "UNKNOWN";
                counts.merge(typeName, 1, Integer::sum);
            } catch (Exception e) {
                counts.merge("?", 1, Integer::sum);
            }
        }

        return counts.entrySet().stream()
                .sorted(Map.Entry.<String, Integer>comparingByValue().reversed())
                .map(e -> e.getKey() + ":" + e.getValue())
                .collect(Collectors.joining(", "));
    }

    // ========== Statement Statistics ==========

    private void writeStatementStats(StringBuilder sb, AstStats stats) {
        if (stats.statementTypeCounts.isEmpty()) return;

        sb.append("## 語句類型統計\n\n");
        sb.append("| 語句類型 | 數量 | 百分比 |\n");
        sb.append("|----------|------|--------|\n");

        int total = stats.totalStatements;
        stats.statementTypeCounts.entrySet().stream()
                .sorted(Map.Entry.<String, Integer>comparingByValue().reversed())
                .forEach(e -> {
                    double pct = total > 0 ? (e.getValue() * 100.0 / total) : 0;
                    sb.append("| ").append(e.getKey())
                      .append(" | ").append(e.getValue())
                      .append(" | ").append(String.format("%.1f%%", pct))
                      .append(" |\n");
                });
        sb.append("| **合計** | **").append(total).append("** | **100%** |\n");
        sb.append("\n");
    }

    // ========== Statistics Collection ==========

    private AstStats collectStats(ProgramUnit pu) {
        AstStats stats = new AstStats();

        // IDENTIFICATION
        IdentificationDivision idDiv = pu.getIdentificationDivision();
        if (idDiv != null && idDiv.getProgramIdParagraph() != null) {
            stats.programId = idDiv.getProgramIdParagraph().getName();
        }

        // DATA DIVISION
        DataDivision dataDiv = pu.getDataDivision();
        if (dataDiv != null) {
            FileSection fileSection = dataDiv.getFileSection();
            if (fileSection != null) {
                stats.fdCount = fileSection.getFileDescriptionEntries().size();
                for (FileDescriptionEntry fd : fileSection.getFileDescriptionEntries()) {
                    countDataEntries(fd.getDataDescriptionEntries(), stats);
                }
            }
            WorkingStorageSection wsSection = dataDiv.getWorkingStorageSection();
            if (wsSection != null) {
                countDataEntries(wsSection.getDataDescriptionEntries(), stats);
            }
            try {
                LinkageSection linkageSection = dataDiv.getLinkageSection();
                if (linkageSection != null) {
                    countDataEntries(linkageSection.getDataDescriptionEntries(), stats);
                }
            } catch (Exception e) { /* ignore */ }
        }

        // PROCEDURE DIVISION
        ProcedureDivision procDiv = pu.getProcedureDivision();
        if (procDiv != null) {
            List<Section> sections = procDiv.getSections();
            stats.sectionCount = sections != null ? sections.size() : 0;

            List<Paragraph> paragraphs = procDiv.getParagraphs();
            stats.paragraphCount = paragraphs != null ? paragraphs.size() : 0;

            // 統計語句
            if (sections != null) {
                for (Section section : sections) {
                    List<Paragraph> secParas = section.getParagraphs();
                    if (secParas != null) {
                        for (Paragraph para : secParas) {
                            countStatements(para.getStatements(), stats);
                        }
                    }
                }
            }
            // root paragraphs 的語句
            if (paragraphs != null) {
                for (Paragraph para : paragraphs) {
                    countStatements(para.getStatements(), stats);
                }
            }
        }

        return stats;
    }

    private void countDataEntries(List<DataDescriptionEntry> entries, AstStats stats) {
        if (entries == null) return;
        for (DataDescriptionEntry entry : entries) {
            stats.totalDataEntries++;
            Integer level = entry.getLevelNumber();
            if (level != null) {
                if (level == 1) stats.level01Count++;
                else if (level == 77) stats.level77Count++;
            }
            // 遞迴計算子項目
            if (entry instanceof DataDescriptionEntryGroup) {
                DataDescriptionEntryGroup group = (DataDescriptionEntryGroup) entry;
                countDataEntries(group.getDataDescriptionEntries(), stats);
            }
        }
    }

    private void countStatements(List<Statement> stmts, AstStats stats) {
        if (stmts == null) return;
        for (Statement stmt : stmts) {
            stats.totalStatements++;
            try {
                String typeName = stmt.getStatementType() != null
                        ? stmt.getStatementType().toString()
                        : "UNKNOWN";
                stats.statementTypeCounts.merge(typeName, 1, Integer::sum);
            } catch (Exception e) {
                stats.statementTypeCounts.merge("?", 1, Integer::sum);
            }
        }
    }

    /**
     * AST 統計資訊
     */
    private static class AstStats {
        String programId = "(unknown)";
        int fdCount = 0;
        int level01Count = 0;
        int level77Count = 0;
        int totalDataEntries = 0;
        int sectionCount = 0;
        int paragraphCount = 0;
        int totalStatements = 0;
        Map<String, Integer> statementTypeCounts = new LinkedHashMap<>();
    }
}
