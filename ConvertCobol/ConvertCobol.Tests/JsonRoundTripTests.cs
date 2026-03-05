using ConvertCobol.Loaders;
using ConvertCobol.Models;
using ConvertCobol.Models.Statements;
using ConvertCobol.Reporters;

namespace ConvertCobol.Tests;

/// <summary>
/// JSON serialize → deserialize round-trip tests.
/// Uses JsonAstReporter.Generate() for serialization and AstJsonLoader.LoadFromString() for deserialization.
/// Statement subclass concrete types are preserved across the JSON round-trip via
/// StatementNodeJsonConverter and AstNode polymorphic deserialization with $type discriminators.
/// </summary>
public class JsonRoundTripTests
{
    private readonly JsonAstReporter _reporter = new();

    private ProgramAst RoundTrip(ProgramAst original)
    {
        var json = _reporter.Generate(original, "test.cbl", TimeSpan.Zero);
        return AstJsonLoader.LoadFromString(json)!;
    }

    // ── ProgramAst basic ─────────────────────────────────────────

    [Fact]
    public void RoundTrip_ProgramAst_BasicProperties()
    {
        var original = new ProgramAst { ProgramId = "TEST-PROG" };
        var loaded = RoundTrip(original);
        Assert.Equal("TEST-PROG", loaded.ProgramId);
    }

    [Fact]
    public void RoundTrip_ProgramAst_AllCounters()
    {
        var original = new ProgramAst
        {
            ProgramId = "COUNTERS",
            FdCount = 3,
            DataItem01Count = 5,
            DataItem77Count = 2,
            TotalDataItems = 15,
            SectionCount = 4,
            ParagraphCount = 10,
            StatementCount = 50,
            HasScreenSection = true,
            ScreenSectionItemCount = 8,
            FileControlEntryCount = 3
        };
        var loaded = RoundTrip(original);

        Assert.Equal("COUNTERS", loaded.ProgramId);
        Assert.Equal(3, loaded.FdCount);
        Assert.Equal(5, loaded.DataItem01Count);
        Assert.Equal(2, loaded.DataItem77Count);
        Assert.Equal(15, loaded.TotalDataItems);
        Assert.Equal(4, loaded.SectionCount);
        Assert.Equal(10, loaded.ParagraphCount);
        Assert.Equal(50, loaded.StatementCount);
        Assert.True(loaded.HasScreenSection);
        Assert.Equal(8, loaded.ScreenSectionItemCount);
        Assert.Equal(3, loaded.FileControlEntryCount);
    }

    // ── DivisionNode ─────────────────────────────────────────────

    [Fact]
    public void RoundTrip_DivisionNode_WithChildren()
    {
        var original = new ProgramAst
        {
            ProgramId = "DIV-TEST",
            Data = new DivisionNode
            {
                DivisionName = "DATA DIVISION",
                Children =
                [
                    new DataItemNode { Level = 1, Name = "WS-REC" },
                    new DataItemNode { Level = 5, Name = "WS-FIELD", PicClause = "X(10)" }
                ]
            }
        };
        var loaded = RoundTrip(original);

        Assert.NotNull(loaded.Data);
        Assert.Equal("DATA DIVISION", loaded.Data!.DivisionName);
        Assert.Equal(2, loaded.Data.Children.Count);
    }

    // ── DataItemNode with hierarchy ──────────────────────────────

    [Fact]
    public void RoundTrip_DataItemNode_WithHierarchy()
    {
        var original = new ProgramAst
        {
            ProgramId = "HIERARCHY",
            Data = new DivisionNode
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
                            new DataItemNode { Level = 5, Name = "WS-FIELD", PicClause = "X(10)" }
                        ]
                    }
                ]
            }
        };
        var loaded = RoundTrip(original);
        var rec = loaded.Data!.Children[0] as DataItemNode;
        Assert.NotNull(rec);
        Assert.Equal("WS-REC", rec!.Name);
        Assert.Single(rec.Children);
        Assert.Equal("WS-FIELD", rec.Children[0].Name);
        Assert.Equal("X(10)", rec.Children[0].PicClause);
    }

    // ── DataItemNode properties ──────────────────────────────────

    [Fact]
    public void RoundTrip_DataItemNode_AllProperties()
    {
        var original = new ProgramAst
        {
            ProgramId = "DATA-PROPS",
            Data = new DivisionNode
            {
                DivisionName = "DATA",
                Children =
                [
                    new DataItemNode
                    {
                        Level = 5,
                        Name = "WS-FIELD",
                        PicClause = "9(4)V99",
                        Redefines = "WS-OTHER",
                        Occurs = "10 TIMES",
                        ValueClause = "ZEROES"
                    }
                ]
            }
        };
        var loaded = RoundTrip(original);
        var item = loaded.Data!.Children[0] as DataItemNode;
        Assert.NotNull(item);
        Assert.Equal(5, item!.Level);
        Assert.Equal("WS-FIELD", item.Name);
        Assert.Equal("9(4)V99", item.PicClause);
        Assert.Equal("WS-OTHER", item.Redefines);
        Assert.Equal("10 TIMES", item.Occurs);
        Assert.Equal("ZEROES", item.ValueClause);
    }

    // ── ParagraphNode ────────────────────────────────────────────

    [Fact]
    public void RoundTrip_ParagraphNode_WithStatements()
    {
        var original = new ProgramAst
        {
            ProgramId = "PARA-TEST",
            Procedure = new DivisionNode
            {
                DivisionName = "PROCEDURE DIVISION",
                Children =
                [
                    new ParagraphNode
                    {
                        Name = "MAIN-LOGIC",
                        IsSection = false,
                        Statements = [new MoveStatement { MoveFrom = "1", MoveTo = "WS-A", Text = "MOVE 1 TO WS-A" }]
                    }
                ]
            }
        };
        var loaded = RoundTrip(original);

        Assert.NotNull(loaded.Procedure);
        Assert.Single(loaded.Procedure!.Children);
        var para = loaded.Procedure.Children[0] as ParagraphNode;
        Assert.NotNull(para);
        Assert.Equal("MAIN-LOGIC", para!.Name);
        Assert.False(para.IsSection);
        Assert.Single(para.Statements);
    }

    // ── Statement subclass properties via reporter ───────────────
    // The JSON reporter writes concrete type properties. Whether they
    // survive deserialization depends on the $type discriminator.

    [Fact]
    public void RoundTrip_ParagraphNode_StatementTextPreserved()
    {
        var original = new ProgramAst
        {
            ProgramId = "TEXT",
            Procedure = new DivisionNode
            {
                DivisionName = "PROC",
                Children =
                [
                    new ParagraphNode
                    {
                        Name = "PARA",
                        Statements =
                        [
                            new MoveStatement { MoveFrom = "SPACES", MoveTo = "WS-BUF", Text = "MOVE SPACES TO WS-BUF" }
                        ]
                    }
                ]
            }
        };
        var loaded = RoundTrip(original);
        var stmts = (loaded.Procedure!.Children[0] as ParagraphNode)!.Statements;
        Assert.Single(stmts);
        // StatementType and Text survive on the base StatementNode
        Assert.Equal("MOVE", stmts[0].StatementType);
        Assert.Equal("MOVE SPACES TO WS-BUF", stmts[0].Text);
    }

    // ── Multiple paragraphs ──────────────────────────────────────

    [Fact]
    public void RoundTrip_MultipleParagraphs()
    {
        var original = new ProgramAst
        {
            ProgramId = "MULTI",
            Procedure = new DivisionNode
            {
                DivisionName = "PROC",
                Children =
                [
                    new ParagraphNode { Name = "PARA-A", Statements = [new SimpleStatement("CONTINUE")] },
                    new ParagraphNode { Name = "PARA-B", Statements = [new SimpleStatement("STOP")] },
                    new ParagraphNode { Name = "PARA-C", IsSection = true }
                ]
            }
        };
        var loaded = RoundTrip(original);

        Assert.Equal(3, loaded.Procedure!.Children.Count);
        var paraA = loaded.Procedure.Children[0] as ParagraphNode;
        var paraB = loaded.Procedure.Children[1] as ParagraphNode;
        var paraC = loaded.Procedure.Children[2] as ParagraphNode;
        Assert.Equal("PARA-A", paraA!.Name);
        Assert.Equal("PARA-B", paraB!.Name);
        Assert.Equal("PARA-C", paraC!.Name);
        Assert.True(paraC.IsSection);
    }

    // ── Chinese characters ───────────────────────────────────────

    [Fact]
    public void RoundTrip_ChineseCharacters_Preserved()
    {
        var original = new ProgramAst
        {
            ProgramId = "CHINESE",
            Data = new DivisionNode
            {
                DivisionName = "DATA",
                Children = [new DataItemNode { Level = 1, Name = "細明體資料" }]
            }
        };
        var loaded = RoundTrip(original);
        var item = loaded.Data!.Children[0] as DataItemNode;
        Assert.Equal("細明體資料", item!.Name);
    }

    // ── Null divisions ───────────────────────────────────────────

    [Fact]
    public void RoundTrip_NullDivisions_StayNull()
    {
        var original = new ProgramAst
        {
            ProgramId = "NULL-DIVS",
            Identification = null,
            Environment = null,
            Data = null,
            Procedure = null
        };
        var loaded = RoundTrip(original);

        Assert.Equal("NULL-DIVS", loaded.ProgramId);
        Assert.Null(loaded.Identification);
        Assert.Null(loaded.Environment);
        Assert.Null(loaded.Data);
        Assert.Null(loaded.Procedure);
    }

    // ── Empty divisions ──────────────────────────────────────────

    [Fact]
    public void RoundTrip_EmptyDivisions()
    {
        var original = new ProgramAst
        {
            ProgramId = "EMPTY",
            Data = new DivisionNode { DivisionName = "DATA", Children = [] },
            Procedure = new DivisionNode { DivisionName = "PROC", Children = [] }
        };
        var loaded = RoundTrip(original);

        Assert.NotNull(loaded.Data);
        Assert.Empty(loaded.Data!.Children);
        Assert.NotNull(loaded.Procedure);
        Assert.Empty(loaded.Procedure!.Children);
    }

    // ── Full pipeline AST ────────────────────────────────────────

    [Fact]
    public void RoundTrip_FullPipeline_AllDivisions()
    {
        var original = new ProgramAst
        {
            ProgramId = "FULL",
            FdCount = 1,
            StatementCount = 3,
            ParagraphCount = 2,
            Identification = new DivisionNode { DivisionName = "ID" },
            Environment = new DivisionNode { DivisionName = "ENV" },
            Data = new DivisionNode
            {
                DivisionName = "DATA",
                Children = [new DataItemNode { Level = 1, Name = "WS-REC" }]
            },
            Procedure = new DivisionNode
            {
                DivisionName = "PROC",
                Children =
                [
                    new ParagraphNode
                    {
                        Name = "MAIN",
                        Statements =
                        [
                            new MoveStatement { MoveFrom = "1", MoveTo = "WS-A" },
                            new SimpleStatement("STOP") { Text = "STOP RUN" }
                        ]
                    },
                    new ParagraphNode { Name = "SUB-PARA" }
                ]
            }
        };
        var loaded = RoundTrip(original);

        Assert.Equal("FULL", loaded.ProgramId);
        Assert.Equal(1, loaded.FdCount);
        Assert.Equal(3, loaded.StatementCount);
        Assert.Equal(2, loaded.ParagraphCount);

        Assert.NotNull(loaded.Identification);
        Assert.NotNull(loaded.Environment);
        Assert.NotNull(loaded.Data);
        Assert.NotNull(loaded.Procedure);

        Assert.Single(loaded.Data!.Children);
        Assert.Equal(2, loaded.Procedure!.Children.Count);

        var mainPara = loaded.Procedure.Children[0] as ParagraphNode;
        Assert.Equal("MAIN", mainPara!.Name);
        Assert.Equal(2, mainPara.Statements.Count);
    }
}
