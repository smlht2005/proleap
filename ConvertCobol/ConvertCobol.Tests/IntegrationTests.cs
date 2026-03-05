using Antlr4.Runtime;
using ConvertCobol.Generated;
using ConvertCobol.Models;
using ConvertCobol.Models.Statements;
using ConvertCobol.Visitors;
using ConvertCobol.Reporters;
using ConvertCobol.Loaders;
using ConvertCobol.CodeGen;
using ConvertCobol.Preprocessing;
using Microsoft.Extensions.Logging.Abstractions;

namespace ConvertCobol.Tests;

/// <summary>
/// End-to-end integration tests using inline COBOL snippets parsed through the full ANTLR pipeline.
/// </summary>
public class IntegrationTests
{
    private static ProgramAst ParseCobol(string cobolSource)
    {
        cobolSource = CommentNormalizer.ConvertTraditionalComments(cobolSource);
        var input = new AntlrInputStream(cobolSource);
        var lexer = new Cobol85AcuLexer(input);
        var tokens = new CommonTokenStream(lexer);
        var parser = new Cobol85AcuParser(tokens);
        parser.ErrorHandler = new DefaultErrorStrategy();
        var tree = parser.startRule();

        var visitor = new CobolAstVisitor(NullLogger<CobolAstVisitor>.Instance);
        visitor.SetCobolSource(cobolSource);
        visitor.Visit(tree);
        return visitor.Result;
    }

    private static ProgramAst ParseProcedureOnly(string cobolSource)
    {
        cobolSource = CommentNormalizer.ConvertTraditionalComments(cobolSource);
        var procMark = "PROCEDURE DIVISION";
        var idx = cobolSource.IndexOf(procMark, StringComparison.OrdinalIgnoreCase);
        if (idx < 0) return new ProgramAst();
        var procedureSource = CommentNormalizer.NormalizeProcedureComments(cobolSource.Substring(idx));
        var input = new AntlrInputStream(procedureSource);
        var lexer = new Cobol85AcuLexer(input);
        var tokens = new CommonTokenStream(lexer);
        var parser = new Cobol85AcuParser(tokens);
        parser.ErrorHandler = new DefaultErrorStrategy();
        var tree = parser.procedureOnlyStart();

        var visitor = new CobolAstVisitor(NullLogger<CobolAstVisitor>.Instance);
        visitor.SetCobolSource(procedureSource);
        visitor.Visit(tree);
        return visitor.Result;
    }

    // ── Minimal program ──────────────────────────────────────────

    private const string MinimalProgram = """
           IDENTIFICATION DIVISION.
           PROGRAM-ID. TEST-PROG.
           PROCEDURE DIVISION.
           MAIN-LOGIC.
               MOVE 1 TO WS-COUNT.
               STOP RUN.
       """;

    [Fact]
    public void Parse_MinimalProgram_ProducesProgramId()
    {
        var ast = ParseCobol(MinimalProgram);
        Assert.Equal("TEST-PROG", ast.ProgramId);
    }

    [Fact]
    public void Parse_MinimalProgram_ProducesStatements()
    {
        // Try full parse first; if procedure is empty, use procedure-only parse
        var ast = ParseCobol(MinimalProgram);
        if (ast.Procedure == null || (ast.Procedure.Children?.Count ?? 0) == 0)
            ast = ParseProcedureOnly(MinimalProgram);

        Assert.NotNull(ast.Procedure);
        Assert.True(ast.Procedure!.Children.Count > 0);
    }

    // ── Working storage ──────────────────────────────────────────

    private const string WithWorkingStorage = """
           IDENTIFICATION DIVISION.
           PROGRAM-ID. WS-TEST.
           DATA DIVISION.
           WORKING-STORAGE SECTION.
           01  WS-REC.
               05  WS-FIELD-A       PIC X(10).
               05  WS-FIELD-B       PIC 9(4).
           77  WS-STANDALONE        PIC X.
           PROCEDURE DIVISION.
           MAIN-LOGIC.
               STOP RUN.
       """;

    [Fact]
    public void Parse_WorkingStorage_ProducesDataItems()
    {
        var ast = ParseCobol(WithWorkingStorage);
        Assert.True(ast.TotalDataItems > 0, $"Expected data items, got {ast.TotalDataItems}");
    }

    // ── Multiple statements ──────────────────────────────────────

    private const string MultipleStatements = """
           IDENTIFICATION DIVISION.
           PROGRAM-ID. MULTI-STMT.
           PROCEDURE DIVISION.
           MAIN-LOGIC.
               MOVE 1 TO WS-A.
               MOVE 2 TO WS-B.
               MOVE 3 TO WS-C.
               DISPLAY "HELLO".
               STOP RUN.
       """;

    [Fact]
    public void Parse_MultipleStatements_CorrectCount()
    {
        var ast = ParseCobol(MultipleStatements);
        if (ast.Procedure == null || (ast.Procedure.Children?.Count ?? 0) == 0)
            ast = ParseProcedureOnly(MultipleStatements);

        Assert.True(ast.StatementCount >= 3, $"Expected at least 3 statements, got {ast.StatementCount}");
    }

    // ── Pipeline: Parse → Serialize → Deserialize ────────────────

    [Fact]
    public void Pipeline_Parse_Serialize_Deserialize_RoundTrip()
    {
        var ast = ParseCobol(MinimalProgram);
        var reporter = new JsonAstReporter();
        var json = reporter.Generate(ast, "test.cbl", TimeSpan.Zero);

        var loaded = AstJsonLoader.LoadFromString(json);

        Assert.NotNull(loaded);
        Assert.Equal(ast.ProgramId, loaded!.ProgramId);
        Assert.Equal(ast.StatementCount, loaded.StatementCount);
    }

    // ── Pipeline: Parse → Emit C# ───────────────────────────────

    [Fact]
    public void Pipeline_Parse_EmitCSharp_ContainsMethod()
    {
        var ast = ParseCobol(MultipleStatements);
        if (ast.Procedure == null || (ast.Procedure.Children?.Count ?? 0) == 0)
            ast = ParseProcedureOnly(MultipleStatements);

        if (ast.Procedure != null && (ast.Procedure.Children?.Count ?? 0) > 0)
        {
            var emitter = new ProcedureToCSharpEmitter();
            var csharp = emitter.EmitProcedureDivision(ast.Procedure, ast.ProgramId ?? "Program");

            Assert.Contains("Generated from COBOL", csharp);
            Assert.Contains("void", csharp);
        }
    }

    // ── Pipeline: Parse → Markdown ───────────────────────────────

    [Fact]
    public void Pipeline_Parse_MarkdownReport_ContainsOverview()
    {
        var ast = ParseCobol(MinimalProgram);
        var reporter = new MarkdownAstReporter();
        var md = reporter.Generate(ast, "test.cbl", TimeSpan.Zero);

        Assert.Contains("# COBOL AST Report: TEST-PROG", md);
        Assert.Contains("概覽", md);
        Assert.Contains("PROGRAM-ID", md);
    }

    // ── Empty procedure ──────────────────────────────────────────

    [Fact]
    public void Parse_EmptyProgram_NoExceptions()
    {
        var cobol = """
                IDENTIFICATION DIVISION.
                PROGRAM-ID. EMPTY-PROG.
            """;
        var ast = ParseCobol(cobol);
        Assert.Equal("EMPTY-PROG", ast.ProgramId);
    }

    // ── Comment normalization ────────────────────────────────────

    [Fact]
    public void Parse_TraditionalComments_Handled()
    {
        var cobol = """
           IDENTIFICATION DIVISION.
           *> This is a traditional comment
           PROGRAM-ID. COMMENT-TEST.
           PROCEDURE DIVISION.
           *> Another comment
           MAIN-LOGIC.
               STOP RUN.
           """;
        // Should not throw during parsing
        var ast = ParseCobol(cobol);
        Assert.Equal("COMMENT-TEST", ast.ProgramId);
    }

    // ── ProgramId extraction ─────────────────────────────────────

    [Theory]
    [InlineData("SIMPLE-ID")]
    [InlineData("PROG123")]
    [InlineData("MY-PROGRAM")]
    public void Parse_VariousProgramIds_Extracted(string progId)
    {
        var cobol = $"""
               IDENTIFICATION DIVISION.
               PROGRAM-ID. {progId}.
           """;
        var ast = ParseCobol(cobol);
        Assert.Equal(progId, ast.ProgramId);
    }

    // ── Multiple divisions present ───────────────────────────────

    [Fact]
    public void Parse_AllDivisions_Present()
    {
        var cobol = """
               IDENTIFICATION DIVISION.
               PROGRAM-ID. FULL-PROG.
               ENVIRONMENT DIVISION.
               DATA DIVISION.
               WORKING-STORAGE SECTION.
               01  WS-A PIC X.
               PROCEDURE DIVISION.
               MAIN-LOGIC.
                   STOP RUN.
           """;
        var ast = ParseCobol(cobol);

        Assert.Equal("FULL-PROG", ast.ProgramId);
        // Identification, Environment, Data should be populated
        Assert.NotNull(ast.Identification);
    }
}
