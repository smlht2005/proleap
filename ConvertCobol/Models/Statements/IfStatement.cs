namespace ConvertCobol.Models.Statements;

public class IfStatement : StatementNode
{
    public IfStatement() { StatementType = "IF"; }

    /// <summary>IF 條件式</summary>
    public string? IfCondition { get; set; }
    /// <summary>IF THEN 區塊文字</summary>
    public string? IfThenText { get; set; }
    /// <summary>IF ELSE 區塊文字</summary>
    public string? IfElseText { get; set; }
    /// <summary>IF THEN 子語句清單（巢狀 AST）</summary>
    public List<StatementNode>? ThenStatements { get; set; }
    /// <summary>IF ELSE 子語句清單（巢狀 AST）</summary>
    public List<StatementNode>? ElseStatements { get; set; }
    /// <summary>IF 區塊結束關鍵字（如 END-IF）</summary>
    public string? IfBlockEnd { get; set; }
    /// <summary>IF THEN 區塊中的註解行</summary>
    public List<string>? IfThenComments { get; set; }
}
