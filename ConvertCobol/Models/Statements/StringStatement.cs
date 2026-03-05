namespace ConvertCobol.Models.Statements;

public class StringStatement : StatementNode
{
    public StringStatement() { StatementType = "STRING"; }

    /// <summary>STRING INTO 目標</summary>
    public string? StringInto { get; set; }
    /// <summary>STRING POINTER 變數</summary>
    public string? StringPointer { get; set; }
}
