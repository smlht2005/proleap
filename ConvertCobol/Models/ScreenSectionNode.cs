/*
 * 更新時間：2026-02-09 19:45
 * 作者：AI Assistant
 * 摘要：DATA DIVISION SCREEN SECTION 節點，children 為 DataItem/ScreenDescription 列表
 */

namespace ConvertCobol.Models;

public class ScreenSectionNode : AstNode
{
    public string SectionName { get; set; } = "SCREEN";
    public List<AstNode> Children { get; set; } = [];
}
