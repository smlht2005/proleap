using ConvertCobol.Models;
using ConvertCobol.Models.Statements;
using ConvertCobol.Visitors;

namespace ConvertCobol.Tests;

public class NormalizeStatementsTests
{
    // ── FixStatementTruncateAtWhen ───────────────────────────────

    [Fact]
    public void FixTruncate_MoveWithWhenInText_TruncatesCorrectly()
    {
        var stmt = new MoveStatement
        {
            MoveFrom = "1",
            MoveTo = "WS-A",
            Text = "MOVE 1 TO WS-A\n           WHEN 901"
        };
        CobolAstVisitor.FixStatementTruncateAtWhen(stmt);
        Assert.Equal("MOVE 1 TO WS-A", stmt.Text);
    }

    [Fact]
    public void FixTruncate_MoveWithWhenOther_TruncatesMoveTo()
    {
        var stmt = new MoveStatement
        {
            MoveFrom = "1",
            MoveTo = "WS-A WHEN OTHER",
            Text = "MOVE 1 TO WS-A\r\n           WHEN OTHER"
        };
        CobolAstVisitor.FixStatementTruncateAtWhen(stmt);
        Assert.Equal("MOVE 1 TO WS-A", stmt.Text);
        Assert.Equal("WS-A", stmt.MoveTo);
    }

    [Fact]
    public void FixTruncate_NonMoveStatement_OnlyTruncatesText()
    {
        var stmt = new SimpleStatement("ADD")
        {
            Text = "ADD 1 TO WS-COUNTER\n           WHEN 100"
        };
        CobolAstVisitor.FixStatementTruncateAtWhen(stmt);
        Assert.Equal("ADD 1 TO WS-COUNTER", stmt.Text);
    }

    [Fact]
    public void FixTruncate_NoWhenInText_Unchanged()
    {
        var stmt = new MoveStatement
        {
            MoveFrom = "SPACES",
            MoveTo = "WS-BUFFER",
            Text = "MOVE SPACES TO WS-BUFFER"
        };
        CobolAstVisitor.FixStatementTruncateAtWhen(stmt);
        Assert.Equal("MOVE SPACES TO WS-BUFFER", stmt.Text);
        Assert.Equal("WS-BUFFER", stmt.MoveTo);
    }

    [Fact]
    public void FixTruncate_MoveWithMessageInMoveTo_Cleaned()
    {
        var stmt = new MoveStatement
        {
            MoveFrom = "1",
            MoveTo = "WS-A, message text here",
            Text = "MOVE 1 TO WS-A\n           WHEN 901"
        };
        CobolAstVisitor.FixStatementTruncateAtWhen(stmt);
        Assert.Equal("MOVE 1 TO WS-A", stmt.Text);
        // Comma truncates first, then WHEN check
        Assert.Equal("WS-A", stmt.MoveTo);
    }

    [Fact]
    public void FixTruncate_NullText_NoException()
    {
        var stmt = new MoveStatement { MoveFrom = "1", MoveTo = "WS-A", Text = null };
        CobolAstVisitor.FixStatementTruncateAtWhen(stmt);
        Assert.Null(stmt.Text);
    }

    [Fact]
    public void FixTruncate_EmptyText_NoException()
    {
        var stmt = new MoveStatement { MoveFrom = "1", MoveTo = "WS-A", Text = "" };
        CobolAstVisitor.FixStatementTruncateAtWhen(stmt);
        Assert.Equal("", stmt.Text);
    }

    // ── EnrichAcceptFromText ─────────────────────────────────────

    [Fact]
    public void EnrichAccept_ExtractsFromEnvironment()
    {
        var stmt = new AcceptStatement
        {
            Text = "ACCEPT WS-PATH FROM ENVIRONMENT \"HOME_DIR\""
        };
        CobolAstVisitor.EnrichAcceptFromText(stmt);
        Assert.Equal("WS-PATH", stmt.AcceptTarget);
        Assert.Equal("HOME_DIR", stmt.AcceptFromEnvironment);
    }

    [Fact]
    public void EnrichAccept_DetectsEndAccept()
    {
        var stmt = new AcceptStatement
        {
            Text = "ACCEPT WS-INPUT FROM ENVIRONMENT \"VAR\" END-ACCEPT"
        };
        CobolAstVisitor.EnrichAcceptFromText(stmt);
        Assert.Equal("END-ACCEPT", stmt.AcceptBlockEnd);
    }

    [Fact]
    public void EnrichAccept_NoEnvironment_Unchanged()
    {
        var stmt = new AcceptStatement
        {
            Text = "ACCEPT WS-DATE FROM DAY",
            AcceptTarget = "WS-DATE"
        };
        CobolAstVisitor.EnrichAcceptFromText(stmt);
        // AcceptFromEnvironment remains null because no ENVIRONMENT match
        Assert.Null(stmt.AcceptFromEnvironment);
        Assert.Equal("WS-DATE", stmt.AcceptTarget);
    }

    [Fact]
    public void EnrichAccept_ExistingValues_NotOverwritten()
    {
        var stmt = new AcceptStatement
        {
            Text = "ACCEPT WS-PATH FROM ENVIRONMENT \"HOME_DIR\"",
            AcceptTarget = "EXISTING-TARGET",
            AcceptFromEnvironment = "EXISTING-ENV"
        };
        CobolAstVisitor.EnrichAcceptFromText(stmt);
        // Existing values should NOT be overwritten
        Assert.Equal("EXISTING-TARGET", stmt.AcceptTarget);
        Assert.Equal("EXISTING-ENV", stmt.AcceptFromEnvironment);
    }

    [Fact]
    public void EnrichAccept_NullStatement_NoException()
    {
        CobolAstVisitor.EnrichAcceptFromText(null!);
        // Should not throw
    }

    // ── EnrichDisplayFromText ────────────────────────────────────

    [Fact]
    public void EnrichDisplay_ExtractsUpon()
    {
        var stmt = new DisplayStatement
        {
            Text = "DISPLAY WS-MSG UPON STANDARD-OUTPUT"
        };
        CobolAstVisitor.EnrichDisplayFromText(stmt);
        Assert.Equal("STANDARD-OUTPUT", stmt.DisplayUpon);
    }

    [Fact]
    public void EnrichDisplay_ExtractsOperands()
    {
        var stmt = new DisplayStatement
        {
            Text = "DISPLAY WS-A WS-B WS-C"
        };
        CobolAstVisitor.EnrichDisplayFromText(stmt);
        Assert.NotNull(stmt.DisplayOperands);
        Assert.Equal(3, stmt.DisplayOperands!.Count);
        Assert.Equal("WS-A", stmt.DisplayOperands["0"]);
        Assert.Equal("WS-B", stmt.DisplayOperands["1"]);
        Assert.Equal("WS-C", stmt.DisplayOperands["2"]);
    }

    [Fact]
    public void EnrichDisplay_DetectsEndDisplay()
    {
        var stmt = new DisplayStatement
        {
            Text = "DISPLAY WS-MSG END-DISPLAY"
        };
        CobolAstVisitor.EnrichDisplayFromText(stmt);
        Assert.Equal("END-DISPLAY", stmt.DisplayBlockEnd);
    }

    [Fact]
    public void EnrichDisplay_DetectsPeriodBlockEnd()
    {
        var stmt = new DisplayStatement
        {
            Text = "DISPLAY WS-MSG."
        };
        CobolAstVisitor.EnrichDisplayFromText(stmt);
        Assert.Equal(".", stmt.DisplayBlockEnd);
    }

    [Fact]
    public void EnrichDisplay_ExistingUpon_NotOverwritten()
    {
        var stmt = new DisplayStatement
        {
            Text = "DISPLAY WS-MSG UPON STANDARD-OUTPUT",
            DisplayUpon = "EXISTING-UPON"
        };
        CobolAstVisitor.EnrichDisplayFromText(stmt);
        Assert.Equal("EXISTING-UPON", stmt.DisplayUpon);
    }

    [Fact]
    public void EnrichDisplay_NullStatement_NoException()
    {
        CobolAstVisitor.EnrichDisplayFromText(null!);
        // Should not throw
    }

    // ── EnrichDisplayProperties ──────────────────────────────────

    [Fact]
    public void EnrichDisplay_ExtractsWindowType()
    {
        var stmt = new DisplayStatement
        {
            Text = "DISPLAY FLOATING WINDOW LINES 24 SIZE 80"
        };
        CobolAstVisitor.EnrichDisplayProperties(stmt);
        Assert.Equal("FLOATING", stmt.DisplayType);
        Assert.Equal("WINDOW", stmt.DisplayWindow);
    }

    [Fact]
    public void EnrichDisplay_ExtractsLinesSize()
    {
        var stmt = new DisplayStatement
        {
            Text = "DISPLAY FLOATING WINDOW LINES 24 SIZE 80"
        };
        CobolAstVisitor.EnrichDisplayProperties(stmt);
        Assert.Equal("24", stmt.DisplayLines);
        Assert.Equal("80", stmt.DisplaySize);
    }

    [Fact]
    public void EnrichDisplay_ExtractsCellDimensions()
    {
        var stmt = new DisplayStatement
        {
            Text = "DISPLAY STANDARD WINDOW CELL HEIGHT 12 CELL WIDTH 8"
        };
        CobolAstVisitor.EnrichDisplayProperties(stmt);
        Assert.Equal("12", stmt.DisplayCellHeight);
        Assert.Equal("8", stmt.DisplayCellWidth);
    }

    [Fact]
    public void EnrichDisplay_ExtractsColorAndLabel()
    {
        var stmt = new DisplayStatement
        {
            Text = "DISPLAY FLOATING WINDOW COLOR IS 7 LABEL-OFFSET 0"
        };
        CobolAstVisitor.EnrichDisplayProperties(stmt);
        Assert.Equal("7", stmt.DisplayColor);
        Assert.Equal("0", stmt.DisplayLabelOffset);
    }

    [Fact]
    public void EnrichDisplay_ExtractsBooleanFlags()
    {
        var stmt = new DisplayStatement
        {
            Text = "DISPLAY FLOATING WINDOW NO SCROLL TITLE-BAR NO WRAP"
        };
        CobolAstVisitor.EnrichDisplayProperties(stmt);
        Assert.True(stmt.DisplayNoScroll);
        Assert.True(stmt.DisplayTitleBar);
        Assert.True(stmt.DisplayNoWrap);
    }

    [Fact]
    public void EnrichDisplay_ExtractsHandleAndLinkTo()
    {
        var stmt = new DisplayStatement
        {
            Text = "DISPLAY FLOATING WINDOW HANDLE IS WS-HANDLE LINK TO SUBPROG"
        };
        CobolAstVisitor.EnrichDisplayProperties(stmt);
        Assert.Equal("WS-HANDLE", stmt.DisplayHandle);
        Assert.Equal("SUBPROG", stmt.DisplayLinkTo);
    }

    [Fact]
    public void EnrichDisplay_NullText_NoException()
    {
        var stmt = new DisplayStatement { Text = null };
        CobolAstVisitor.EnrichDisplayProperties(stmt);
        Assert.Null(stmt.DisplayLines);
    }

    // ── NormalizeAllProcedureStatements (integration) ─────────────

    [Fact]
    public void NormalizeAll_NullProcedure_NoException()
    {
        CobolAstVisitor.NormalizeAllProcedureStatements(null);
    }

    [Fact]
    public void NormalizeAll_EmptyProcedure_NoException()
    {
        var proc = new DivisionNode { Children = [] };
        CobolAstVisitor.NormalizeAllProcedureStatements(proc);
    }

    [Fact]
    public void NormalizeAll_WalksNestedIfEvaluatePerform()
    {
        // Build a procedure with nested statements
        var moveInIf = new MoveStatement
        {
            MoveFrom = "1",
            MoveTo = "WS-A",
            Text = "MOVE 1 TO WS-A\n           WHEN 901"
        };
        var displayInPerform = new DisplayStatement
        {
            Text = "DISPLAY WS-MSG UPON STANDARD-OUTPUT."
        };
        var acceptInEval = new AcceptStatement
        {
            Text = "ACCEPT WS-PATH FROM ENVIRONMENT \"MY_VAR\" END-ACCEPT"
        };

        var proc = new DivisionNode
        {
            Children =
            [
                new ParagraphNode
                {
                    Name = "TEST-PARA",
                    Statements =
                    [
                        new IfStatement
                        {
                            IfCondition = "WS-X > 0",
                            ThenStatements = [moveInIf],
                            Text = "IF WS-X > 0"
                        },
                        new PerformStatement
                        {
                            PerformInline = true,
                            PerformStatements = [displayInPerform],
                            Text = "PERFORM"
                        },
                        new EvaluateStatement
                        {
                            EvaluateSubject = "WS-CODE",
                            EvaluateWhenPhrases =
                            [
                                new EvaluateWhenClause
                                {
                                    WhenConditions = ["1"],
                                    Statements = [acceptInEval]
                                }
                            ],
                            Text = "EVALUATE WS-CODE"
                        }
                    ]
                }
            ]
        };

        CobolAstVisitor.NormalizeAllProcedureStatements(proc);

        // MOVE text truncated at WHEN
        Assert.Equal("MOVE 1 TO WS-A", moveInIf.Text);

        // DISPLAY enriched
        Assert.Equal("STANDARD-OUTPUT", displayInPerform.DisplayUpon);
        Assert.Equal(".", displayInPerform.DisplayBlockEnd);

        // ACCEPT enriched
        Assert.Equal("WS-PATH", acceptInEval.AcceptTarget);
        Assert.Equal("MY_VAR", acceptInEval.AcceptFromEnvironment);
        Assert.Equal("END-ACCEPT", acceptInEval.AcceptBlockEnd);
    }
}
