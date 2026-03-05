namespace ConvertCobol.Models.Statements;

public class DisplayStatement : StatementNode
{
    public DisplayStatement() { StatementType = "DISPLAY"; }

    /// <summary>DISPLAY 運算元（key-value 物件）</summary>
    public Dictionary<string, string>? DisplayOperands { get; set; }
    /// <summary>DISPLAY UPON 目標</summary>
    public string? DisplayUpon { get; set; }
    /// <summary>DISPLAY AT 位置</summary>
    public string? DisplayAt { get; set; }
    /// <summary>DISPLAY WITH 子句</summary>
    public string? DisplayWith { get; set; }
    /// <summary>DISPLAY 區塊結束</summary>
    public string? DisplayBlockEnd { get; set; }
    /// <summary>DISPLAY WINDOW 類型</summary>
    public string? DisplayType { get; set; }
    /// <summary>DISPLAY WINDOW 標記</summary>
    public string? DisplayWindow { get; set; }
    /// <summary>DISPLAY LINES 值</summary>
    public string? DisplayLines { get; set; }
    /// <summary>DISPLAY SIZE 值</summary>
    public string? DisplaySize { get; set; }
    /// <summary>DISPLAY CELL HEIGHT 值</summary>
    public string? DisplayCellHeight { get; set; }
    /// <summary>DISPLAY CELL WIDTH 值</summary>
    public string? DisplayCellWidth { get; set; }
    /// <summary>DISPLAY COLOR IS 值</summary>
    public string? DisplayColor { get; set; }
    /// <summary>DISPLAY LABEL-OFFSET 值</summary>
    public string? DisplayLabelOffset { get; set; }
    /// <summary>DISPLAY LINK TO 值</summary>
    public string? DisplayLinkTo { get; set; }
    /// <summary>DISPLAY NO SCROLL 標記</summary>
    public bool DisplayNoScroll { get; set; }
    /// <summary>DISPLAY TITLE 值</summary>
    public string? DisplayTitle { get; set; }
    /// <summary>DISPLAY TITLE-BAR 標記</summary>
    public bool DisplayTitleBar { get; set; }
    /// <summary>DISPLAY NO WRAP 標記</summary>
    public bool DisplayNoWrap { get; set; }
    /// <summary>DISPLAY HANDLE IS 值</summary>
    public string? DisplayHandle { get; set; }
}
