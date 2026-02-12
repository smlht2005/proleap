/*
 * 更新時間：2026-02-10 18:00
 * 作者：AI Assistant
 * 摘要：將 PROCEDURE DIVISION AST 轉成 C# 程式碼；支援 MOVE/PERFORM/CALL/EVALUATE/IF 等結構化輸出
 */

using System.Text;
using System.Text.RegularExpressions;
using ConvertCobol.Models;

namespace ConvertCobol.CodeGen;

/// <summary>
/// 走訪 PROCEDURE DIVISION AST，將所有段落與語句轉成 C# 程式碼。
/// 可與 CobolAstVisitor 產出的 ProgramAst.Procedure 搭配使用。
/// </summary>
public class ProcedureToCSharpEmitter
{
    private readonly StringBuilder _sb = new();
    private string _indent = "";
    private const string IndentStep = "    ";

    /// <summary>將 COBOL 段落名轉成合法 C# 方法名（替換 '-' 為 '_'）。</summary>
    public static string ParagraphNameToCSharpMethod(string cobolName)
    {
        if (string.IsNullOrWhiteSpace(cobolName)) return "UnnamedParagraph";
        return cobolName.Trim().Replace("-", "_", StringComparison.Ordinal);
    }

    /// <summary>將 PROCEDURE DIVISION 根節點轉成 C# 類別內的一組方法。</summary>
    public string EmitProcedureDivision(DivisionNode? procedureDivision, string className = "GeneratedProcedure")
    {
        _sb.Clear();
        _indent = "";

        if (procedureDivision?.Children == null)
            return "// No procedure division";

        _sb.AppendLine("// Generated from COBOL PROCEDURE DIVISION");
        _sb.AppendLine($"// Class: {className}");
        _sb.AppendLine();

        foreach (var child in procedureDivision.Children)
        {
            if (child is ParagraphNode para)
                EmitParagraph(para);
        }

        return _sb.ToString();
    }

    private void EmitParagraph(ParagraphNode para)
    {
        var methodName = ParagraphNameToCSharpMethod(para.Name);
        _sb.AppendLine($"{_indent}private void {methodName}()");
        _sb.AppendLine($"{_indent}{{");
        PushIndent();
        foreach (var stmt in para.Statements)
            EmitStatement(stmt);
        PopIndent();
        _sb.AppendLine($"{_indent}}}");
        _sb.AppendLine();
    }

    private void EmitStatement(StatementNode stmt)
    {
        var type = stmt.StatementType ?? "OTHER";
        switch (type)
        {
            case "MOVE":
                EmitMove(stmt);
                break;
            case "PERFORM":
                EmitPerform(stmt);
                break;
            case "CALL":
                EmitCall(stmt);
                break;
            case "EVALUATE":
                EmitEvaluate(stmt);
                break;
            case "IF":
                EmitIf(stmt);
                break;
            case "DISPLAY":
            case "ACCEPT":
                _sb.AppendLine($"{_indent}// COBOL: {EscapeComment(stmt.Text)}");
                _sb.AppendLine($"{_indent}// TODO: {type} -> C# UI/IO");
                break;
            case "STOP":
            case "GOBACK":
                _sb.AppendLine($"{_indent}return;");
                break;
            case "OPEN":
            case "CLOSE":
            case "READ":
            case "WRITE":
            case "REWRITE":
            case "INITIALIZE":
            case "COMPUTE":
            case "STRING":
            case "CREATE":
            case "MODIFY":
            case "INQUIRE":
            case "DESTROY":
                _sb.AppendLine($"{_indent}// COBOL: {EscapeComment(stmt.Text)}");
                _sb.AppendLine($"{_indent}// TODO: {type} -> C# equivalent");
                break;
            default:
                _sb.AppendLine($"{_indent}// COBOL: {EscapeComment(stmt.Text)}");
                break;
        }
    }

    private void EmitMove(StatementNode stmt)
    {
        string? from = stmt.MoveFrom;
        string? to = stmt.MoveTo;
        if (string.IsNullOrEmpty(from) || string.IsNullOrEmpty(to))
            ParseMoveText(stmt.Text, out from, out to);

        if (string.IsNullOrEmpty(from)) from = "/* source */";
        if (string.IsNullOrEmpty(to)) to = "/* target */";

        var targets = to.Split(',', StringSplitOptions.TrimEntries);
        var fromCs = CobolIdentifierToCSharp(from);
        foreach (var t in targets)
        {
            if (string.IsNullOrWhiteSpace(t)) continue;
            _sb.AppendLine($"{_indent}{CobolIdentifierToCSharp(t)} = {fromCs};");
        }
    }

    private static void ParseMoveText(string? text, out string? from, out string? to)
    {
        from = null;
        to = null;
        if (string.IsNullOrWhiteSpace(text)) return;
        // MOVE x TO y   or  MOVE x TO a, b, c
        var m = Regex.Match(text, @"MOVE\s+(.+?)\s+TO\s+(.+)", RegexOptions.IgnoreCase | RegexOptions.Singleline);
        if (m.Success)
        {
            from = m.Groups[1].Value.Trim();
            to = m.Groups[2].Value.Trim();
        }
    }

    private void EmitPerform(StatementNode stmt)
    {
        string? target = stmt.PerformTarget;
        string? thru = stmt.PerformThru;
        if (string.IsNullOrEmpty(target))
            ParsePerformText(stmt.Text, out target, out thru);

        if (string.IsNullOrEmpty(target))
        {
            _sb.AppendLine($"{_indent}// COBOL PERFORM: {EscapeComment(stmt.Text)}");
            return;
        }

        var methodName = ParagraphNameToCSharpMethod(target);
        if (!string.IsNullOrWhiteSpace(thru))
        {
            var thruName = ParagraphNameToCSharpMethod(thru);
            _sb.AppendLine($"{_indent}// PERFORM {target} THRU {thru} -> call range (simplified: call start)");
            _sb.AppendLine($"{_indent}{methodName}();");
        }
        else
            _sb.AppendLine($"{_indent}{methodName}();");
    }

    private static void ParsePerformText(string? text, out string? target, out string? thru)
    {
        target = null;
        thru = null;
        if (string.IsNullOrWhiteSpace(text)) return;
        // PERFORM name   or  PERFORM name THRU name2
        var m = Regex.Match(text, @"PERFORM\s+(\S+)(?:\s+(?:THROUGH|THRU)\s+(\S+))?", RegexOptions.IgnoreCase);
        if (m.Success)
        {
            target = m.Groups[1].Value.Trim();
            if (m.Groups.Count > 2 && !string.IsNullOrWhiteSpace(m.Groups[2].Value))
                thru = m.Groups[2].Value.Trim();
        }
    }

    private void EmitCall(StatementNode stmt)
    {
        string? target = stmt.CallTarget;
        var args = stmt.CallArgs;
        if (string.IsNullOrEmpty(target) && (args == null || args.Count == 0))
            ParseCallText(stmt.Text, out target, out args);

        if (string.IsNullOrEmpty(target))
        {
            _sb.AppendLine($"{_indent}// COBOL CALL: {EscapeComment(stmt.Text)}");
            return;
        }

        var methodName = CobolIdentifierToCSharp(target.Trim('"'));
        var argsStr = args != null && args.Count > 0
            ? string.Join(", ", args.Select(CobolIdentifierToCSharp))
            : "";
        _sb.AppendLine($"{_indent}{methodName}({argsStr});");
    }

    private static void ParseCallText(string? text, out string? target, out List<string>? args)
    {
        target = null;
        args = null;
        if (string.IsNullOrWhiteSpace(text)) return;
        // CALL "name" USING a, b   or  CALL name USING a
        var m = Regex.Match(text, @"CALL\s+(""[^""]+""|\S+)(?:\s+USING\s+(.+))?", RegexOptions.IgnoreCase);
        if (m.Success)
        {
            target = m.Groups[1].Value.Trim().Trim('"');
            var usingPart = m.Groups.Count > 2 ? m.Groups[2].Value.Trim() : null;
            if (!string.IsNullOrWhiteSpace(usingPart))
                args = usingPart.Split(',', StringSplitOptions.TrimEntries).ToList();
        }
    }

    private void EmitEvaluate(StatementNode stmt)
    {
        _sb.AppendLine($"{_indent}// COBOL EVALUATE -> switch/if");
        _sb.AppendLine($"{_indent}// {EscapeComment(stmt.Text)}");
        _sb.AppendLine($"{_indent}// TODO: map WHEN ... to C# switch or if-else");
    }

    private void EmitIf(StatementNode stmt)
    {
        _sb.AppendLine($"{_indent}// COBOL IF -> if");
        _sb.AppendLine($"{_indent}// {EscapeComment(stmt.Text)}");
        _sb.AppendLine($"{_indent}// TODO: parse condition and then/else");
    }

    private static string CobolIdentifierToCSharp(string cobolId)
    {
        if (string.IsNullOrWhiteSpace(cobolId)) return cobolId;
        var s = cobolId.Trim().Replace("-", "_", StringComparison.Ordinal);
        return s;
    }

    private static string EscapeComment(string? text)
    {
        if (text == null) return "";
        return text.Replace("*/", "* /", StringComparison.Ordinal);
    }

    private void PushIndent() => _indent += IndentStep;
    private void PopIndent() => _indent = _indent.Length >= IndentStep.Length ? _indent[IndentStep.Length..] : "";
}
