/*
 * 更新時間：2026-02-09
 * 作者：AI Assistant
 * 摘要：ProgramAst 訪問器介面，供從 JSON 載入的 AST 走訪使用
 */

using ConvertCobol.Models;

namespace ConvertCobol.Visitors;

/// <summary>走訪 ProgramAst 的 Visitor 介面，可套用於 COBOL 解析或 JSON 載入的 AST</summary>
public abstract class ProgramAstVisitor
{
    public virtual void Visit(ProgramAst ast)
    {
        if (ast.Identification != null) Visit(ast.Identification);
        if (ast.Environment != null) Visit(ast.Environment);
        if (ast.Data != null) Visit(ast.Data);
        if (ast.Procedure != null) Visit(ast.Procedure);
    }

    public virtual void Visit(DivisionNode node)
    {
        foreach (var child in node.Children)
        {
            switch (child)
            {
                case DivisionNode d: Visit(d); break;
                case DataItemNode di: Visit(di); break;
                case ParagraphNode p: Visit(p); break;
                case StatementNode s: Visit(s); break;
            }
        }
    }

    public virtual void Visit(DataItemNode node)
    {
        foreach (var child in node.Children)
            Visit(child);
    }

    public virtual void Visit(ParagraphNode node)
    {
        foreach (var stmt in node.Statements)
            Visit(stmt);
    }

    public virtual void Visit(StatementNode node) { }
}
