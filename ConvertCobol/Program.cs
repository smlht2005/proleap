/*
 * COBOL-to-AST 主程式
 * 串接：前處理 → ANTLR 解析 → AST 訪問 → JSON/Markdown 輸出
 */

using System.Configuration;
using System.Diagnostics;
using System.Text;
using System.Text.RegularExpressions;
using Antlr4.Runtime;
using ConvertCobol.Generated;
using ConvertCobol.Loaders;
using ConvertCobol.Preprocessing;
using ConvertCobol.Parsing;
using ConvertCobol.CodeGen;
using ConvertCobol.Reporters;
using ConvertCobol.Visitors;
using ConvertCobol.Models;
using Microsoft.Extensions.Logging;

// 註冊 CodePages 編碼（MS950/Big5）— 必須在任何 GetEncoding 之前
Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);

if (args.Length < 1)
{
    Console.WriteLine("用法:");
    Console.WriteLine("  ConvertCobol ast <input.lst|input.cbl> [output.md|output.json] [charset] [procedure.cs]");
    Console.WriteLine("  ConvertCobol read <input.json>");
    Console.WriteLine("  ConvertCobol emit <input_proc.json> [output] [--format pseudo|mermaid|both]");
    Console.WriteLine("  ast   - 產生 AST 報告（副檔名 .json 則輸出 JSON，否則 Markdown）");
    Console.WriteLine("  未指定時可由環境變數或 App.config 讀取：CONVERTCOBOL_AST_INPUT / CONVERTCOBOL_AST_OUTPUT / CONVERTCOBOL_AST_CHARSET");
    Console.WriteLine("  read  - 從 JSON 載入 AST 並顯示摘要");
    Console.WriteLine("  emit  - 從 proc JSON 產生 pseudo code / mermaid flowchart");
    Console.WriteLine("  預設 charset: big5");
    return 1;
}

// 解析 --verbose / -v 旗標
var verbose = args.Any(a => a == "--verbose" || a == "-v");
using var loggerFactory = LoggerFactory.Create(builder =>
{
    builder.AddSimpleConsole(options =>
    {
        options.SingleLine = true;
        options.TimestampFormat = "[HH:mm:ss] ";
    });
    if (verbose)
        builder.SetMinimumLevel(LogLevel.Trace);
    else
        builder.SetMinimumLevel(LogLevel.Warning);
});
var visitorLogger = loggerFactory.CreateLogger<CobolAstVisitor>();
var errorLogger = loggerFactory.CreateLogger("ConvertCobol.Parsing");

var command = args.Length >= 1 ? args[0].ToLowerInvariant() : "";

if (command == "read")
{
    return RunReadCommand(args);
}

if (command == "emit")
{
    return RunEmitCommand(args);
}

if (command != "ast")
{
    Console.WriteLine("用法: ConvertCobol ast <input> [output] [charset] | read <input.json> | emit <input_proc.json>");
    return 1;
}

var inputPath = GetAstArg(args, 1, "CONVERTCOBOL_AST_INPUT", "AstDefaultInputPath");
if (string.IsNullOrEmpty(inputPath))
{
    Console.WriteLine("請指定輸入檔案（或設定環境變數 CONVERTCOBOL_AST_INPUT / App.config AstDefaultInputPath）");
    return 1;
}
var outputPath = GetAstArg(args, 2, "CONVERTCOBOL_AST_OUTPUT", "AstDefaultOutputPath");
var charsetName = GetAstArg(args, 3, "CONVERTCOBOL_AST_CHARSET", "AstDefaultCharset");
if (string.IsNullOrEmpty(charsetName)) charsetName = "big5";
if (!string.IsNullOrEmpty(outputPath) && outputPath.StartsWith("--")) outputPath = "";
if (!string.IsNullOrEmpty(charsetName) && charsetName.StartsWith("--")) charsetName = "big5";

if (!File.Exists(inputPath))
{
    Console.WriteLine($"錯誤：找不到輸入檔案 {inputPath}");
    return 1;
}

var encoding = EncodingHelper.GetEncodingOrDefault(charsetName);
string cblPath = inputPath;
string sourceForReport = inputPath;

// 若輸入為 .lst，先清理轉為 .cbl
if (inputPath.EndsWith(".lst", StringComparison.OrdinalIgnoreCase))
{
    var inputDir = Path.GetDirectoryName(Path.GetFullPath(inputPath)) ?? ".";
    var projectRoot = Directory.GetParent(inputDir)?.FullName ?? inputDir;
    var cblDir = Path.Combine(projectRoot, "cbl");
    cblPath = Path.Combine(cblDir, Path.GetFileNameWithoutExtension(inputPath) + ".cbl");
    var cleaner = new AcuListingCleaner();
    var result = cleaner.Clean(inputPath, cblPath, encoding);
    Console.WriteLine(result.ToString());
    sourceForReport = cblPath;
}

// 讀取 COBOL 原始碼
var readEncoding = inputPath.EndsWith(".lst", StringComparison.OrdinalIgnoreCase)
    ? Encoding.UTF8
    : EncodingHelper.DetectEncoding(cblPath, encoding);
var cobolSource = File.ReadAllText(cblPath, readEncoding);

// 偵測是否含 SCREEN SECTION
var hasScreenSection = (cobolSource.Contains("[SCREEN SECTION", StringComparison.OrdinalIgnoreCase)
        && cobolSource.Contains("ACUCOBOL GUI", StringComparison.OrdinalIgnoreCase))
    || Regex.IsMatch(cobolSource, @"SCREEN\s+SECTION", RegexOptions.IgnoreCase);

// 預處理：將傳統 * 註解行轉為 *> 格式
cobolSource = CommentNormalizer.ConvertTraditionalComments(cobolSource);

// 預處理：移除 ACUCOBOL-GT 擴充語法（WITH CONVERT 等）
cobolSource = AcuSyntaxNormalizer.NormalizeAll(cobolSource);

// ANTLR 解析
var sw = Stopwatch.StartNew();
var inputStream = new AntlrInputStream(cobolSource);
var lexer = new Cobol85AcuLexer(inputStream);
var tokenStream = new CommonTokenStream(lexer);
var parser = new Cobol85AcuParser(tokenStream);

lexer.RemoveErrorListeners();
lexer.AddErrorListener(new LexerErrorListener(errorLogger));
parser.RemoveErrorListeners();
parser.AddErrorListener(new ParserErrorListener(errorLogger));

parser.ErrorHandler = new DefaultErrorStrategy();
var tree = parser.startRule();
sw.Stop();

// AST 訪問
var visitor = new CobolAstVisitor(visitorLogger);
visitor.SetCobolSource(cobolSource);
visitor.Visit(tree);
var ast = visitor.Result;
ast.HasScreenSection = hasScreenSection;

// Plan 2a：若全檔解析未產出 procedure，改以 procedure-only 子字串解析並合併
var procedureEmpty = ast.Procedure == null || (ast.Procedure.Children?.Count ?? 0) == 0;
if (procedureEmpty)
{
    var procMark = "PROCEDURE DIVISION";
    var idx = cobolSource.IndexOf(procMark, StringComparison.OrdinalIgnoreCase);
    if (idx >= 0)
    {
        var procedureSource = CommentNormalizer.NormalizeProcedureComments(cobolSource.Substring(idx));
        var procInput = new AntlrInputStream(procedureSource);
        var procLexer = new Cobol85AcuLexer(procInput);
        var procStream = new CommonTokenStream(procLexer);
        var procParser = new Cobol85AcuParser(procStream);
        procLexer.RemoveErrorListeners();
        procLexer.AddErrorListener(new LexerErrorListener(errorLogger));
        procParser.RemoveErrorListeners();
        procParser.AddErrorListener(new ParserErrorListener(errorLogger));
        procParser.ErrorHandler = new DefaultErrorStrategy();
        var procTree = procParser.procedureOnlyStart();
        var procVisitor = new CobolAstVisitor(visitorLogger);
        procVisitor.SetCobolSource(procedureSource);
        procVisitor.Visit(procTree);
        var procAst = procVisitor.Result;
        if (procAst.Procedure != null && (procAst.Procedure.Children?.Count ?? 0) > 0)
        {
            ast.Procedure = procAst.Procedure;
            ast.ParagraphCount = procAst.ParagraphCount;
            ast.StatementCount = procAst.StatementCount;
            visitorLogger.LogInformation("[Plan 2a] PROCEDURE DIVISION 已由 procedure-only 解析補入，段落數: {ParagraphCount}，語句數: {StatementCount}", ast.ParagraphCount, ast.StatementCount);
        }
    }
}

// 續行誤併修正
CobolAstVisitor.NormalizeAllProcedureStatements(ast.Procedure);

// 輸出
if (string.IsNullOrEmpty(outputPath))
{
    var baseName = Path.GetFileNameWithoutExtension(sourceForReport);
    var astDir = Path.Combine(Path.GetDirectoryName(cblPath) ?? ".", "..", "ast");
    outputPath = Path.GetFullPath(Path.Combine(astDir, $"{baseName}_ast.md"));
}
var isJson = outputPath.EndsWith(".json", StringComparison.OrdinalIgnoreCase);

string content;
if (isJson)
{
    var jsonReporter = new JsonAstReporter();
    content = jsonReporter.Generate(ast, sourceForReport, sw.Elapsed);

    var dataAst = new ProgramAst
    {
        ProgramId = ast.ProgramId,
        Identification = ast.Identification,
        Environment = ast.Environment,
        Data = ast.Data,
        Procedure = null,
        FdCount = ast.FdCount,
        DataItem01Count = ast.DataItem01Count,
        DataItem77Count = ast.DataItem77Count,
        TotalDataItems = ast.TotalDataItems,
        SectionCount = ast.SectionCount,
        ParagraphCount = 0,
        StatementCount = 0,
        HasScreenSection = ast.HasScreenSection,
        ScreenSectionItemCount = ast.ScreenSectionItemCount,
        FileControlEntryCount = ast.FileControlEntryCount
    };

    var procAst = new ProgramAst
    {
        ProgramId = ast.ProgramId,
        Identification = null,
        Environment = null,
        Data = null,
        Procedure = ast.Procedure,
        FdCount = ast.FdCount,
        DataItem01Count = ast.DataItem01Count,
        DataItem77Count = ast.DataItem77Count,
        TotalDataItems = ast.TotalDataItems,
        SectionCount = ast.SectionCount,
        ParagraphCount = ast.ParagraphCount,
        StatementCount = ast.StatementCount,
        HasScreenSection = ast.HasScreenSection,
        ScreenSectionItemCount = ast.ScreenSectionItemCount,
        FileControlEntryCount = ast.FileControlEntryCount
    };

    var jsonOutDir = Path.GetDirectoryName(outputPath) ?? ".";
    var fileName = Path.GetFileName(outputPath);

    string dataPath;
    string procPath;

    if (fileName.EndsWith("_ast.json", StringComparison.OrdinalIgnoreCase))
    {
        dataPath = Path.Combine(jsonOutDir, fileName.Replace("_ast.json", "_ast_data.json"));
        procPath = Path.Combine(jsonOutDir, fileName.Replace("_ast.json", "_ast_proc.json"));
    }
    else
    {
        var nameNoExt = Path.GetFileNameWithoutExtension(fileName);
        var ext = Path.GetExtension(fileName);
        dataPath = Path.Combine(jsonOutDir, $"{nameNoExt}_data{ext}");
        procPath = Path.Combine(jsonOutDir, $"{nameNoExt}_proc{ext}");
    }

    File.WriteAllText(dataPath, jsonReporter.Generate(dataAst, sourceForReport, sw.Elapsed), new UTF8Encoding(false));
    File.WriteAllText(procPath, jsonReporter.Generate(procAst, sourceForReport, sw.Elapsed), new UTF8Encoding(false));
    Console.WriteLine($"DATA AST 已寫入: {dataPath}");
    Console.WriteLine($"PROCEDURE AST 已寫入: {procPath}");
}
else
{
    var mdReporter = new MarkdownAstReporter();
    content = mdReporter.Generate(ast, sourceForReport, sw.Elapsed);
}

if (Directory.Exists(outputPath))
{
    var baseName = Path.GetFileNameWithoutExtension(sourceForReport);
    outputPath = Path.Combine(outputPath, isJson ? $"{baseName}_ast.json" : $"{baseName}_ast.md");
}
var outDir = Path.GetDirectoryName(outputPath);
if (!string.IsNullOrEmpty(outDir)) Directory.CreateDirectory(outDir);
try
{
    File.WriteAllText(outputPath, content, new UTF8Encoding(false));
}
catch (UnauthorizedAccessException ex)
{
    Console.Error.WriteLine($"錯誤：無法寫入 {outputPath}");
    Console.Error.WriteLine($"  {ex.Message}");
    Console.Error.WriteLine("請關閉佔用該目錄/檔案的程式（如檔案總管、編輯器），或指定其他輸出路徑。");
    return 1;
}

Console.WriteLine($"AST 報告已寫入: {outputPath}");
Console.WriteLine($"PROGRAM-ID: {ast.ProgramId}, 語句數: {ast.StatementCount}");

// 若第五參數為 .cs 路徑，一併輸出 PROCEDURE DIVISION 轉成的 C#
var procedureCsPath = args.Length > 4 && args[4].EndsWith(".cs", StringComparison.OrdinalIgnoreCase) ? args[4] : null;
if (!string.IsNullOrEmpty(procedureCsPath))
{
    var emitter = new ProcedureToCSharpEmitter();
    var csharp = emitter.EmitProcedureDivision(ast.Procedure, ast.ProgramId ?? "Program");
    var csDir = Path.GetDirectoryName(procedureCsPath);
    if (!string.IsNullOrEmpty(csDir)) Directory.CreateDirectory(csDir);
    File.WriteAllText(procedureCsPath, csharp, new UTF8Encoding(false));
    Console.WriteLine($"PROCEDURE DIVISION → C# 已寫入: {procedureCsPath}");
}

return 0;

static int RunReadCommand(string[] args)
{
    var jsonPath = args.Length >= 2 ? args[1] : "";
    if (string.IsNullOrEmpty(jsonPath) || !File.Exists(jsonPath))
    {
        Console.WriteLine("請指定存在的 JSON 檔案：ConvertCobol read <input.json>");
        return 1;
    }

    var ast = AstJsonLoader.LoadFromFile(jsonPath);
    if (ast == null)
    {
        Console.WriteLine($"錯誤：無法解析 JSON 檔 {jsonPath}");
        return 1;
    }

    Console.WriteLine("=== 從 JSON 載入的 AST 摘要 ===");
    Console.WriteLine($"PROGRAM-ID: {ast.ProgramId ?? "-"}");
    Console.WriteLine($"FD 項目: {ast.FdCount}");
    Console.WriteLine($"01-Level: {ast.DataItem01Count}");
    Console.WriteLine($"77-Level: {ast.DataItem77Count}");
    Console.WriteLine($"全部資料項目: {ast.TotalDataItems}");
    Console.WriteLine($"Sections: {ast.SectionCount}");
    Console.WriteLine($"Paragraphs: {ast.ParagraphCount}");
    Console.WriteLine($"語句數: {ast.StatementCount}");
    return 0;
}

static int RunEmitCommand(string[] args)
{
    var jsonPath = args.Length >= 2 ? args[1] : "";
    if (string.IsNullOrEmpty(jsonPath) || !File.Exists(jsonPath))
    {
        Console.WriteLine("請指定存在的 proc JSON 檔案：ConvertCobol emit <input_proc.json> [output] [--format pseudo|mermaid|both]");
        return 1;
    }

    // Parse --format flag
    var format = "both";
    for (var i = 2; i < args.Length; i++)
    {
        if (args[i] == "--format" && i + 1 < args.Length)
        {
            format = args[i + 1].ToLowerInvariant();
            break;
        }
    }

    // Parse optional output path (non-flag arg after jsonPath)
    string? outputArg = null;
    if (args.Length >= 3 && !args[2].StartsWith("--"))
        outputArg = args[2];

    var ast = AstJsonLoader.LoadFromFile(jsonPath);
    if (ast == null)
    {
        Console.WriteLine($"錯誤：無法解析 JSON 檔 {jsonPath}");
        return 1;
    }

    if (ast.Procedure == null)
    {
        Console.WriteLine("錯誤：JSON 中不含 PROCEDURE DIVISION");
        return 1;
    }

    var inputDir = Path.GetDirectoryName(Path.GetFullPath(jsonPath)) ?? ".";
    var baseName = Path.GetFileNameWithoutExtension(jsonPath);
    // Strip common suffixes for cleaner output names
    foreach (var suffix in new[] { "_ast_proc", "_proc", "_ast" })
    {
        if (baseName.EndsWith(suffix, StringComparison.OrdinalIgnoreCase))
        {
            baseName = baseName[..^suffix.Length];
            break;
        }
    }

    var emitPseudo = format is "both" or "pseudo";
    var emitMermaid = format is "both" or "mermaid";

    if (emitPseudo)
    {
        var pseudoEmitter = new ProcedureToPseudoCodeEmitter();
        var pseudoCode = pseudoEmitter.EmitProcedureDivision(ast.Procedure);
        var pseudoPath = outputArg ?? Path.Combine(inputDir, $"{baseName}_pseudo.txt");
        var pseudoDir = Path.GetDirectoryName(pseudoPath);
        if (!string.IsNullOrEmpty(pseudoDir)) Directory.CreateDirectory(pseudoDir);
        File.WriteAllText(pseudoPath, pseudoCode, new UTF8Encoding(false));
        Console.WriteLine($"Pseudo code 已寫入: {pseudoPath}");
    }

    if (emitMermaid)
    {
        var mermaidEmitter = new ProcedureToMermaidEmitter();
        var mermaid = mermaidEmitter.EmitProcedureDivision(ast.Procedure);
        var mermaidPath = (outputArg != null && !emitPseudo)
            ? outputArg
            : Path.Combine(inputDir, $"{baseName}_flowchart.mmd");
        var mermaidDir = Path.GetDirectoryName(mermaidPath);
        if (!string.IsNullOrEmpty(mermaidDir)) Directory.CreateDirectory(mermaidDir);
        File.WriteAllText(mermaidPath, mermaid, new UTF8Encoding(false));
        Console.WriteLine($"Mermaid flowchart 已寫入: {mermaidPath}");
    }

    return 0;
}

/// <summary>取得 ast 參數：優先命令列 args，其次環境變數，再來 App.config。</summary>
static string GetAstArg(string[] args, int index, string envKey, string configKey)
{
    var fromArgs = args.Length > index ? args[index]?.Trim() ?? "" : "";
    if (!string.IsNullOrEmpty(fromArgs) && !fromArgs.StartsWith("--"))
        return fromArgs;
    var fromEnv = Environment.GetEnvironmentVariable(envKey);
    if (!string.IsNullOrEmpty(fromEnv))
        return fromEnv.Trim();
    var fromConfig = ConfigurationManager.AppSettings?[configKey];
    return string.IsNullOrEmpty(fromConfig) ? "" : fromConfig.Trim();
}
