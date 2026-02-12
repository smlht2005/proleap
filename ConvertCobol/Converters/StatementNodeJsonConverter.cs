/*
 * 更新時間：2026-02-11
 * 作者：AI Assistant
 * 摘要：僅在 type 為 PERFORM 時輸出 performInline；僅在 type 為 READ 時輸出 readNext；其他類型不輸出這兩個屬性
 */

using System.Linq;
using System.Text.Json;
using System.Text.Json.Nodes;
using System.Text.Json.Serialization;
using ConvertCobol.Models;

namespace ConvertCobol.Converters;

public class StatementNodeJsonConverter : JsonConverter<StatementNode>
{
    public override StatementNode? Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
    {
        // 反序列化時需排除本 converter，避免遞迴
        var opts = new JsonSerializerOptions(options);
        for (var i = opts.Converters.Count - 1; i >= 0; i--)
        {
            if (opts.Converters[i] is StatementNodeJsonConverter)
                opts.Converters.RemoveAt(i);
        }
        return JsonSerializer.Deserialize<StatementNode>(ref reader, opts);
    }

    public override void Write(Utf8JsonWriter writer, StatementNode value, JsonSerializerOptions options)
    {
        // 使用不含本 converter 的 options，避免遞迴
        var opts = new JsonSerializerOptions(options);
        for (var i = opts.Converters.Count - 1; i >= 0; i--)
        {
            if (opts.Converters[i] is StatementNodeJsonConverter)
                opts.Converters.RemoveAt(i);
        }
        var node = JsonSerializer.SerializeToNode(value, value.GetType(), opts);
        RemoveUnwantedPropsFromStatementTree(node);
        node?.WriteTo(writer, options);
    }

    /// <summary>遞迴移除非 PERFORM/READ 的 performInline、readNext</summary>
    private static void RemoveUnwantedPropsFromStatementTree(JsonNode? node)
    {
        if (node is JsonObject obj)
        {
            var statementType = obj["statementType"]?.GetValue<string>();
            if (!string.IsNullOrEmpty(statementType))
            {
                if (statementType != "PERFORM") obj.Remove("performInline");
                if (statementType != "READ") obj.Remove("readNext");
            }
            foreach (var key in obj.Select(p => p.Key).ToList())
            {
                RemoveUnwantedPropsFromStatementTree(obj[key]);
            }
        }
        else if (node is JsonArray arr)
        {
            foreach (var item in arr)
                RemoveUnwantedPropsFromStatementTree(item);
        }
    }
}
