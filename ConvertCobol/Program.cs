/*
 * 更新時間：2026-02-11
 * 作者：AI Assistant
 * 摘要：產出 JSON 前呼叫 CobolAstVisitor.NormalizeAllProcedureStatements(ast.Procedure)，對整個 Procedure 套用續行誤併修正（WHEN 901/WHEN OTHER 截斷）
 *
 * 更新時間：2026-02-10 21:00
 * 作者：AI Assistant
 * 摘要：AST JSON 輸出命名重構：每次 ast 執行只產生完整 + data-only + proc-only 三個 JSON（*_ast.json / *_ast_data.json / *_ast_proc.json 或 {name}.json / {name}_data.json / {name}_proc.json），避免出現 *_ast_data_proc.json / *_ast_proc_proc.json 等遞迴後綴
 *
 * 更新時間：2026-02-10
 * 作者：AI Assistant
 * 摘要：Plan 2a 兩層展開 — procedure-only 子字串先經 ConvertTraditionalComments 註解正規化再解析，產出多個 Paragraph（Level 2）
 *
 * 更新時間：2026-02-10
 * 作者：AI Assistant
 * 摘要：Plan 2a 實作 — 全檔解析若 procedure 為空，改以 procedure-only 子字串解析並合併回 AST（paragraphCount/statementCount、ast.Procedure）
 *
 * 更新時間：2026-02-10 18:00
 * 作者：AI Assistant
 * 摘要：ast 命令支援第四參數為 .cs 路徑時，一併輸出 PROCEDURE DIVISION 轉成的 C# 程式碼（ProcedureToCSharpEmitter）
 *
 * 更新時間：2026-02-09 18:28
 * 作者：AI Assistant
 * 摘要：修復編碼檢測問題：DetectEncoding 函數現在會檢測 UTF-8（無 BOM）文件，因為 AcuListingCleaner 輸出的 .cbl 文件是 UTF-8 編碼但沒有 BOM。這確保中文字符（如 "細明體12"）能正確讀取，而不是被當作 Big5 導致字符損壞（顯示為 "細�?�?2"）
 *
 * 更新時間：2026-02-10 14:30
 * 作者：AI Assistant
 * 摘要：添加 parser 錯誤監聽器（LexerErrorListener、ParserErrorListener）以追蹤 SCREEN SECTION 解析錯誤
 *
 * 更新時間：2026-02-10 10:00
 * 作者：AI Assistant
 * 摘要：預設不註解 SCREEN SECTION；ast 參數可來自命令列 args、環境變數、App.config（優先順序 args > env > config）
 *
 * 更新時間：2026-02-09 14:30
 * 作者：AI Assistant
 * 摘要：ConvertTraditionalComments 增強：偵測孤立註解續行（前行註解以逗號結尾、當前行僅字串字面值時一併轉為註解）
 *
 * 更新時間：2026-02-09
 * 作者：AI Assistant
 * 摘要：新增 JSON 輸出與 read 指令（JsonAstReporter、AstJsonLoader）
 *
 * 更新時間：2026-02-06
 * 作者：AI Assistant
 * 摘要：Chinese token 修復：ConvertTraditionalComments、DetectEncoding、identificationFreeText
 *
 * 更新時間：2026-02-06
 * 作者：AI Assistant
 * 摘要：COBOL-to-AST 主程式，串接前處理 → ANTLR 解析 → AST 訪問 → Markdown 輸出
 */

using System.Configuration;
using System.Diagnostics;
using System.Text;
using System.Text.RegularExpressions;
using Antlr4.Runtime;
using ConvertCobol.Generated;
using ConvertCobol.Loaders;
using ConvertCobol.Preprocessing;
using ConvertCobol.CodeGen;
using ConvertCobol.Reporters;
using ConvertCobol.Visitors;
using ConvertCobol.Models;

// 註冊 CodePages 編碼（MS950/Big5）— 必須在任何 GetEncoding 之前
Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);

if (args.Length < 1)
{
    Console.WriteLine("用法:");
    Console.WriteLine("  ConvertCobol ast <input.lst|input.cbl> [output.md|output.json] [charset] [procedure.cs]");
    Console.WriteLine("  ConvertCobol read <input.json>");
    Console.WriteLine("  ast   - 產生 AST 報告（副檔名 .json 則輸出 JSON，否則 Markdown）");
    Console.WriteLine("  未指定時可由環境變數或 App.config 讀取：CONVERTCOBOL_AST_INPUT / CONVERTCOBOL_AST_OUTPUT / CONVERTCOBOL_AST_CHARSET");
    Console.WriteLine("  read  - 從 JSON 載入 AST 並顯示摘要");
    Console.WriteLine("  預設 charset: big5");
    return 1;
}

var command = args.Length >= 1 ? args[0].ToLowerInvariant() : "";

if (command == "read")
{
    return RunReadCommand(args);
}

if (command != "ast")
{
    Console.WriteLine("用法: ConvertCobol ast <input> [output] [charset] | read <input.json>");
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

var encoding = GetEncodingOrDefault(charsetName);
string cblPath = inputPath;
string sourceForReport = inputPath;

// 若輸入為 .lst，先清理轉為 .cbl（輸出至與輸入同層的 cbl 資料夾，或專案根 cbl/）
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

// 讀取 COBOL 原始碼（lst 清理後為 UTF-8，直接指定 .cbl 則用使用者 charset + BOM 偵測）
var readEncoding = inputPath.EndsWith(".lst", StringComparison.OrdinalIgnoreCase) ? Encoding.UTF8 : DetectEncoding(cblPath, encoding);
var cobolSource = File.ReadAllText(cblPath, readEncoding);

// 偵測是否含 SCREEN SECTION：註解標記（AcuListingCleaner 第 9 步）或原始碼中的 SCREEN SECTION（含多空白）
var hasScreenSection = (cobolSource.Contains("[SCREEN SECTION", StringComparison.OrdinalIgnoreCase)
        && cobolSource.Contains("ACUCOBOL GUI", StringComparison.OrdinalIgnoreCase))
    || Regex.IsMatch(cobolSource, @"SCREEN\s+SECTION", RegexOptions.IgnoreCase);

// 預處理：將傳統 * 註解行轉為 *> 格式（讓 COMMENTLINE 規則正確匹配）
cobolSource = ConvertTraditionalComments(cobolSource);

// ANTLR 解析
var sw = Stopwatch.StartNew();
var inputStream = new AntlrInputStream(cobolSource);
var lexer = new Cobol85AcuLexer(inputStream);
var tokenStream = new CommonTokenStream(lexer);
var parser = new Cobol85AcuParser(tokenStream);

// 添加錯誤監聽器以追蹤解析錯誤
var lexerErrorListener = new LexerErrorListener();
var parserErrorListener = new ParserErrorListener();
lexer.RemoveErrorListeners();
lexer.AddErrorListener(lexerErrorListener);
parser.RemoveErrorListeners();
parser.AddErrorListener(parserErrorListener);

// 使用 DefaultErrorStrategy 以容錯解析（ACUCOBOL 語法可能含部分不支援結構）
parser.ErrorHandler = new DefaultErrorStrategy();
var tree = parser.startRule();

sw.Stop();

// AST 訪問
var visitor = new CobolAstVisitor();
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
        var procedureSource = cobolSource.Substring(idx);
        // Plan 2a 兩層展開：註解正規化（含前導空白 + *）後再解析，避免遇 * 即停，以產出多個 Paragraph（Level 2）
        procedureSource = NormalizeProcedureComments(procedureSource);
        var procInput = new AntlrInputStream(procedureSource);
        var procLexer = new Cobol85AcuLexer(procInput);
        var procStream = new CommonTokenStream(procLexer);
        var procParser = new Cobol85AcuParser(procStream);
        procParser.ErrorHandler = new DefaultErrorStrategy();
        var procTree = procParser.procedureOnlyStart();
        var procVisitor = new CobolAstVisitor();
        // 注意：此處 parser 是以 procedureSource（子字串）建立，來源索引需對齊同一字串
        procVisitor.SetCobolSource(procedureSource);
        procVisitor.Visit(procTree);
        var procAst = procVisitor.Result;
        if (procAst.Procedure != null && (procAst.Procedure.Children?.Count ?? 0) > 0)
        {
            ast.Procedure = procAst.Procedure;
            ast.ParagraphCount = procAst.ParagraphCount;
            ast.StatementCount = procAst.StatementCount;
            Console.WriteLine($"[Plan 2a] PROCEDURE DIVISION 已由 procedure-only 解析補入，段落數: {ast.ParagraphCount}，語句數: {ast.StatementCount}");
        }
    }
}

// 續行誤併修正：對整個 Procedure 樹套用單一處理（含段落層級 statement），截斷被誤併的 WHEN 901 / WHEN OTHER
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
    // 原完整 AST（含 DATA + PROCEDURE）
    content = jsonReporter.Generate(ast, sourceForReport, sw.Elapsed);

    // 依使用者需求：額外輸出 data-only 與 procedure-only JSON
    // data-only：保留 Identification/Environment/Data，清空 Procedure 與 Paragraph/Statement 統計
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

    // procedure-only：僅保留 ProgramId 與 Procedure（以及相關統計），其他 Division 可視情況略去
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

    // Plan 2a：一組輸入只對應「完整 + data-only + proc-only」三個 JSON。
    // 命名規則：
    // 1) 若輸出檔名為 *_ast.json，則衍生 *_ast_data.json、*_ast_proc.json。
    // 2) 其他情況（例如 debug.json），則使用 {name}_data.json、{name}_proc.json。
    var jsonOutDir = Path.GetDirectoryName(outputPath) ?? ".";
    var fileName = Path.GetFileName(outputPath);

    string dataPath;
    string procPath;

    if (fileName.EndsWith("_ast.json", StringComparison.OrdinalIgnoreCase))
    {
        // 例：HRRCB1IF_ast.json → HRRCB1IF_ast_data.json / HRRCB1IF_ast_proc.json
        dataPath = Path.Combine(jsonOutDir, fileName.Replace("_ast.json", "_ast_data.json"));
        procPath = Path.Combine(jsonOutDir, fileName.Replace("_ast.json", "_ast_proc.json"));
    }
    else
    {
        // 例：debug.json → debug_data.json / debug_proc.json
        var nameNoExt = Path.GetFileNameWithoutExtension(fileName);
        var ext = Path.GetExtension(fileName);
        dataPath = Path.Combine(jsonOutDir, $"{nameNoExt}_data{ext}");
        procPath = Path.Combine(jsonOutDir, $"{nameNoExt}_proc{ext}");
    }

    var dataJson = jsonReporter.Generate(dataAst, sourceForReport, sw.Elapsed);
    var procJson = jsonReporter.Generate(procAst, sourceForReport, sw.Elapsed);

    File.WriteAllText(dataPath, dataJson, new UTF8Encoding(false));
    File.WriteAllText(procPath, procJson, new UTF8Encoding(false));
    Console.WriteLine($"DATA AST 已寫入: {dataPath}");
    Console.WriteLine($"PROCEDURE AST 已寫入: {procPath}");
}
else
{
    var mdReporter = new MarkdownAstReporter();
    content = mdReporter.Generate(ast, sourceForReport, sw.Elapsed);
}

// 若使用者指定的是目錄路徑（例如 "ast"），改為在該目錄下寫入預設檔名，避免 UnauthorizedAccessException
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

static Encoding GetEncodingOrDefault(string name)
{
    // 優先使用 code page 950（Big5），較 MS950 字串更可靠
    if (string.Equals(name, "MS950", StringComparison.OrdinalIgnoreCase) ||
        string.Equals(name, "big5", StringComparison.OrdinalIgnoreCase) ||
        string.Equals(name, "Big5", StringComparison.OrdinalIgnoreCase))
    {
        try { return Encoding.GetEncoding(950); } catch { }
        try { return Encoding.GetEncoding("big5"); } catch { }
        try { return Encoding.GetEncoding("MS950"); } catch { }
    }
    try
    {
        return Encoding.GetEncoding(name);
    }
    catch (ArgumentException ex)
    {
        Console.WriteLine($"警告：無法載入編碼 '{name}' ({ex.Message})，改用 UTF-8");
        return Encoding.UTF8;
    }
}

/// <summary>偵測檔案編碼，若為 UTF-8 BOM 則回傳 UTF-8，否則嘗試檢測 UTF-8（無 BOM），最後使用指定 fallback</summary>
static Encoding DetectEncoding(string path, Encoding fallback)
{
    var buf = new byte[Math.Min(4096, new FileInfo(path).Length)]; // 讀取前 4KB 或整個文件（如果更小）
    using (var fs = File.OpenRead(path))
    {
        var bytesRead = fs.Read(buf, 0, buf.Length);
        if (bytesRead < 3) return fallback;
        
        // 檢查 UTF-8 BOM
        if (buf[0] == 0xEF && buf[1] == 0xBB && buf[2] == 0xBF)
            return new UTF8Encoding(false);
        
        // 嘗試檢測 UTF-8（無 BOM）：檢查是否為有效的 UTF-8 序列
        // 如果文件主要由有效的 UTF-8 字符組成，很可能是 UTF-8
        try
        {
            var utf8 = new UTF8Encoding(false);
            var decoded = utf8.GetString(buf, 0, bytesRead);
            // 檢查是否包含有效的 UTF-8 字符（非替換字符）
            // 如果解碼後沒有太多替換字符（�），可能是 UTF-8
            var replacementCharCount = decoded.Count(c => c == '\uFFFD'); // Unicode 替換字符
            var validRatio = 1.0 - (double)replacementCharCount / decoded.Length;
            
            // 如果有效字符比例 > 95%，可能是 UTF-8
            if (validRatio > 0.95)
            {
                return utf8;
            }
        }
        catch
        {
            // 如果 UTF-8 解碼失敗，繼續使用 fallback
        }
    }
    return fallback;
}

/// <summary>Plan 2a：對 PROCEDURE DIVISION 子字串做註解正規化。任一列若 TrimStart 後以 * 開頭（非 *>），整列改為 *> 開頭，使 lexer 視為註解，避免 procedure-only 解析遇 * 即停。</summary>
static string NormalizeProcedureComments(string procedureSource)
{
    var lines = procedureSource.Split(new[] { "\r\n", "\r", "\n" }, StringSplitOptions.None);
    for (var i = 0; i < lines.Length; i++)
    {
        var trimmed = lines[i].TrimStart();
        if (trimmed.Length > 0 && trimmed[0] == '*' && !trimmed.StartsWith("*>", StringComparison.Ordinal))
            lines[i] = "*> " + trimmed[1..];
    }
    return string.Join(Environment.NewLine, lines);
}

/// <summary>將傳統 * 註解行轉為 *> 格式，讓 COMMENTLINE lexer 規則正確匹配並送到 HIDDEN channel；並偵測孤立註解續行（前行為註解續行、當前行僅字串字面值）一併轉為註解。</summary>
static string ConvertTraditionalComments(string source)
{
    var lines = source.Split(new[] { "\r\n", "\r", "\n" }, StringSplitOptions.None);
    var prevWasCommentContinuation = false;
    for (var i = 0; i < lines.Length; i++)
    {
        var line = lines[i];
        if (line.Length > 0 && line[0] == '*' && !line.StartsWith("*>", StringComparison.Ordinal))
        {
            lines[i] = "*> " + line[1..];
            prevWasCommentContinuation = line.TrimEnd().EndsWith(",", StringComparison.Ordinal);
        }
        else if (prevWasCommentContinuation)
        {
            var trimmed = line.TrimStart();
            if (trimmed.Length > 0 && (trimmed[0] == '"' || trimmed[0] == '\''))
            {
                lines[i] = "*> " + line;
                prevWasCommentContinuation = trimmed.TrimEnd().EndsWith(",", StringComparison.Ordinal);
            }
            else
            {
                prevWasCommentContinuation = false;
            }
        }
        else if (line.TrimStart().StartsWith("End of ", StringComparison.OrdinalIgnoreCase))
        {
            lines[i] = "*> " + line;
            prevWasCommentContinuation = false;
        }
        else if (i > 0)
        {
            var prev = lines[i - 1];
            if (prev.Length > 0 && (prev[0] == '*' || prev.StartsWith("*>", StringComparison.Ordinal)))
            {
                var trimmed = line.TrimStart();
                if (trimmed.StartsWith("USAGE IS ", StringComparison.OrdinalIgnoreCase) || trimmed.StartsWith("HANDLE OF ", StringComparison.OrdinalIgnoreCase))
                {
                    lines[i] = "*> " + line;
                }
            }
            prevWasCommentContinuation = false;
        }
        else
        {
            prevWasCommentContinuation = false;
        }
    }
    return string.Join(Environment.NewLine, lines);
}

/// <summary>Lexer 錯誤監聽器，用於追蹤詞法分析錯誤。</summary>
internal class LexerErrorListener : IAntlrErrorListener<int>
{
    public void SyntaxError(TextWriter output, IRecognizer recognizer, int offendingSymbol, int line, int charPositionInLine, string msg, RecognitionException e)
    {
        var isScreenSection = line >= 15880 && line <= 16200;
        var prefix = isScreenSection ? "[SCREEN LEXER ERROR]" : "[LEXER ERROR]";
        Console.Error.WriteLine($"{prefix} line {line}:{charPositionInLine} {msg}");
        if (e != null)
        {
            Console.Error.WriteLine($"{prefix}   exception={e.GetType().Name}: {e.Message}");
        }
    }
}

/// <summary>Parser 錯誤監聽器，用於追蹤語法分析錯誤並輸出詳細日誌。</summary>
internal class ParserErrorListener : IAntlrErrorListener<IToken>
{
    public void SyntaxError(TextWriter output, IRecognizer recognizer, IToken offendingSymbol, int line, int charPositionInLine, string msg, RecognitionException e)
    {
        // HRRCB1IF.cbl 的 SCREEN SECTION 大約在 15884-16150 行
        var isScreenSection = line >= 15880 && line <= 16200;
        var prefix = isScreenSection ? "[SCREEN ERROR]" : "[PARSER ERROR]";
        Console.Error.WriteLine($"{prefix} line {line}:{charPositionInLine} {msg}");
        Console.Error.WriteLine($"{prefix}   offendingSymbol=\"{offendingSymbol?.Text ?? "null"}\", type={offendingSymbol?.Type}");
        if (e != null)
        {
            Console.Error.WriteLine($"{prefix}   exception={e.GetType().Name}: {e.Message}");
        }
    }
}
