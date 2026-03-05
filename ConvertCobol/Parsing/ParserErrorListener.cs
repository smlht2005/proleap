using Antlr4.Runtime;
using Microsoft.Extensions.Logging;

namespace ConvertCobol.Parsing;

/// <summary>Parser 錯誤監聽器，用於追蹤語法分析錯誤並輸出詳細日誌。</summary>
internal class ParserErrorListener : IAntlrErrorListener<IToken>
{
    private readonly ILogger _logger;
    public ParserErrorListener(ILogger logger) { _logger = logger; }

    public void SyntaxError(TextWriter output, IRecognizer recognizer, IToken offendingSymbol, int line, int charPositionInLine, string msg, RecognitionException e)
    {
        _logger.LogError("[PARSER] line {Line}:{Pos} {Msg}", line, charPositionInLine, msg);
        _logger.LogError("[PARSER] offendingSymbol=\"{Symbol}\", type={Type}", offendingSymbol?.Text ?? "null", offendingSymbol?.Type);
        if (e != null)
        {
            _logger.LogError("[PARSER] exception={ExType}: {ExMsg}", e.GetType().Name, e.Message);
        }
    }
}
