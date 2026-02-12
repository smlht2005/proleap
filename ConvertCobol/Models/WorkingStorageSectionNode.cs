/*
 * 更新時間：2026-02-09 19:45
 * 作者：AI Assistant
 * 摘要：DATA DIVISION WORKING-STORAGE SECTION 節點，children 為 DataItem 列表
 */

namespace ConvertCobol.Models;

public class WorkingStorageSectionNode : AstNode
{
    public string SectionName { get; set; } = "WORKING-STORAGE";
    public List<AstNode> Children { get; set; } = [];
}
