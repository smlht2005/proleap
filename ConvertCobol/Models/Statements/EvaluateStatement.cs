namespace ConvertCobol.Models.Statements;

public class EvaluateStatement : StatementNode
{
    public EvaluateStatement() { StatementType = "EVALUATE"; }

    /// <summary>EVALUATE 主體</summary>
    public string? EvaluateSubject { get; set; }
    /// <summary>EVALUATE 各 WHEN 區塊（條件 + 語句）</summary>
    public List<EvaluateWhenClause>? EvaluateWhenPhrases { get; set; }
    /// <summary>EVALUATE WHEN OTHER 區塊內語句</summary>
    public List<StatementNode>? EvaluateWhenOtherStatements { get; set; }
    /// <summary>EVALUATE 區塊結束關鍵字</summary>
    public string? EvaluateBlockEnd { get; set; }
}
