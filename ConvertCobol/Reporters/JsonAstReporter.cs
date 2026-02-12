/*
 * 更新時間：2026-02-09 18:35
 * 作者：AI Assistant
 * 摘要：Overview 新增 screenSectionItemCount、fileControlEntryCount
 *
 * 更新時間：2026-02-09 18:24
 * 作者：AI Assistant
 * 摘要：修復中文字符顯示問題：添加 Encoder = JavaScriptEncoder.UnsafeRelaxedJsonEscaping，確保中文字符（如 "細明體12"）在 JSON 中正確顯示，而不是轉義為 Unicode 序列（如 "\u875D\u5533?\u64C3?2"）
 *
 * 更新時間：2026-02-09 20:15
 * 作者：AI Assistant
 * 摘要：Overview 新增 hasScreenSection（來源含 SCREEN SECTION 註解標記時為 true）
 *
 * 更新時間：2026-02-09
 * 作者：AI Assistant
 * 摘要：將 ProgramAst 序列化為 JSON，供程式讀入與 Visitor 走訪
 */

using System.Text.Encodings.Web;
using System.Text.Json;
using System.Text.Json.Serialization;
using ConvertCobol.Converters;
using ConvertCobol.Models;

namespace ConvertCobol.Reporters;

public class JsonAstReporter
{
    private static readonly JsonSerializerOptions Options = new()
    {
        WriteIndented = true,
        PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
        DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull,
        Encoder = JavaScriptEncoder.UnsafeRelaxedJsonEscaping,  // 保留中文字符，不進行 Unicode 轉義
        Converters = { new StatementNodeJsonConverter() }
    };

    public string Generate(ProgramAst ast, string sourceFile, TimeSpan parseTime)
    {
        var wrapper = new
        {
            Meta = new
            {
                GeneratedAt = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                SourceFile = Path.GetFileName(sourceFile),
                Parser = "ANTLR4 Cobol85Acu (C#)",
                ParseTimeMs = parseTime.TotalMilliseconds
            },
            Overview = new
            {
                ast.ProgramId,
                ast.FdCount,
                ast.DataItem01Count,
                ast.DataItem77Count,
                ast.TotalDataItems,
                ast.SectionCount,
                ast.ParagraphCount,
                ast.StatementCount,
                ast.HasScreenSection,
                ast.ScreenSectionItemCount,
                ast.FileControlEntryCount
            },
            Ast = ast
        };

        return JsonSerializer.Serialize(wrapper, Options);
    }
}
