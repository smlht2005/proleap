using System.Text.Json;
using ConvertCobol.Models;
using ConvertCobol.Models.Statements;
using ConvertCobol.Reporters;

namespace ConvertCobol.Tests;

public class JsonAstReporterTests
{
    private readonly JsonAstReporter _reporter = new();

    private static ProgramAst MakeMinimalAst() => new()
    {
        ProgramId = "TEST-PROG",
        FdCount = 2,
        DataItem01Count = 3,
        DataItem77Count = 1,
        TotalDataItems = 10,
        SectionCount = 2,
        ParagraphCount = 5,
        StatementCount = 20,
        HasScreenSection = true,
        ScreenSectionItemCount = 8,
        FileControlEntryCount = 3
    };

    // ── Meta wrapper ─────────────────────────────────────────────

    [Fact]
    public void Generate_HasMetaWrapper_WithTimestamp()
    {
        var ast = MakeMinimalAst();
        var json = _reporter.Generate(ast, "test.cbl", TimeSpan.FromMilliseconds(42));
        using var doc = JsonDocument.Parse(json);
        var root = doc.RootElement;

        Assert.True(root.TryGetProperty("meta", out var meta));
        Assert.True(meta.TryGetProperty("generatedAt", out _));
        Assert.Equal("test.cbl", meta.GetProperty("sourceFile").GetString());
        Assert.Equal("ANTLR4 Cobol85Acu (C#)", meta.GetProperty("parser").GetString());
        Assert.Equal(42, meta.GetProperty("parseTimeMs").GetDouble(), 1);
    }

    // ── Overview section ─────────────────────────────────────────

    [Fact]
    public void Generate_HasOverviewSection_WithAllCounters()
    {
        var ast = MakeMinimalAst();
        var json = _reporter.Generate(ast, "test.cbl", TimeSpan.Zero);
        using var doc = JsonDocument.Parse(json);
        var overview = doc.RootElement.GetProperty("overview");

        Assert.Equal("TEST-PROG", overview.GetProperty("programId").GetString());
        Assert.Equal(2, overview.GetProperty("fdCount").GetInt32());
        Assert.Equal(3, overview.GetProperty("dataItem01Count").GetInt32());
        Assert.Equal(1, overview.GetProperty("dataItem77Count").GetInt32());
        Assert.Equal(10, overview.GetProperty("totalDataItems").GetInt32());
        Assert.Equal(2, overview.GetProperty("sectionCount").GetInt32());
        Assert.Equal(5, overview.GetProperty("paragraphCount").GetInt32());
        Assert.Equal(20, overview.GetProperty("statementCount").GetInt32());
        Assert.True(overview.GetProperty("hasScreenSection").GetBoolean());
        Assert.Equal(8, overview.GetProperty("screenSectionItemCount").GetInt32());
        Assert.Equal(3, overview.GetProperty("fileControlEntryCount").GetInt32());
    }

    // ── AST section ──────────────────────────────────────────────

    [Fact]
    public void Generate_HasAstSection_WithProgramId()
    {
        var ast = MakeMinimalAst();
        var json = _reporter.Generate(ast, "test.cbl", TimeSpan.Zero);
        using var doc = JsonDocument.Parse(json);
        var astElem = doc.RootElement.GetProperty("ast");

        Assert.Equal("TEST-PROG", astElem.GetProperty("programId").GetString());
    }

    // ── Chinese encoding ─────────────────────────────────────────

    [Fact]
    public void Generate_ChineseCharacters_NotEscaped()
    {
        var ast = new ProgramAst
        {
            ProgramId = "TEST",
            Data = new DivisionNode
            {
                DivisionName = "DATA DIVISION",
                Children = [new DataItemNode { Level = 1, Name = "細明體" }]
            }
        };
        var json = _reporter.Generate(ast, "test.cbl", TimeSpan.Zero);

        // Chinese chars should appear directly, not as \uXXXX
        Assert.Contains("細明體", json);
        Assert.DoesNotContain("\\u7D30", json);
    }

    // ── Null properties omitted ──────────────────────────────────

    [Fact]
    public void Generate_NullProperties_Omitted()
    {
        var ast = MakeMinimalAst(); // No divisions set
        var json = _reporter.Generate(ast, "test.cbl", TimeSpan.Zero);

        // Null properties should not appear in output
        Assert.DoesNotContain("\"identification\"", json);
        Assert.DoesNotContain("\"environment\"", json);
        Assert.DoesNotContain("\"data\"", json);
        Assert.DoesNotContain("\"procedure\"", json);
    }

    // ── Polymorphic type ─────────────────────────────────────────

    [Fact]
    public void Generate_PolymorphicType_InOutput()
    {
        var ast = new ProgramAst
        {
            ProgramId = "TEST",
            Procedure = new DivisionNode
            {
                DivisionName = "PROCEDURE DIVISION",
                Children =
                [
                    new ParagraphNode
                    {
                        Name = "MAIN-LOGIC",
                        Statements = [new MoveStatement { MoveFrom = "1", MoveTo = "WS-A" }]
                    }
                ]
            }
        };
        var json = _reporter.Generate(ast, "test.cbl", TimeSpan.Zero);

        // $type discriminator should appear on DivisionNode children (which go through AstNode polymorphism)
        Assert.Contains("\"$type\"", json);
        // Paragraph is serialized through AstNode polymorphism
        Assert.Contains("Paragraph", json);
        // MoveStatement properties should appear (via StatementNodeJsonConverter runtime-type write)
        Assert.Contains("\"moveFrom\"", json);
        Assert.Contains("\"moveTo\"", json);
    }

    [Fact]
    public void Generate_StatementType_InOutput()
    {
        var ast = new ProgramAst
        {
            ProgramId = "TEST",
            Procedure = new DivisionNode
            {
                DivisionName = "PROCEDURE DIVISION",
                Children =
                [
                    new ParagraphNode
                    {
                        Name = "MAIN",
                        Statements = [new MoveStatement { MoveFrom = "1", MoveTo = "WS-A" }]
                    }
                ]
            }
        };
        var json = _reporter.Generate(ast, "test.cbl", TimeSpan.Zero);

        Assert.Contains("\"statementType\"", json);
        Assert.Contains("\"MOVE\"", json);
    }

    // ── Empty AST ────────────────────────────────────────────────

    [Fact]
    public void Generate_EmptyAst_NoExceptions()
    {
        var ast = new ProgramAst();
        var json = _reporter.Generate(ast, "empty.cbl", TimeSpan.Zero);

        Assert.NotNull(json);
        Assert.Contains("\"meta\"", json);
        Assert.Contains("\"overview\"", json);
        Assert.Contains("\"ast\"", json);
    }
}
