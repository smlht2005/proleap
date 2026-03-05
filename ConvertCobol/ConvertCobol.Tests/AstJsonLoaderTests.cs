using ConvertCobol.Loaders;
using ConvertCobol.Models;
using ConvertCobol.Reporters;

namespace ConvertCobol.Tests;

public class AstJsonLoaderTests
{
    private readonly JsonAstReporter _reporter = new();

    // ── Wrapper format ───────────────────────────────────────────

    [Fact]
    public void LoadFromString_WrapperFormat_ExtractsAst()
    {
        var original = new ProgramAst { ProgramId = "WRAPPER-TEST", StatementCount = 10 };
        var json = _reporter.Generate(original, "test.cbl", TimeSpan.Zero);

        var loaded = AstJsonLoader.LoadFromString(json);

        Assert.NotNull(loaded);
        Assert.Equal("WRAPPER-TEST", loaded!.ProgramId);
    }

    // ── Direct format ────────────────────────────────────────────

    [Fact]
    public void LoadFromString_DirectFormat_LoadsDirectly()
    {
        var json = """{ "programId": "DIRECT-TEST", "statementCount": 5 }""";
        var loaded = AstJsonLoader.LoadFromString(json);

        Assert.NotNull(loaded);
        Assert.Equal("DIRECT-TEST", loaded!.ProgramId);
        Assert.Equal(5, loaded.StatementCount);
    }

    // ── Case insensitive ─────────────────────────────────────────

    [Fact]
    public void LoadFromString_CaseInsensitive_AstProperty()
    {
        // lowercase "ast" works
        var json = """{ "ast": { "programId": "LOWER" } }""";
        var loaded = AstJsonLoader.LoadFromString(json);
        Assert.Equal("LOWER", loaded!.ProgramId);
    }

    [Fact]
    public void LoadFromString_CaseInsensitive_AstPropertyUppercase()
    {
        // uppercase "Ast" works
        var json = """{ "Ast": { "programId": "UPPER" } }""";
        var loaded = AstJsonLoader.LoadFromString(json);
        Assert.Equal("UPPER", loaded!.ProgramId);
    }

    // ── Counters preserved ───────────────────────────────────────

    [Fact]
    public void LoadFromString_PreservesCounters()
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
        var json = _reporter.Generate(original, "test.cbl", TimeSpan.Zero);
        var loaded = AstJsonLoader.LoadFromString(json);

        Assert.NotNull(loaded);
        Assert.Equal(3, loaded!.FdCount);
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

    // ── Data division preserved ──────────────────────────────────

    [Fact]
    public void LoadFromString_PreservesDataDivision()
    {
        var original = new ProgramAst
        {
            ProgramId = "DATA-TEST",
            Data = new DivisionNode
            {
                DivisionName = "DATA DIVISION",
                Children = [new DataItemNode { Level = 1, Name = "WS-REC" }]
            }
        };
        var json = _reporter.Generate(original, "test.cbl", TimeSpan.Zero);
        var loaded = AstJsonLoader.LoadFromString(json);

        Assert.NotNull(loaded?.Data);
        Assert.Single(loaded!.Data!.Children);
    }

    // ── Trailing commas ──────────────────────────────────────────

    // Note: AstJsonLoader.LoadFromString uses JsonDocument.Parse which does NOT
    // support trailing commas or comments by default. The Options with
    // AllowTrailingCommas/ReadCommentHandling are only used for deserialization.
    // This is a known limitation of the current implementation.

    // ── LoadFromFile ─────────────────────────────────────────────

    [Fact]
    public void LoadFromFile_ReadsAndDeserializes()
    {
        var tempFile = Path.GetTempFileName();
        try
        {
            var json = """{ "programId": "FILE-TEST", "statementCount": 99 }""";
            File.WriteAllText(tempFile, json);

            var loaded = AstJsonLoader.LoadFromFile(tempFile);

            Assert.NotNull(loaded);
            Assert.Equal("FILE-TEST", loaded!.ProgramId);
            Assert.Equal(99, loaded.StatementCount);
        }
        finally
        {
            File.Delete(tempFile);
        }
    }

    // ── Edge cases ───────────────────────────────────────────────

    [Fact]
    public void LoadFromString_EmptyObject_ReturnsAst()
    {
        var json = "{}";
        var loaded = AstJsonLoader.LoadFromString(json);
        Assert.NotNull(loaded);
        Assert.Null(loaded!.ProgramId);
    }

    [Fact]
    public void LoadFromString_WrapperWithEmptyAst_ReturnsAst()
    {
        var json = """{ "ast": {} }""";
        var loaded = AstJsonLoader.LoadFromString(json);
        Assert.NotNull(loaded);
        Assert.Null(loaded!.ProgramId);
    }
}
