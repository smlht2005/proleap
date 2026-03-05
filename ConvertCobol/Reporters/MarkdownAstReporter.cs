/*
 * 更新時間：2026-02-06
 * 作者：AI Assistant
 * 摘要：從 AST 模型產生 Markdown 報告，格式對齊 HRRCB1IF_ast.md
 */

using System.Text;
using ConvertCobol.Models;

namespace ConvertCobol.Reporters;

public class MarkdownAstReporter
{
    public string Generate(ProgramAst ast, string sourceFile, TimeSpan parseTime)
    {
        var sb = new StringBuilder();
        var now = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");

        sb.AppendLine($"# COBOL AST Report: {ast.ProgramId ?? "Unknown"}");
        sb.AppendLine();
        sb.AppendLine($"> 產生時間: {now}");
        sb.AppendLine($"> 原始檔案: `{Path.GetFileName(sourceFile)}`");
        sb.AppendLine("> 解析工具: ANTLR4 Cobol85Acu (C#)");
        sb.AppendLine($"> 解析耗時: {parseTime.TotalMilliseconds:F0} ms");
        sb.AppendLine();
        sb.AppendLine("## 概覽");
        sb.AppendLine();
        sb.AppendLine("| 項目 | 數值 |");
        sb.AppendLine("|------|------|");
        sb.AppendLine($"| PROGRAM-ID | {ast.ProgramId ?? "-"} |");
        sb.AppendLine($"| FD 項目 | {ast.FdCount} |");
        sb.AppendLine($"| 01-Level 資料項目 | {ast.DataItem01Count} |");
        sb.AppendLine($"| 77-Level 資料項目 | {ast.DataItem77Count} |");
        sb.AppendLine($"| 全部資料項目 | {ast.TotalDataItems} |");
        sb.AppendLine($"| Sections | {ast.SectionCount} |");
        sb.AppendLine($"| Paragraphs | {ast.ParagraphCount} |");
        sb.AppendLine($"| 語句總數 | {ast.StatementCount} |");
        sb.AppendLine($"| 含 SCREEN SECTION（已註解） | {(ast.HasScreenSection ? "是" : "否")} |");
        sb.AppendLine();

        sb.AppendLine("## IDENTIFICATION DIVISION");
        sb.AppendLine();
        sb.AppendLine($"- **PROGRAM-ID**: `{ast.ProgramId ?? "-"}`");
        sb.AppendLine();

        sb.AppendLine("## ENVIRONMENT DIVISION");
        sb.AppendLine();
        sb.AppendLine("- 已辨識");
        sb.AppendLine();

        sb.AppendLine("## DATA DIVISION");
        sb.AppendLine();
        sb.AppendLine($"### FILE SECTION ({ast.FdCount} FD)");
        sb.AppendLine();
        AppendDataItems(sb, ast.Data?.Children.OfType<DataItemNode>().ToList() ?? [], 0);
        sb.AppendLine();

        sb.AppendLine("## PROCEDURE DIVISION");
        sb.AppendLine();
        if (ast.Procedure?.Children.Count > 0)
        {
            foreach (var child in ast.Procedure.Children)
            {
                if (child is ParagraphNode pn)
                {
                    var prefix = pn.IsSection ? "### " : "#### ";
                    sb.AppendLine($"{prefix}{pn.Name}");
                    sb.AppendLine();
                    if (pn.Statements.Count > 0)
                    {
                        var stmtGroups = pn.Statements.GroupBy(s => s.StatementType).OrderByDescending(g => g.Count());
                        foreach (var g in stmtGroups)
                            sb.AppendLine($"- {g.Key}: {g.Count()}");
                        sb.AppendLine();
                    }
                }
            }
        }
        else
        {
            sb.AppendLine("- 無段落資料");
        }

        return sb.ToString();
    }

    private static void AppendDataItems(StringBuilder sb, List<DataItemNode> items, int depth)
    {
        foreach (var item in items.Take(100))
        {
            var indent = new string(' ', depth * 2);
            var line = $"{indent}{item.Level:D2} {item.Name}";
            if (!string.IsNullOrEmpty(item.PicClause))
                line += $"  PIC {item.PicClause}";
            if (!string.IsNullOrEmpty(item.Occurs))
                line += "  [OCCURS]";
            if (!string.IsNullOrEmpty(item.Redefines))
                line += "  [REDEFINES]";
            sb.AppendLine(line);
            if (item.Children.Count > 0)
                AppendDataItems(sb, item.Children, depth + 1);
        }
        if (items.Count > 100)
            sb.AppendLine($"... 還有 {items.Count - 100} 個項目");
    }
}
