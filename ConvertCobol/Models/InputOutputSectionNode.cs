/*
 * 更新時間：2026-02-09 16:45
 * 作者：AI Assistant
 * 摘要：INPUT-OUTPUT SECTION 節點，children 為 FILE-CONTROL 的 FileControlEntry 列表
 */

namespace ConvertCobol.Models;

public class InputOutputSectionNode : AstNode
{
    public string SectionName { get; set; } = "INPUT-OUTPUT";
    public List<AstNode> Children { get; set; } = [];
}
