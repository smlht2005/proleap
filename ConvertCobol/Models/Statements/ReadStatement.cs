namespace ConvertCobol.Models.Statements;

public class ReadStatement : StatementNode
{
    public ReadStatement() { StatementType = "READ"; }

    /// <summary>READ 檔案名稱</summary>
    public string? ReadTarget { get; set; }
    /// <summary>READ NEXT RECORD 是否為 NEXT</summary>
    public bool ReadNext { get; set; }
    /// <summary>READ INTO 目標 identifier</summary>
    public string? ReadInto { get; set; }
    /// <summary>READ KEY IS 後面的 key 名稱</summary>
    public string? ReadKey { get; set; }
}
