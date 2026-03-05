/*
 * Procedure Division AST to Pseudo Code
 * Outputs structured, COBOL-like pseudo code preserving original identifiers/conditions
 */

using System.Text;
using ConvertCobol.Models;
using ConvertCobol.Models.Statements;

namespace ConvertCobol.CodeGen;

public class ProcedureToPseudoCodeEmitter
{
    private readonly StringBuilder _sb = new();
    private string _indent = "";
    private const string IndentStep = "    ";

    public string EmitProcedureDivision(DivisionNode? procedureDivision)
    {
        _sb.Clear();
        _indent = "";

        if (procedureDivision?.Children == null)
            return "// No procedure division";

        _sb.AppendLine("PROCEDURE DIVISION.");
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
        var label = para.IsSection ? "SECTION" : "PARAGRAPH";
        _sb.AppendLine($"{label}: {para.Name}");
        PushIndent();
        foreach (var stmt in para.Statements)
            EmitStatement(stmt);
        PopIndent();
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
            case DisplayStatement display:
                EmitDisplay(display);
                break;
            case AcceptStatement accept:
                EmitAccept(accept);
                break;
            case OpenStatement open:
                EmitOpen(open);
                break;
            case CloseStatement:
                Emit(stmt.Text ?? "CLOSE");
                break;
            case ReadStatement read:
                EmitRead(read);
                break;
            case WriteStatement:
                Emit(stmt.Text ?? "WRITE");
                break;
            case RewriteStatement:
                Emit(stmt.Text ?? "REWRITE");
                break;
            case StartStatement:
                Emit(stmt.Text ?? "START");
                break;
            case InitializeStatement init:
                EmitInitialize(init);
                break;
            case ComputeStatement:
                Emit(stmt.Text ?? "COMPUTE");
                break;
            case StringStatement:
                Emit(stmt.Text ?? "STRING");
                break;
            case InspectStatement:
                Emit(stmt.Text ?? "INSPECT");
                break;
            case SimpleStatement simple:
                EmitSimple(simple);
                break;
            default:
                Emit(stmt.Text ?? $"[{stmt.StatementType}]");
                break;
        }
    }

    private void EmitMove(MoveStatement move)
    {
        var from = move.MoveFrom ?? "?";
        var to = move.MoveTo ?? "?";
        Emit($"MOVE {from} TO {to}");
    }

    private void EmitPerform(PerformStatement perf)
    {
        if (perf.PerformInline)
        {
            EmitInlinePerform(perf);
            return;
        }

        var target = perf.PerformTarget ?? "?";
        var sb = new StringBuilder($"PERFORM {target}");

        if (!string.IsNullOrWhiteSpace(perf.PerformThru))
            sb.Append($" THRU {perf.PerformThru}");

        if (!string.IsNullOrWhiteSpace(perf.PerformType) && perf.PerformType != "SIMPLE")
        {
            if (perf.PerformType == "UNTIL" && !string.IsNullOrWhiteSpace(perf.PerformUntilCondition))
                sb.Append($" UNTIL {perf.PerformUntilCondition}");
            else
                sb.Append($" {perf.PerformType}");
        }

        Emit(sb.ToString());
    }

    private void EmitInlinePerform(PerformStatement perf)
    {
        if (perf.PerformType == "UNTIL" && !string.IsNullOrWhiteSpace(perf.PerformUntilCondition))
            Emit($"PERFORM UNTIL {perf.PerformUntilCondition}");
        else if (!string.IsNullOrWhiteSpace(perf.PerformType) && perf.PerformType != "SIMPLE")
            Emit($"PERFORM {perf.PerformType}");
        else
            Emit("PERFORM");

        PushIndent();
        if (perf.PerformStatements != null)
        {
            foreach (var s in perf.PerformStatements)
                EmitStatement(s);
        }
        PopIndent();
        Emit("END-PERFORM");
    }

    private void EmitCall(CallStatement call)
    {
        var target = call.CallTarget ?? "?";
        if (call.CallArgs != null && call.CallArgs.Count > 0)
            Emit($"CALL {target} USING {string.Join(", ", call.CallArgs)}");
        else
            Emit($"CALL {target}");
    }

    private void EmitEvaluate(EvaluateStatement eval)
    {
        var subject = eval.EvaluateSubject ?? "TRUE";
        Emit($"EVALUATE {subject}");
        PushIndent();

        if (eval.EvaluateWhenPhrases != null)
        {
            foreach (var clause in eval.EvaluateWhenPhrases)
            {
                if (clause.WhenConditions != null)
                {
                    foreach (var cond in clause.WhenConditions)
                        Emit($"WHEN {cond.Trim()}");
                }

                PushIndent();
                if (clause.Statements != null)
                {
                    foreach (var s in clause.Statements)
                        EmitStatement(s);
                }
                PopIndent();
            }
        }

        if (eval.EvaluateWhenOtherStatements != null && eval.EvaluateWhenOtherStatements.Count > 0)
        {
            Emit("WHEN OTHER");
            PushIndent();
            foreach (var s in eval.EvaluateWhenOtherStatements)
                EmitStatement(s);
            PopIndent();
        }

        PopIndent();
        Emit("END-EVALUATE");
    }

    private void EmitIf(IfStatement ifStmt)
    {
        var condition = ifStmt.IfCondition ?? "TRUE";
        Emit($"IF {condition}");
        PushIndent();

        if (ifStmt.ThenStatements != null && ifStmt.ThenStatements.Count > 0)
        {
            foreach (var s in ifStmt.ThenStatements)
                EmitStatement(s);
        }
        else if (!string.IsNullOrEmpty(ifStmt.IfThenText))
        {
            Emit(ifStmt.IfThenText);
        }

        PopIndent();

        if ((ifStmt.ElseStatements != null && ifStmt.ElseStatements.Count > 0) ||
            !string.IsNullOrEmpty(ifStmt.IfElseText))
        {
            Emit("ELSE");
            PushIndent();

            if (ifStmt.ElseStatements != null && ifStmt.ElseStatements.Count > 0)
            {
                foreach (var s in ifStmt.ElseStatements)
                    EmitStatement(s);
            }
            else if (!string.IsNullOrEmpty(ifStmt.IfElseText))
            {
                Emit(ifStmt.IfElseText);
            }

            PopIndent();
        }

        Emit("END-IF");
    }

    private void EmitDisplay(DisplayStatement display)
    {
        if (!string.IsNullOrEmpty(display.Text))
            Emit(display.Text);
        else
            Emit("DISPLAY ...");
    }

    private void EmitAccept(AcceptStatement accept)
    {
        if (!string.IsNullOrWhiteSpace(accept.AcceptFromEnvironment))
            Emit($"ACCEPT {accept.AcceptTarget ?? "?"} FROM ENVIRONMENT \"{accept.AcceptFromEnvironment}\"");
        else if (!string.IsNullOrWhiteSpace(accept.AcceptTarget))
            Emit($"ACCEPT {accept.AcceptTarget}");
        else
            Emit($"ACCEPT {accept.Text ?? "?"}");
    }

    private void EmitOpen(OpenStatement open)
    {
        var type = open.OpenType ?? "";
        var targets = open.OpenTargets != null ? string.Join(", ", open.OpenTargets) : "?";
        Emit($"OPEN {type} {targets}");
    }

    private void EmitRead(ReadStatement read)
    {
        var sb = new StringBuilder("READ ");
        sb.Append(read.ReadTarget ?? "?");
        if (read.ReadNext) sb.Append(" NEXT");
        if (!string.IsNullOrWhiteSpace(read.ReadInto)) sb.Append($" INTO {read.ReadInto}");
        if (!string.IsNullOrWhiteSpace(read.ReadKey)) sb.Append($" KEY IS {read.ReadKey}");
        Emit(sb.ToString());
    }

    private void EmitInitialize(InitializeStatement init)
    {
        if (init.InitializeTargets != null && init.InitializeTargets.Count > 0)
            Emit($"INITIALIZE {string.Join(", ", init.InitializeTargets)}");
        else
            Emit(init.Text ?? "INITIALIZE");
    }

    private void EmitSimple(SimpleStatement simple)
    {
        var type = simple.StatementType?.ToUpperInvariant() ?? "";
        switch (type)
        {
            case "STOP":
                Emit("STOP RUN");
                break;
            case "GOBACK":
                Emit("GOBACK");
                break;
            case "EXIT":
                Emit(simple.Text ?? "EXIT");
                break;
            case "CONTINUE":
                Emit("CONTINUE");
                break;
            default:
                Emit(simple.Text ?? $"[{type}]");
                break;
        }
    }

    private void Emit(string text) => _sb.AppendLine($"{_indent}{text}");
    private void PushIndent() => _indent += IndentStep;
    private void PopIndent() => _indent = _indent.Length >= IndentStep.Length ? _indent[IndentStep.Length..] : "";
}
