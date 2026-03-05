namespace ConvertCobol.Models;

public class StatementNode : AstNode
{
    public string StatementType { get; set; } = "";
    public string? Text { get; set; }
}
