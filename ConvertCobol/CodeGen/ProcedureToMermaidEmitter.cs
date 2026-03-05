/*
 * Procedure Division AST to Mermaid call graph
 * Generates a flowchart TD showing paragraph-to-paragraph PERFORM relationships
 */

using System.Text;
using ConvertCobol.Models;
using ConvertCobol.Models.Statements;

namespace ConvertCobol.CodeGen;

public class ProcedureToMermaidEmitter
{
    public string EmitProcedureDivision(DivisionNode? procedureDivision)
    {
        if (procedureDivision?.Children == null)
            return "flowchart TD\n    NoData[No procedure division]";

        var paragraphs = procedureDivision.Children.OfType<ParagraphNode>().ToList();
        var edges = new List<(string From, string To)>();
        var allNames = new HashSet<string>(StringComparer.OrdinalIgnoreCase);

        foreach (var para in paragraphs)
        {
            allNames.Add(para.Name);
            var targets = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
            CollectPerformTargets(para.Statements, targets);
            foreach (var target in targets)
                edges.Add((para.Name, target));
        }

        var sb = new StringBuilder();
        sb.AppendLine("flowchart TD");

        // Define nodes with display labels (IDs use underscores, labels keep hyphens)
        foreach (var name in allNames)
        {
            var id = SanitizeId(name);
            sb.AppendLine($"    {id}[\"{name}\"]");
        }

        sb.AppendLine();

        // Emit edges
        var emittedEdges = new HashSet<string>();
        foreach (var (from, to) in edges)
        {
            var fromId = SanitizeId(from);
            var toId = SanitizeId(to);
            var edgeKey = $"{fromId}-->{toId}";
            if (emittedEdges.Add(edgeKey))
                sb.AppendLine($"    {fromId} --> {toId}");
        }

        return sb.ToString();
    }

    private static void CollectPerformTargets(List<StatementNode>? statements, HashSet<string> targets)
    {
        if (statements == null) return;

        foreach (var stmt in statements)
        {
            switch (stmt)
            {
                case PerformStatement perf:
                    if (!perf.PerformInline && !string.IsNullOrWhiteSpace(perf.PerformTarget))
                        targets.Add(perf.PerformTarget.Trim());
                    // Also recurse into inline PERFORM body
                    CollectPerformTargets(perf.PerformStatements, targets);
                    break;
                case IfStatement ifStmt:
                    CollectPerformTargets(ifStmt.ThenStatements, targets);
                    CollectPerformTargets(ifStmt.ElseStatements, targets);
                    break;
                case EvaluateStatement eval:
                    if (eval.EvaluateWhenPhrases != null)
                    {
                        foreach (var clause in eval.EvaluateWhenPhrases)
                            CollectPerformTargets(clause.Statements, targets);
                    }
                    CollectPerformTargets(eval.EvaluateWhenOtherStatements, targets);
                    break;
            }
        }
    }

    private static string SanitizeId(string name)
    {
        // Mermaid node IDs cannot contain hyphens or special chars
        return name.Replace("-", "_").Replace(" ", "_");
    }
}
