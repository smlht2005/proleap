/*
 * 更新時間：2026-02-06
 * 作者：AI Assistant
 * 摘要：COBOL 資料項目節點（PIC、OCCURS、REDEFINES）
 */

namespace ConvertCobol.Models;

public class DataItemNode : AstNode
{
    public int Level { get; set; }
    public string Name { get; set; } = "";
    public string? PicClause { get; set; }
    public string? Redefines { get; set; }
    public string? Occurs { get; set; }
    public string? ValueClause { get; set; }
    public List<DataItemNode> Children { get; set; } = [];
}
