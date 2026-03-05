namespace ConvertCobol.Models.Statements;

public class CallStatement : StatementNode
{
    public CallStatement() { StatementType = "CALL"; }

    /// <summary>CALL 被呼叫名（identifier 或 literal）</summary>
    public string? CallTarget { get; set; }
    /// <summary>CALL USING 參數列</summary>
    public List<string>? CallArgs { get; set; }
}
