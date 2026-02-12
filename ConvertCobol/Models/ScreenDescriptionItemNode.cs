/*
 * 更新時間：2026-02-09 16:22
 * 作者：AI Assistant
 * 摘要：確認 Level 為 string 類型，GuiProperties 使用自定義 JSON converter 將 COL 和 LINE 值轉換為數字
 *
 * 更新時間：2026-02-09 23:30
 * 作者：AI Assistant
 * 摘要：將 Level 從 int 改為 string，GuiProperties 使用自定義 JSON converter 將 COL 和 LINE 值轉換為數字
 *
 * 更新時間：2026-02-10 15:00
 * 作者：AI Assistant
 * 摘要：重構 guiProperties 為 Dictionary<string, string>（key-value 格式），添加 Children 屬性建立父子關係
 *
 * 更新時間：2026-02-09 22:00
 * 作者：AI Assistant
 * 摘要：SCREEN SECTION 螢幕描述項節點（level/name、標準子句欄位、ACUCOBOL GUI GuiType/GuiProperties）
 */

using System.Text.Json.Serialization;
using ConvertCobol.Converters;

namespace ConvertCobol.Models;

public class ScreenDescriptionItemNode : AstNode
{
    public string Level { get; set; } = "";
    public string Name { get; set; } = "";

    /// <summary>標準 COBOL 螢幕子句：LINE、COLUMN、SIZE、VALUE、PICTURE、顏色等。</summary>
    public string? LineClause { get; set; }
    public string? ColumnClause { get; set; }
    public string? SizeClause { get; set; }
    public string? ValueClause { get; set; }
    public string? PictureClause { get; set; }
    public string? ForegroundColorClause { get; set; }
    public string? BackgroundColorClause { get; set; }

    /// <summary>ACUCOBOL GUI 型別，如 "Frame"、"Label"。</summary>
    public string? GuiType { get; set; }

    /// <summary>ACUCOBOL GUI 屬性（key-value 格式）。
    /// Key: 屬性名稱（如 "COL"、"LINE"、"COLOR_IS"、"EXCEPTION PROCEDURE"）
    ///   - Key 中包含空格時用底線替換（如 "COLOR IS" => "COLOR_IS"）
    ///   - 特殊：EXCEPTION PROCEDURE 保持原樣
    /// Value: 屬性值（如 "1.00"、"S-RCB1-Exception-Proc"、"True"）
    ///   - 無法拆分時 value 為 "True"（而非空字串）
    ///   - COL 和 LINE 在 JSON 序列化時會轉換為數字
    /// </summary>
    [JsonConverter(typeof(GuiPropertiesJsonConverter))]
    public Dictionary<string, string> GuiProperties { get; set; } = new();

    /// <summary>子項目列表（建立父子關係，類似 DataItemNode）。</summary>
    public List<ScreenDescriptionItemNode> Children { get; set; } = [];
}
