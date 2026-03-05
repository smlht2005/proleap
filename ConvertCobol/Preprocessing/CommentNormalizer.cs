namespace ConvertCobol.Preprocessing;

/// <summary>將傳統 COBOL 註解格式轉換為 ANTLR 可辨識的 *> 格式。</summary>
public static class CommentNormalizer
{
    /// <summary>將傳統 * 註解行轉為 *> 格式，讓 COMMENTLINE lexer 規則正確匹配並送到 HIDDEN channel；並偵測孤立註解續行（前行為註解續行、當前行僅字串字面值）一併轉為註解。</summary>
    public static string ConvertTraditionalComments(string source)
    {
        var lines = source.Split(new[] { "\r\n", "\r", "\n" }, StringSplitOptions.None);
        var prevWasCommentContinuation = false;
        for (var i = 0; i < lines.Length; i++)
        {
            var line = lines[i];
            var trimmed = line.TrimStart();

            if (IsTraditionalComment(trimmed))
            {
                var leadingSpaces = line[..^trimmed.Length];
                lines[i] = leadingSpaces + "*> " + trimmed[1..];
                prevWasCommentContinuation = line.TrimEnd().EndsWith(",", StringComparison.Ordinal);
            }
            else if (prevWasCommentContinuation)
            {
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
            else if (trimmed.StartsWith("End of ", StringComparison.OrdinalIgnoreCase))
            {
                lines[i] = "*> " + line;
                prevWasCommentContinuation = false;
            }
            else if (i > 0)
            {
                var prevTrimmed = lines[i - 1].TrimStart();
                if (prevTrimmed.StartsWith("*>", StringComparison.Ordinal) || IsTraditionalComment(prevTrimmed))
                {
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

    /// <summary>判斷已 TrimStart 的行是否為傳統 * 註解（非 *> 格式）。</summary>
    private static bool IsTraditionalComment(string trimmedLine)
        => trimmedLine.Length > 0 && trimmedLine[0] == '*' && !trimmedLine.StartsWith("*>", StringComparison.Ordinal);

    /// <summary>對 PROCEDURE DIVISION 子字串做註解正規化。任一列若 TrimStart 後以 * 開頭（非 *>），整列改為 *> 開頭，使 lexer 視為註解，避免 procedure-only 解析遇 * 即停。</summary>
    public static string NormalizeProcedureComments(string procedureSource)
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
}
