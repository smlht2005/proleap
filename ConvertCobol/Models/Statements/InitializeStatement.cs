namespace ConvertCobol.Models.Statements;

public class InitializeStatement : StatementNode
{
    public InitializeStatement() { StatementType = "INITIALIZE"; }

    /// <summary>INITIALIZE 目標項（陣列，多個 identifier）</summary>
    public List<string>? InitializeTargets { get; set; }
}
