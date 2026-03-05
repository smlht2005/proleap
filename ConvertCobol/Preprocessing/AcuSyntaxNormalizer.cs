using System.Text.RegularExpressions;

namespace ConvertCobol.Preprocessing;

/// <summary>
/// ACUCOBOL-GT 方言語法正規化。
/// 在送入 ANTLR parser 之前，移除或轉換標準 COBOL-85 文法不支援的 ACUCOBOL 擴充語法。
/// </summary>
public static partial class AcuSyntaxNormalizer
{
    /// <summary>移除 MOVE ... WITH CONVERT 中的 WITH CONVERT 後綴。</summary>
    /// <remarks>
    /// ACUCOBOL-GT 的 WITH CONVERT 語意等同標準 MOVE，僅提示 runtime 進行自動型別轉換。
    /// 標準 COBOL-85 文法的 moveStatement 不接受此後綴。
    /// </remarks>
    public static string RemoveWithConvert(string source)
        => WithConvertPattern().Replace(source, "");

    /// <summary>
    /// 將 ACUCOBOL-GT GUI DISPLAY 多行語句替換為 CONTINUE，
    /// 涵蓋 DISPLAY [Floating] [GRAPHICAL] WINDOW 和 DISPLAY STATUS-BAR。
    /// </summary>
    /// <remarks>
    /// 這些 ACUCOBOL-GT GUI 控制語法跨多行，以句點結束，包含 LINES/SIZE/CELL/COLOR/FONT/HANDLE 等屬性。
    /// 標準 COBOL-85 文法不支援，替換為 CONTINUE. 保持語句結構完整。
    /// </remarks>
    public static string NeutralizeDisplayGui(string source)
    {
        var lines = source.Split(new[] { "\r\n", "\r", "\n" }, StringSplitOptions.None);
        var result = new List<string>(lines.Length);
        var inBlock = false;

        for (var i = 0; i < lines.Length; i++)
        {
            var trimmed = lines[i].TrimStart();

            if (!inBlock)
            {
                // Detect: DISPLAY [Floating] [GRAPHICAL] WINDOW ...
                //     or: DISPLAY STATUS-BAR ...
                if (DisplayGuiStartPattern().IsMatch(trimmed))
                {
                    inBlock = true;
                    result.Add("           CONTINUE.");
                    if (trimmed.TrimEnd().EndsWith('.'))
                        inBlock = false;
                    else if (DisplayGuiHandlePattern().IsMatch(trimmed))
                        inBlock = false; // HANDLE IS on the same line as DISPLAY
                }
                else
                {
                    result.Add(lines[i]);
                }
            }
            else
            {
                // Inside GUI DISPLAY block — skip continuation lines.
                // Stop when: (a) line ends with period, or
                //            (b) line contains HANDLE IS (the last GUI property).
                if (trimmed.TrimEnd().EndsWith('.'))
                    inBlock = false;
                else if (DisplayGuiHandlePattern().IsMatch(trimmed))
                    inBlock = false;
            }
        }

        return string.Join(Environment.NewLine, result);
    }

    /// <summary>
    /// 在 SCREEN SECTION 內將 EXCEPTION PROCEDURE / EVENT PROCEDURE 替換為
    /// EXCEPTION-PROCEDURE / EVENT-PROCEDURE，防止 PROCEDURE token 與
    /// PROCEDURE DIVISION 衝突導致 parser 跳出 screen section。
    /// </summary>
    public static string NormalizeScreenProcedureKeywords(string source)
    {
        var lines = source.Split(new[] { "\r\n", "\r", "\n" }, StringSplitOptions.None);
        var inScreenSection = false;

        for (var i = 0; i < lines.Length; i++)
        {
            var trimmed = lines[i].TrimStart();
            if (ScreenSectionStartPattern().IsMatch(trimmed))
                inScreenSection = true;
            else if (inScreenSection && ProcedureDivisionStartPattern().IsMatch(trimmed))
                break;

            if (inScreenSection)
                lines[i] = ScreenProcedureKeywordPattern().Replace(lines[i],
                    m => m.Groups[1].Value + "-PROCEDURE");
        }

        return string.Join(Environment.NewLine, lines);
    }

    /// <summary>對整份來源檔套用所有 ACUCOBOL 語法正規化。</summary>
    public static string NormalizeAll(string source)
    {
        source = RemoveWithConvert(source);
        source = NeutralizeDisplayGui(source);
        source = NormalizeScreenProcedureKeywords(source);
        return source;
    }

    [GeneratedRegex(@"\bWITH\s+CONVERT\b", RegexOptions.IgnoreCase)]
    private static partial Regex WithConvertPattern();

    [GeneratedRegex(@"^\s*DISPLAY\s+(?:(?:Floating\s+)?(?:GRAPHICAL\s+)?WINDOW|STATUS-BAR)\b", RegexOptions.IgnoreCase)]
    private static partial Regex DisplayGuiStartPattern();

    [GeneratedRegex(@"\bHANDLE\s+IS\s+\S+", RegexOptions.IgnoreCase)]
    private static partial Regex DisplayGuiHandlePattern();

    [GeneratedRegex(@"^\s*SCREEN\s+SECTION\b", RegexOptions.IgnoreCase)]
    private static partial Regex ScreenSectionStartPattern();

    [GeneratedRegex(@"^\s*PROCEDURE\s+DIVISION\b", RegexOptions.IgnoreCase)]
    private static partial Regex ProcedureDivisionStartPattern();

    [GeneratedRegex(@"\b(EXCEPTION|EVENT)\s+PROCEDURE\b", RegexOptions.IgnoreCase)]
    private static partial Regex ScreenProcedureKeywordPattern();
}
