/*
 * 更新時間：2026-02-09 16:15
 * 作者：AI Assistant
 * 摘要：FILE-CONTROL 單一 SELECT 項目，子句拆成具名欄位（非合併字串）
 *
 * 更新時間：2026-02-09 16:00
 * 作者：AI Assistant
 * 摘要：FILE-CONTROL 單一 SELECT 項目（檔名 + 子句列表），供 ENVIRONMENT DIVISION JSON 輸出
 */

namespace ConvertCobol.Models;

public class FileControlEntryNode : AstNode
{
    public string FileName { get; set; } = "";
    public bool Optional { get; set; }

    /// <summary>ASSIGN 實際指定值（字面值去引號），如 HG_MNID、HH_MPAT</summary>
    public string? AssignTo { get; set; }

    /// <summary>ORGANIZATION：SEQUENTIAL | RELATIVE | INDEXED</summary>
    public string? Organization { get; set; }

    /// <summary>ACCESS MODE：SEQUENTIAL | RANDOM | DYNAMIC | EXCLUSIVE</summary>
    public string? AccessMode { get; set; }

    /// <summary>LOCK MODE：MANUAL | AUTOMATIC | EXCLUSIVE</summary>
    public string? LockMode { get; set; }

    /// <summary>FILE STATUS 資料名稱（主）</summary>
    public string? FileStatus { get; set; }

    /// <summary>RECORD KEY 鍵名</summary>
    public string? RecordKeyName { get; set; }

    /// <summary>RECORD KEY 欄位列表（= 後）</summary>
    public List<string> RecordKeyFields { get; set; } = [];

    /// <summary>ALTERNATE RECORD KEY 列表</summary>
    public List<AlternateKeyNode> AlternateRecordKeys { get; set; } = [];

    /// <summary>WITH COMPRESSION 時為 true</summary>
    public bool Compression { get; set; }

    /// <summary>COMPRESSION CONTROL VALUE 數值（無則 null）</summary>
    public int? CompressionControlValue { get; set; }

    /// <summary>其餘子句（RESERVE、PADDING、RELATIVE KEY 等）原文</summary>
    public List<string> OtherClauses { get; set; } = [];
}
