/*
 * 更新時間：2026-02-09 18:35
 * 作者：AI Assistant
 * 摘要：Overview 新增 ScreenSectionItemCount（SCREEN SECTION 項目數，含巢狀）、FileControlEntryCount（FILE-CONTROL 項目數）
 *
 * 更新時間：2026-02-09 20:15
 * 作者：AI Assistant
 * 摘要：新增 HasScreenSection（來源含 SCREEN SECTION 註解標記時為 true）
 *
 * 更新時間：2026-02-06
 * 作者：AI Assistant
 * 摘要：COBOL 程式 AST 根節點
 */

namespace ConvertCobol.Models;

public class ProgramAst
{
    public string? ProgramId { get; set; }
    public DivisionNode? Identification { get; set; }
    public DivisionNode? Environment { get; set; }
    public DivisionNode? Data { get; set; }
    public DivisionNode? Procedure { get; set; }

    public int FdCount { get; set; }
    public int DataItem01Count { get; set; }
    public int DataItem77Count { get; set; }
    public int TotalDataItems { get; set; }
    public int SectionCount { get; set; }
    public int ParagraphCount { get; set; }
    public int StatementCount { get; set; }

    /// <summary>True when source contains the commented SCREEN SECTION marker (AcuListingCleaner step 9).</summary>
    public bool HasScreenSection { get; set; }

    /// <summary>Number of screen description items in SCREEN SECTION (all levels, recursive).</summary>
    public int ScreenSectionItemCount { get; set; }

    /// <summary>Number of file control entries in FILE-CONTROL paragraph.</summary>
    public int FileControlEntryCount { get; set; }
}
