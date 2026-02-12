/*
 * 更新時間：2026-02-09 19:45
 * 作者：AI Assistant
 * 摘要：DATA DIVISION FILE SECTION 節點，children 為 FileDescription 列表
 */

namespace ConvertCobol.Models;

public class FileSectionNode : AstNode
{
    public string SectionName { get; set; } = "FILE";
    public List<AstNode> Children { get; set; } = [];
}
