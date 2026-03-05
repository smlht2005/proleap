/*
 * 將 PROCEDURE DIVISION AST 轉成 C# 程式碼
 * 支援 MOVE/PERFORM/CALL/EVALUATE/IF 等結構化輸出
 */

using System.Text;
using System.Text.RegularExpressions;
using ConvertCobol.Models;
using ConvertCobol.Models.Statements;

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
        switch (stmt)
        {
            case MoveStatement move:
                EmitMove(move);
                break;
            case PerformStatement perf:
                EmitPerform(perf);
                break;
            case CallStatement call:
                EmitCall(call);
                break;
            case EvaluateStatement eval:
                EmitEvaluate(eval);
                break;
            case IfStatement ifStmt:
                EmitIf(ifStmt);
                break;
            case DisplayStatement:
            case AcceptStatement:
                _sb.AppendLine($"{_indent}// COBOL: {EscapeComment(stmt.Text)}");
                _sb.AppendLine($"{_indent}// TODO: {stmt.StatementType} -> C# UI/IO");
                break;
            case OpenStatement:
            case CloseStatement:
            case ReadStatement:
            case WriteStatement:
            case RewriteStatement:
            case StartStatement:
            case InitializeStatement:
            case ComputeStatement:
            case StringStatement:
            case InspectStatement:
                _sb.AppendLine($"{_indent}// COBOL: {EscapeComment(stmt.Text)}");
                _sb.AppendLine($"{_indent}// TODO: {stmt.StatementType} -> C# equivalent");
                break;
            case SimpleStatement when stmt.StatementType is "STOP" or "GOBACK":
                _sb.AppendLine($"{_indent}return;");
                break;
            default:
                _sb.AppendLine($"{_indent}// COBOL: {EscapeComment(stmt.Text)}");
                break;
        }
    }

    private void EmitMove(MoveStatement move)
    {
        string? from = move.MoveFrom;
        string? to = move.MoveTo;

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

    private void EmitPerform(PerformStatement perf)
    {
        if (perf.PerformInline)
        {
            EmitInlinePerform(perf);
            return;
        }

        string? target = perf.PerformTarget;
        string? thru = perf.PerformThru;

        if (string.IsNullOrEmpty(target))
        {
            _sb.AppendLine($"{_indent}// COBOL PERFORM: {EscapeComment(perf.Text)}");
            return;
        }

        var methodName = ParagraphNameToCSharpMethod(target);
        if (!string.IsNullOrWhiteSpace(thru))
        {
            var thruName = ParagraphNameToCSharpMethod(thru);
            _sb.AppendLine($"{_indent}// PERFORM {target} THRU {thru}");
            _sb.AppendLine($"{_indent}{methodName}(); // through {thruName}()");
        }
        else
            _sb.AppendLine($"{_indent}{methodName}();");
    }

    private void EmitInlinePerform(PerformStatement perf)
    {
        if (perf.PerformType == "UNTIL")
        {
            var condition = TranslateCondition(perf.PerformUntilCondition);
            _sb.AppendLine($"{_indent}while (!({condition}))");
        }
        else if (perf.PerformType == "VARYING")
        {
            _sb.AppendLine($"{_indent}// PERFORM VARYING (simplified to while-loop)");
            _sb.AppendLine($"{_indent}while (true) // TODO: translate VARYING bounds");
        }
        else if (perf.PerformType == "TIMES")
        {
            _sb.AppendLine($"{_indent}// PERFORM ... TIMES");
            _sb.AppendLine($"{_indent}for (int i = 0; i < /* times */; i++)");
        }
        else
        {
            _sb.AppendLine($"{_indent}// PERFORM inline");
        }

        _sb.AppendLine($"{_indent}{{");
        PushIndent();
        if (perf.PerformStatements != null)
        {
            foreach (var s in perf.PerformStatements)
                EmitStatement(s);
        }
        PopIndent();
        _sb.AppendLine($"{_indent}}}");
    }

    private void EmitCall(CallStatement call)
    {
        string? target = call.CallTarget;
        var args = call.CallArgs;

        if (string.IsNullOrEmpty(target))
        {
            _sb.AppendLine($"{_indent}// COBOL CALL: {EscapeComment(call.Text)}");
            return;
        }

        var methodName = CobolIdentifierToCSharp(target.Trim('"'));
        var argsStr = args != null && args.Count > 0
            ? string.Join(", ", args.Select(CobolIdentifierToCSharp))
            : "";
        _sb.AppendLine($"{_indent}{methodName}({argsStr});");
    }

    private void EmitEvaluate(EvaluateStatement eval)
    {
        var subject = eval.EvaluateSubject?.Trim();
        var isTrueEval = string.IsNullOrEmpty(subject)
                         || string.Equals(subject, "TRUE", StringComparison.OrdinalIgnoreCase);

        if (isTrueEval)
        {
            EmitEvaluateTrueAsIfElse(eval);
        }
        else
        {
            EmitEvaluateAsSwitch(eval, subject!);
        }
    }

    private void EmitEvaluateAsSwitch(EvaluateStatement eval, string subject)
    {
        var subjectCs = CobolIdentifierToCSharp(subject);
        _sb.AppendLine($"{_indent}switch ({subjectCs})");
        _sb.AppendLine($"{_indent}{{");
        PushIndent();

        if (eval.EvaluateWhenPhrases != null)
        {
            foreach (var clause in eval.EvaluateWhenPhrases)
            {
                if (clause.WhenConditions != null)
                {
                    foreach (var cond in clause.WhenConditions)
                    {
                        var trimmed = cond.Trim();
                        _sb.AppendLine($"{_indent}case {TranslateWhenCondition(trimmed)}:");
                    }
                }
                PushIndent();
                if (clause.Statements != null)
                {
                    foreach (var s in clause.Statements)
                        EmitStatement(s);
                }
                _sb.AppendLine($"{_indent}break;");
                PopIndent();
            }
        }

        if (eval.EvaluateWhenOtherStatements != null && eval.EvaluateWhenOtherStatements.Count > 0)
        {
            _sb.AppendLine($"{_indent}default:");
            PushIndent();
            foreach (var s in eval.EvaluateWhenOtherStatements)
                EmitStatement(s);
            _sb.AppendLine($"{_indent}break;");
            PopIndent();
        }

        PopIndent();
        _sb.AppendLine($"{_indent}}}");
    }

    private void EmitEvaluateTrueAsIfElse(EvaluateStatement eval)
    {
        if (eval.EvaluateWhenPhrases == null || eval.EvaluateWhenPhrases.Count == 0)
        {
            _sb.AppendLine($"{_indent}// EVALUATE TRUE (empty)");
            return;
        }

        var first = true;
        foreach (var clause in eval.EvaluateWhenPhrases)
        {
            var conditions = clause.WhenConditions?
                .Select(c => c.Trim())
                .Where(c => !string.IsNullOrEmpty(c))
                .ToList() ?? new List<string>();

            var condStr = conditions.Count > 0
                ? string.Join(" || ", conditions.Select(TranslateCondition))
                : "true";

            _sb.AppendLine(first
                ? $"{_indent}if ({condStr})"
                : $"{_indent}else if ({condStr})");
            _sb.AppendLine($"{_indent}{{");
            PushIndent();
            if (clause.Statements != null)
            {
                foreach (var s in clause.Statements)
                    EmitStatement(s);
            }
            PopIndent();
            _sb.AppendLine($"{_indent}}}");
            first = false;
        }

        if (eval.EvaluateWhenOtherStatements != null && eval.EvaluateWhenOtherStatements.Count > 0)
        {
            _sb.AppendLine($"{_indent}else");
            _sb.AppendLine($"{_indent}{{");
            PushIndent();
            foreach (var s in eval.EvaluateWhenOtherStatements)
                EmitStatement(s);
            PopIndent();
            _sb.AppendLine($"{_indent}}}");
        }
    }

    private void EmitIf(IfStatement ifStmt)
    {
        var condition = TranslateCondition(ifStmt.IfCondition);
        _sb.AppendLine($"{_indent}if ({condition})");
        _sb.AppendLine($"{_indent}{{");
        PushIndent();

        if (ifStmt.ThenStatements != null && ifStmt.ThenStatements.Count > 0)
        {
            foreach (var s in ifStmt.ThenStatements)
                EmitStatement(s);
        }
        else if (!string.IsNullOrEmpty(ifStmt.IfThenText))
        {
            _sb.AppendLine($"{_indent}// THEN: {EscapeComment(ifStmt.IfThenText)}");
        }

        PopIndent();
        _sb.AppendLine($"{_indent}}}");

        if ((ifStmt.ElseStatements != null && ifStmt.ElseStatements.Count > 0) ||
            !string.IsNullOrEmpty(ifStmt.IfElseText))
        {
            _sb.AppendLine($"{_indent}else");
            _sb.AppendLine($"{_indent}{{");
            PushIndent();

            if (ifStmt.ElseStatements != null && ifStmt.ElseStatements.Count > 0)
            {
                foreach (var s in ifStmt.ElseStatements)
                    EmitStatement(s);
            }
            else if (!string.IsNullOrEmpty(ifStmt.IfElseText))
            {
                _sb.AppendLine($"{_indent}// ELSE: {EscapeComment(ifStmt.IfElseText)}");
            }

            PopIndent();
            _sb.AppendLine($"{_indent}}}");
        }
    }

    /// <summary>基本 COBOL 條件 → C# 條件轉換。</summary>
    internal static string TranslateCondition(string? cobolCondition)
    {
        if (string.IsNullOrWhiteSpace(cobolCondition))
            return "true /* TODO: condition */";

        var c = cobolCondition.Trim();

        // Compound comparisons (must come before simple EQUAL/GREATER/LESS replacements)
        // GREATER THAN OR EQUAL TO → >=
        c = Regex.Replace(c, @"\bGREATER\s+THAN\s+OR\s+EQUAL(\s+TO)?\b", ">=", RegexOptions.IgnoreCase);
        // LESS THAN OR EQUAL TO → <=
        c = Regex.Replace(c, @"\bLESS\s+THAN\s+OR\s+EQUAL(\s+TO)?\b", "<=", RegexOptions.IgnoreCase);
        // NOT LESS THAN → >=
        c = Regex.Replace(c, @"\bNOT\s+LESS\s+THAN\b", ">=", RegexOptions.IgnoreCase);
        // NOT GREATER THAN → <=
        c = Regex.Replace(c, @"\bNOT\s+GREATER\s+THAN\b", "<=", RegexOptions.IgnoreCase);

        // NOT EQUAL → !=  (must come before EQUAL replacements)
        c = Regex.Replace(c, @"\bNOT\s+EQUAL\s+TO\b", "!=", RegexOptions.IgnoreCase);
        c = Regex.Replace(c, @"\bNOT\s+EQUAL\b", "!=", RegexOptions.IgnoreCase);

        // EQUAL TO / EQUALS / EQUAL → ==
        c = Regex.Replace(c, @"\bEQUAL\s+TO\b", "==", RegexOptions.IgnoreCase);
        c = Regex.Replace(c, @"\bEQUALS\b", "==", RegexOptions.IgnoreCase);
        c = Regex.Replace(c, @"\bEQUAL\b", "==", RegexOptions.IgnoreCase);

        // GREATER THAN → >
        c = Regex.Replace(c, @"\bGREATER\s+THAN\b", ">", RegexOptions.IgnoreCase);

        // LESS THAN → <
        c = Regex.Replace(c, @"\bLESS\s+THAN\b", "<", RegexOptions.IgnoreCase);

        // NOT = → !=
        c = Regex.Replace(c, @"\bNOT\s*=\s*", "!= ", RegexOptions.IgnoreCase);

        // AND / OR / NOT
        c = Regex.Replace(c, @"\bAND\b", "&&", RegexOptions.IgnoreCase);
        c = Regex.Replace(c, @"\bOR\b", "||", RegexOptions.IgnoreCase);
        c = Regex.Replace(c, @"\bNOT\b", "!", RegexOptions.IgnoreCase);

        // SPACES / SPACE → " "
        c = Regex.Replace(c, @"\bSPACES?\b", "\" \"", RegexOptions.IgnoreCase);

        // ZEROS / ZEROES / ZERO → 0
        c = Regex.Replace(c, @"\bZERO(E?S)?\b", "0", RegexOptions.IgnoreCase);

        // Replace COBOL identifiers (with hyphens) to C# identifiers (underscores)
        c = Regex.Replace(c, @"\b([A-Za-z][A-Za-z0-9]*(?:-[A-Za-z0-9]+)+)\b", m =>
            m.Value.Replace("-", "_"));

        return c;
    }

    /// <summary>將 WHEN 條件值轉為 C# case 表達式。</summary>
    private static string TranslateWhenCondition(string whenCondition)
    {
        if (string.IsNullOrWhiteSpace(whenCondition))
            return "/* unknown */";

        var trimmed = whenCondition.Trim();

        // 數字常數
        if (int.TryParse(trimmed, out _) || decimal.TryParse(trimmed, out _))
            return trimmed;

        // 字串常字值
        if ((trimmed.StartsWith("\"") && trimmed.EndsWith("\"")) ||
            (trimmed.StartsWith("'") && trimmed.EndsWith("'")))
            return trimmed;

        // Figurative constants
        if (string.Equals(trimmed, "ZERO", StringComparison.OrdinalIgnoreCase) ||
            string.Equals(trimmed, "ZEROS", StringComparison.OrdinalIgnoreCase) ||
            string.Equals(trimmed, "ZEROES", StringComparison.OrdinalIgnoreCase))
            return "0";

        if (string.Equals(trimmed, "SPACE", StringComparison.OrdinalIgnoreCase) ||
            string.Equals(trimmed, "SPACES", StringComparison.OrdinalIgnoreCase))
            return "\" \"";

        return CobolIdentifierToCSharp(trimmed);
    }

    private static string CobolIdentifierToCSharp(string cobolId)
    {
        if (string.IsNullOrWhiteSpace(cobolId)) return cobolId;
        return cobolId.Trim().Replace("-", "_", StringComparison.Ordinal);
    }

    private static string EscapeComment(string? text)
    {
        if (text == null) return "";
        return text.Replace("*/", "* /", StringComparison.Ordinal);
    }

    private void PushIndent() => _indent += IndentStep;
    private void PopIndent() => _indent = _indent.Length >= IndentStep.Length ? _indent[IndentStep.Length..] : "";
}
