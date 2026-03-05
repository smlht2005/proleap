namespace ConvertCobol.Models.Statements;

public class OpenStatement : StatementNode
{
    public OpenStatement() { StatementType = "OPEN"; }

    /// <summary>OPEN 類型：INPUT / OUTPUT / I-O / EXTEND</summary>
    public string? OpenType { get; set; }
    /// <summary>OPEN 涉及的檔案清單</summary>
    public List<string>? OpenTargets { get; set; }
}
