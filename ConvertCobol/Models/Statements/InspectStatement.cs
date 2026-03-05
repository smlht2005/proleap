namespace ConvertCobol.Models.Statements;

public class InspectStatement : StatementNode
{
    public InspectStatement() { StatementType = "INSPECT"; }

    /// <summary>INSPECT 主體 identifier</summary>
    public string? InspectTarget { get; set; }
    /// <summary>INSPECT TALLYING 目標</summary>
    public string? InspectTallying { get; set; }
    /// <summary>INSPECT TALLYING FOR 後段文字</summary>
    public string? InspectTallyingFor { get; set; }
}
