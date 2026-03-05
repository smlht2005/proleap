using Antlr4.Runtime;
using Microsoft.Extensions.Logging;

namespace ConvertCobol.Parsing;

/// <summary>Lexer 錯誤監聽器，用於追蹤詞法分析錯誤。</summary>
internal class LexerErrorListener : IAntlrErrorListener<int>
{
    private readonly ILogger _logger;
    public LexerErrorListener(ILogger logger) { _logger = logger; }

    public void SyntaxError(TextWriter output, IRecognizer recognizer, int offendingSymbol, int line, int charPositionInLine, string msg, RecognitionException e)
    {
        _logger.LogError("[LEXER] line {Line}:{Pos} {Msg}", line, charPositionInLine, msg);
        if (e != null)
        {
            _logger.LogError("[LEXER] exception={ExType}: {ExMsg}", e.GetType().Name, e.Message);
        }
    }
}
