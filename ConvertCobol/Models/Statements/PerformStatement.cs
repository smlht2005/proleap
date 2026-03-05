namespace ConvertCobol.Models.Statements;

public class PerformStatement : StatementNode
{
    public PerformStatement() { StatementType = "PERFORM"; }

    /// <summary>PERFORM 目標段落名（單一或 THRU 起點）</summary>
    public string? PerformTarget { get; set; }
    /// <summary>PERFORM THRU 終點段落名</summary>
    public string? PerformThru { get; set; }
    /// <summary>PERFORM 是否為 inline（有內嵌 statement* / END-PERFORM）</summary>
    public bool PerformInline { get; set; }
    /// <summary>PERFORM 類型：TIMES / UNTIL / VARYING 等</summary>
    public string? PerformType { get; set; }
    /// <summary>PERFORM UNTIL 條件</summary>
    public string? PerformUntilCondition { get; set; }
    /// <summary>PERFORM inline 內嵌語句清單</summary>
    public List<StatementNode>? PerformStatements { get; set; }
    /// <summary>PERFORM inline 區塊結束關鍵字（如 END-PERFORM）</summary>
    public string? PerformBlockEnd { get; set; }
}
