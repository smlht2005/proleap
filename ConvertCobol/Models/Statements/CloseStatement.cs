namespace ConvertCobol.Models.Statements;

public class CloseStatement : StatementNode
{
    public CloseStatement() { StatementType = "CLOSE"; }

    /// <summary>CLOSE 關閉的檔案列表</summary>
    public List<string>? CloseTargets { get; set; }
}
