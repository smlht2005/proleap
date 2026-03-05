namespace ConvertCobol.Models.Statements;

public class StartStatement : StatementNode
{
    public StartStatement() { StatementType = "START"; }

    /// <summary>START 檔案名稱</summary>
    public string? StartTarget { get; set; }
    /// <summary>START KEY 比較運算</summary>
    public string? StartKeyOperator { get; set; }
    /// <summary>START KEY 的 qualifiedDataName</summary>
    public string? StartKeyDataName { get; set; }
}
