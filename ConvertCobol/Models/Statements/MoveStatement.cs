namespace ConvertCobol.Models.Statements;

public class MoveStatement : StatementNode
{
    public MoveStatement() { StatementType = "MOVE"; }

    /// <summary>MOVE 來源（由 Visitor 填入或由 CodeGen 從 Text 解析）</summary>
    public string? MoveFrom { get; set; }
    /// <summary>MOVE 目標，多目標時以逗號分隔</summary>
    public string? MoveTo { get; set; }
}
