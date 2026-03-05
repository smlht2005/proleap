namespace ConvertCobol.Models.Statements;

public class AcceptStatement : StatementNode
{
    public AcceptStatement() { StatementType = "ACCEPT"; }

    /// <summary>ACCEPT 目標 identifier</summary>
    public string? AcceptTarget { get; set; }
    /// <summary>ACCEPT FROM ENVIRONMENT 的環境變數 literal</summary>
    public string? AcceptFromEnvironment { get; set; }
    /// <summary>ACCEPT 區塊結束關鍵字</summary>
    public string? AcceptBlockEnd { get; set; }
}
