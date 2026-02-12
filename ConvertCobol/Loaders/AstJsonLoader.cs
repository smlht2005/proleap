/*
 * 更新時間：2026-02-09
 * 作者：AI Assistant
 * 摘要：從 JSON 檔讀入 ProgramAst，供 Visitor 走訪或程式使用
 */

using System.Text.Json;
using System.Text.Json.Serialization;
using ConvertCobol.Models;

namespace ConvertCobol.Loaders;

public class AstJsonLoader
{
    private static readonly JsonSerializerOptions Options = new()
    {
        PropertyNameCaseInsensitive = true,
        PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
        ReadCommentHandling = JsonCommentHandling.Skip,
        AllowTrailingCommas = true
    };

    /// <summary>從 JSON 字串載入 ProgramAst</summary>
    public static ProgramAst? LoadFromString(string json)
    {
        using var doc = JsonDocument.Parse(json);
        var root = doc.RootElement;

        // 支援兩種格式：完整 wrapper（含 Meta、Overview、Ast）或直接為 AST
        JsonElement astElement;
        if (root.TryGetProperty("ast", out var astProp))
            astElement = astProp;
        else if (root.TryGetProperty("Ast", out var astProp2))
            astElement = astProp2;
        else
            astElement = root;

        return JsonSerializer.Deserialize<ProgramAst>(astElement.GetRawText(), Options);
    }

    /// <summary>從 JSON 檔載入 ProgramAst</summary>
    public static ProgramAst? LoadFromFile(string path)
    {
        var json = File.ReadAllText(path);
        return LoadFromString(json);
    }
}
