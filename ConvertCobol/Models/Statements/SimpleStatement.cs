namespace ConvertCobol.Models.Statements;

/// <summary>
/// 涵蓋 GOBACK, STOP, EXIT, ADD, CONTINUE, GOTO, SEARCH, CANCEL, DELETE,
/// SET, CREATE, MODIFY, INQUIRE, DESTROY, 及其他未特定建模的語句類型。
/// </summary>
public class SimpleStatement : StatementNode
{
    public SimpleStatement() { }
    public SimpleStatement(string statementType) { StatementType = statementType; }
}
