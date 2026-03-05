using ConvertCobol.Models;
using ConvertCobol.Models.Statements;
using ConvertCobol.Reporters;

namespace ConvertCobol.Tests;

public class MarkdownReporterTests
{
    private readonly MarkdownAstReporter _reporter = new();

    private static ProgramAst MakeAst() => new()
    {
        ProgramId = "TEST-PROG",
        FdCount = 2,
        DataItem01Count = 3,
        DataItem77Count = 1,
        TotalDataItems = 10,
        SectionCount = 2,
        ParagraphCount = 5,
        StatementCount = 20,
        HasScreenSection = true
    };

    // ── Title ────────────────────────────────────────────────────

    [Fact]
    public void Generate_ContainsTitle_WithProgramId()
    {
        var md = _reporter.Generate(MakeAst(), "test.cbl", TimeSpan.Zero);
        Assert.Contains("# COBOL AST Report: TEST-PROG", md);
    }

    // ── Meta ─────────────────────────────────────────────────────

    [Fact]
    public void Generate_ContainsMeta_ParserAndTimestamp()
    {
        var md = _reporter.Generate(MakeAst(), "test.cbl", TimeSpan.FromMilliseconds(42));
        Assert.Contains("ANTLR4 Cobol85Acu (C#)", md);
        Assert.Contains("test.cbl", md);
        Assert.Contains("42 ms", md);
    }

    // ── Overview table ───────────────────────────────────────────

    [Fact]
    public void Generate_OverviewTable_AllCounters()
    {
        var md = _reporter.Generate(MakeAst(), "test.cbl", TimeSpan.Zero);

        Assert.Contains("| PROGRAM-ID | TEST-PROG |", md);
        Assert.Contains("| FD 項目 | 2 |", md);
        Assert.Contains("| 01-Level 資料項目 | 3 |", md);
        Assert.Contains("| 77-Level 資料項目 | 1 |", md);
        Assert.Contains("| 全部資料項目 | 10 |", md);
        Assert.Contains("| Sections | 2 |", md);
        Assert.Contains("| Paragraphs | 5 |", md);
        Assert.Contains("| 語句總數 | 20 |", md);
        Assert.Contains("| 含 SCREEN SECTION（已註解） | 是 |", md);
    }

    // ── Identification section ───────────────────────────────────

    [Fact]
    public void Generate_IdentificationDivision_ShowsProgramId()
    {
        var md = _reporter.Generate(MakeAst(), "test.cbl", TimeSpan.Zero);
        Assert.Contains("## IDENTIFICATION DIVISION", md);
        Assert.Contains("**PROGRAM-ID**: `TEST-PROG`", md);
    }

    // ── Procedure paragraphs ─────────────────────────────────────

    [Fact]
    public void Generate_ProcedureDivision_ParagraphHeaders()
    {
        var ast = MakeAst();
        ast.Procedure = new DivisionNode
        {
            DivisionName = "PROC",
            Children =
            [
                new ParagraphNode { Name = "MAIN-LOGIC", IsSection = true },
                new ParagraphNode { Name = "SUB-PARA", IsSection = false }
            ]
        };
        var md = _reporter.Generate(ast, "test.cbl", TimeSpan.Zero);

        Assert.Contains("### MAIN-LOGIC", md);   // IsSection = true → ###
        Assert.Contains("#### SUB-PARA", md);     // IsSection = false → ####
    }

    // ── Statement group counts ───────────────────────────────────

    [Fact]
    public void Generate_ProcedureDivision_StatementGroupCounts()
    {
        var ast = MakeAst();
        ast.Procedure = new DivisionNode
        {
            DivisionName = "PROC",
            Children =
            [
                new ParagraphNode
                {
                    Name = "PARA",
                    Statements =
                    [
                        new MoveStatement { MoveFrom = "1", MoveTo = "A" },
                        new MoveStatement { MoveFrom = "2", MoveTo = "B" },
                        new SimpleStatement("STOP") { Text = "STOP RUN" }
                    ]
                }
            ]
        };
        var md = _reporter.Generate(ast, "test.cbl", TimeSpan.Zero);

        Assert.Contains("- MOVE: 2", md);
        Assert.Contains("- STOP: 1", md);
    }

    // ── Empty procedure ──────────────────────────────────────────

    [Fact]
    public void Generate_ProcedureDivision_Empty_ShowsNoData()
    {
        var ast = MakeAst();
        ast.Procedure = null;
        var md = _reporter.Generate(ast, "test.cbl", TimeSpan.Zero);

        Assert.Contains("無段落資料", md);
    }

    // ── Data items flat list ─────────────────────────────────────

    [Fact]
    public void Generate_DataItems_FlatList()
    {
        var ast = MakeAst();
        ast.Data = new DivisionNode
        {
            DivisionName = "DATA",
            Children =
            [
                new DataItemNode { Level = 1, Name = "WS-REC" },
                new DataItemNode { Level = 5, Name = "WS-FIELD", PicClause = "X(10)" }
            ]
        };
        var md = _reporter.Generate(ast, "test.cbl", TimeSpan.Zero);

        Assert.Contains("01 WS-REC", md);
        Assert.Contains("05 WS-FIELD  PIC X(10)", md);
    }

    // ── Nested items with indent ─────────────────────────────────

    [Fact]
    public void Generate_DataItems_NestedWithIndent()
    {
        var ast = MakeAst();
        ast.Data = new DivisionNode
        {
            DivisionName = "DATA",
            Children =
            [
                new DataItemNode
                {
                    Level = 1,
                    Name = "WS-REC",
                    Children =
                    [
                        new DataItemNode { Level = 5, Name = "WS-CHILD", PicClause = "9" }
                    ]
                }
            ]
        };
        var md = _reporter.Generate(ast, "test.cbl", TimeSpan.Zero);

        Assert.Contains("01 WS-REC", md);
        Assert.Contains("  05 WS-CHILD  PIC 9", md); // indented by 2 spaces
    }

    // ── Over 100 items truncation ────────────────────────────────

    [Fact]
    public void Generate_DataItems_OverHundred_Truncation()
    {
        var ast = MakeAst();
        var items = new List<AstNode>();
        for (int i = 0; i < 105; i++)
            items.Add(new DataItemNode { Level = 1, Name = $"ITEM-{i:D3}" });
        ast.Data = new DivisionNode { DivisionName = "DATA", Children = items };

        var md = _reporter.Generate(ast, "test.cbl", TimeSpan.Zero);

        Assert.Contains("ITEM-099", md);   // 100th item (0-indexed)
        Assert.DoesNotContain("ITEM-100", md); // 101st item — truncated
        Assert.Contains("還有 5 個項目", md);
    }

    // ── PIC, OCCURS, REDEFINES markers ───────────────────────────

    [Fact]
    public void Generate_DataItems_ShowsPicOccursRedefines()
    {
        var ast = MakeAst();
        ast.Data = new DivisionNode
        {
            DivisionName = "DATA",
            Children =
            [
                new DataItemNode { Level = 5, Name = "WS-A", PicClause = "X(5)" },
                new DataItemNode { Level = 5, Name = "WS-B", Occurs = "10 TIMES" },
                new DataItemNode { Level = 5, Name = "WS-C", Redefines = "WS-A" }
            ]
        };
        var md = _reporter.Generate(ast, "test.cbl", TimeSpan.Zero);

        Assert.Contains("PIC X(5)", md);
        Assert.Contains("[OCCURS]", md);
        Assert.Contains("[REDEFINES]", md);
    }

    // ── Null ProgramId ───────────────────────────────────────────

    [Fact]
    public void Generate_NullProgramId_ShowsUnknown()
    {
        var ast = new ProgramAst();
        var md = _reporter.Generate(ast, "test.cbl", TimeSpan.Zero);

        Assert.Contains("# COBOL AST Report: Unknown", md);
        Assert.Contains("| PROGRAM-ID | - |", md);
    }
}
