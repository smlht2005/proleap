/*
 * 更新時間：2026-02-09 16:22
 * 作者：AI Assistant
 * 摘要：確認自定義 JSON converter，將 GuiProperties 中的 COL 和 LINE 值從字符串轉換為數字
 *
 * 更新時間：2026-02-09 23:30
 * 作者：AI Assistant
 * 摘要：自定義 JSON converter，將 GuiProperties 中的 COL 和 LINE 值從字符串轉換為數字
 */

using System.Text.Json;
using System.Text.Json.Serialization;
using ConvertCobol.Models;

namespace ConvertCobol.Converters;

public class GuiPropertiesJsonConverter : JsonConverter<Dictionary<string, string>>
{
    public override Dictionary<string, string> Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
    {
        // 讀取時保持原樣（字符串）
        var dict = new Dictionary<string, string>();
        if (reader.TokenType != JsonTokenType.StartObject)
        {
            throw new JsonException();
        }

        while (reader.Read())
        {
            if (reader.TokenType == JsonTokenType.EndObject)
            {
                return dict;
            }

            if (reader.TokenType == JsonTokenType.PropertyName)
            {
                var key = reader.GetString() ?? "";
                reader.Read();
                
                if (reader.TokenType == JsonTokenType.String)
                {
                    dict[key] = reader.GetString() ?? "";
                }
                else if (reader.TokenType == JsonTokenType.Number)
                {
                    // 如果是數字，轉換為字符串
                    dict[key] = reader.GetDecimal().ToString();
                }
            }
        }

        throw new JsonException();
    }

    public override void Write(Utf8JsonWriter writer, Dictionary<string, string> value, JsonSerializerOptions options)
    {
        writer.WriteStartObject();
        
        foreach (var kvp in value)
        {
            writer.WritePropertyName(kvp.Key);
            
            // 對於 COL 和 LINE，嘗試轉換為數字
            if ((kvp.Key == "COL" || kvp.Key == "LINE") && 
                TryParseNumber(kvp.Value, out var number))
            {
                writer.WriteNumberValue(number);
            }
            else
            {
                writer.WriteStringValue(kvp.Value);
            }
        }
        
        writer.WriteEndObject();
    }

    private static bool TryParseNumber(string value, out decimal number)
    {
        // 移除可能的單位（如 "CELLS"、"3.50"）
        var cleaned = value.Trim();
        
        // 如果包含空格，只取第一部分（例如 "1.00 CELLS" => "1.00"）
        var spaceIndex = cleaned.IndexOf(' ');
        if (spaceIndex > 0)
        {
            cleaned = cleaned.Substring(0, spaceIndex);
        }
        
        return decimal.TryParse(cleaned, System.Globalization.NumberStyles.Float, 
            System.Globalization.CultureInfo.InvariantCulture, out number);
    }
}
