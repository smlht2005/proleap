/*
 * 更新時間：2026-02-09 19:45
 * 作者：AI Assistant
 * 摘要：DATA DIVISION LINKAGE SECTION 節點，children 為 DataItem 列表
 */

namespace ConvertCobol.Models;

public class LinkageSectionNode : AstNode
{
    public string SectionName { get; set; } = "LINKAGE";
    public List<AstNode> Children { get; set; } = [];
}
