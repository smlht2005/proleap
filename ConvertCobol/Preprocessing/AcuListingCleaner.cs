/*
 * 更新時間：2026-02-11
 * 作者：AI Assistant
 * 摘要：StripSeqArea 改為只 strip 前 6 字元（seq area），保留第 7 字元 indicator；避免註解行（*）轉成 .cbl 時遺失 * 變成程式碼
 *
 * 更新時間：2026-02-10 10:15
 * 作者：AI Assistant
 * 摘要：SCREEN SECTION 內含 Frame/Procedure/Label 等 MixedCase 之列不再視為註解資料（不套用 hasNonCobolText 註解規則）
 *
 * 更新時間：2026-02-10 10:00
 * 作者：AI Assistant
 * 摘要：不再註解 SCREEN SECTION；.lst 中之螢幕項原樣保留於 .cbl，供 parser 解析
 *
 * 更新時間：2026-02-06
 * 作者：AI Assistant
 * 摘要：ACUCOBOL-GT 編譯器列表檔(.lst) 清理工具，移植自 Java 版
 *       將 .lst 轉換為純 COBOL 原始碼(.cbl)，以供 ANTLR 解析
 *
 * ACUCOBOL-GT 列表檔欄位格式：
 *   Pos 0-5: hex address 或 6 空白 (seq area)
 *   Pos 6:   indicator (* 註解, 空白 正常, - 續行)；strip 時只去掉 0-5，保留此欄
 *   Pos 7+:  code area (Area A/B)
 */

using System.Text;
using System.Text.RegularExpressions;

namespace ConvertCobol.Preprocessing;

public class AcuListingCleaner
{
    private const int SeqAreaLength = 6;
    private static readonly Regex PageHeaderPattern = new(@".*ACUCOBOL-GT.*Page:\s*\d+.*");
    private static readonly Regex CopyPattern = new(@"^\s(\s*COPY\s+.*)$");
    private static readonly Regex InlineCommentPattern = new(@"^\s\*>(.*)$");
    private static readonly Regex CopybookHeaderPattern = new(@"^\s[A-Za-z0-9_-]+\.[A-Za-z]{2,4}(\s.*|$)");
    private static readonly Regex CopybookTextPattern = new(
        @"^\s.*(Copyright|Last modified|generated from|DO NOT modify|This is a generated file|Users of ACUCOBOL|may freely include).*$",
        RegexOptions.IgnoreCase);
    private static readonly Regex LowercaseWordPattern = new(@"^\s.*\b[a-z]{4,}\b.*$");
    private static readonly Regex MixedCasePattern = new(@"^\s.*\b[A-Z][a-z]{3,}\b.*$");
    private const string ValidIndicators = " *-Dd/";

    public CleanResult Clean(string inputLstPath, string outputCblPath, Encoding encoding)
    {
        var inputLines = ReadLinesLenient(inputLstPath, encoding);
        var outputLines = new List<string>();

        int removedHeaders = 0, removedBlanks = 0, commentedCopys = 0;
        int commentedDollarDirectives = 0;
        int convertedInlineComments = 0, sanitizedComments = 0, statisticsLinesRemoved = 0;
        bool inStatistics = false, inDataDivision = false, inScreenSection = false;
        int blankAfterHeader = 0;

        foreach (var line in inputLines)
        {
            if (!inStatistics && line.Trim() == "STATISTICS")
            {
                inStatistics = true;
                statisticsLinesRemoved++;
                continue;
            }
            if (inStatistics) { statisticsLinesRemoved++; continue; }

            if (PageHeaderPattern.IsMatch(line))
            {
                removedHeaders++;
                blankAfterHeader = 2;
                continue;
            }

            if (blankAfterHeader > 0 && string.IsNullOrWhiteSpace(line))
            {
                blankAfterHeader--;
                removedBlanks++;
                continue;
            }
            blankAfterHeader = 0;

            var stripped = StripSeqArea(line);

            var copyMatch = CopyPattern.Match(stripped);
            if (copyMatch.Success)
            {
                outputLines.Add("*" + copyMatch.Groups[1].Value);
                commentedCopys++;
                continue;
            }

            if (stripped.Length >= 2 && stripped[0] == ' ' && stripped[1..].TrimStart().StartsWith('$'))
            {
                outputLines.Add("*" + stripped[1..]);
                commentedDollarDirectives++;
                continue;
            }

            var trimmedCode = stripped.Length > 1 ? stripped[1..].Trim() : "";

            if (trimmedCode.StartsWith("DATA") && trimmedCode.Contains("DIVISION"))
                inDataDivision = true;
            else if (trimmedCode.StartsWith("PROCEDURE") && trimmedCode.Contains("DIVISION"))
            {
                inDataDivision = false;
                inScreenSection = false;
            }
            else if (trimmedCode.StartsWith("SCREEN") && trimmedCode.Contains("SECTION"))
                inScreenSection = true;

            var hasNonCobolText = LowercaseWordPattern.IsMatch(stripped) || MixedCasePattern.IsMatch(stripped);
            var hasQuotes = stripped.Contains('"') || stripped.Contains('\'');
            var strUpper = stripped.ToUpperInvariant();
            var hasCobolDataSyntax = strUpper.Contains("PIC ") || strUpper.Contains("VALUE ") ||
                strUpper.Contains("SECTION") || strUpper.Contains("DIVISION");

            if (CopybookHeaderPattern.IsMatch(stripped) || CopybookTextPattern.IsMatch(stripped) ||
                (inDataDivision && !inScreenSection && hasNonCobolText && (!hasQuotes || !hasCobolDataSyntax)))
            {
                outputLines.Add("*" + (stripped.Length > 1 ? stripped[1..] : ""));
                sanitizedComments++;
                continue;
            }

            var inlineMatch = InlineCommentPattern.Match(stripped);
            if (inlineMatch.Success)
            {
                outputLines.Add("*" + inlineMatch.Groups[1].Value);
                convertedInlineComments++;
                continue;
            }

            if (stripped.Length >= 1 && stripped[0] == '*')
            {
                var sanitized = SanitizeCommentLine(stripped);
                if (sanitized != stripped) sanitizedComments++;
                outputLines.Add(sanitized);
                continue;
            }

            outputLines.Add(stripped);
        }

        var outDir = Path.GetDirectoryName(outputCblPath);
        if (!string.IsNullOrEmpty(outDir))
            Directory.CreateDirectory(outDir);
        File.WriteAllLines(outputCblPath, outputLines, new UTF8Encoding(false));

        return new CleanResult(
            inputLines.Count, outputLines.Count,
            removedHeaders, removedBlanks, commentedCopys,
            commentedDollarDirectives, 0,
            convertedInlineComments, sanitizedComments,
            statisticsLinesRemoved);
    }

    private static string StripSeqArea(string line)
    {
        if (line.Length <= SeqAreaLength)
            return string.IsNullOrWhiteSpace(line) ? "" : " " + line.Trim();

        var stripped = line[SeqAreaLength..];
        if (string.IsNullOrEmpty(stripped)) return "";

        if (ValidIndicators.IndexOf(stripped[0]) < 0)
            stripped = " " + stripped;
        return stripped;
    }

    private static string SanitizeCommentLine(string line)
    {
        if (line.Length <= 1) return line;
        var content = line[1..];
        content = Regex.Replace(content, @"\bCOPY\b", "C-PY");
        content = Regex.Replace(content, @"\bREPLACE\b", "REPL-CE");
        return line[0] + content;
    }

    private static List<string> ReadLinesLenient(string path, Encoding encoding)
    {
        var bytes = File.ReadAllBytes(path);
        var fallback = Encoding.GetEncoding(encoding.CodePage, new EncoderReplacementFallback("?"), new DecoderReplacementFallback("?"));
        var text = fallback.GetString(bytes);
        return text.Split(new[] { "\r\n", "\r", "\n" }, StringSplitOptions.None).ToList();
    }

    public record CleanResult(
        int TotalInputLines, int TotalOutputLines,
        int RemovedHeaders, int RemovedBlanks, int CommentedCopys,
        int CommentedDollarDirectives, int CommentedScreenLines,
        int ConvertedInlineComments, int SanitizedComments,
        int StatisticsLinesRemoved)
    {
        public override string ToString() =>
            $@"=== 清理結果 ===
輸入行數：{TotalInputLines}
輸出行數：{TotalOutputLines}
移除頁首：{RemovedHeaders}
移除空白行：{RemovedBlanks}
註解化 COPY：{CommentedCopys}
註解化 $ 指令：{CommentedDollarDirectives}
註解化 SCREEN SECTION：{CommentedScreenLines}
*> 轉傳統註解：{ConvertedInlineComments}
註解關鍵字清理：{SanitizedComments}
移除統計行：{StatisticsLinesRemoved}";
    }
}
