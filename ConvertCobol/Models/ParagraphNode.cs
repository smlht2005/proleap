/*
 * 更新時間：2026-02-06
 * 作者：AI Assistant
 * 摘要：COBOL 段落/區段節點
 */

namespace ConvertCobol.Models;

public class ParagraphNode : AstNode
{
    public string Name { get; set; } = "";
    public bool IsSection { get; set; }
    public List<StatementNode> Statements { get; set; } = [];
}
