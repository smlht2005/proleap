using ConvertCobol.CodeGen;
using ConvertCobol.Models;
using ConvertCobol.Models.Statements;

namespace ConvertCobol.Tests;

public class EmitterTests
{
    private readonly ProcedureToCSharpEmitter _emitter = new();

    // ── TranslateCondition ──────────────────────────────────────

    [Theory]
    [InlineData("WS-STATUS EQUAL TO 0", "WS_STATUS == 0")]
    [InlineData("WS-STATUS EQUALS 0", "WS_STATUS == 0")]
    [InlineData("WS-STATUS EQUAL 0", "WS_STATUS == 0")]
    [InlineData("WS-STATUS NOT EQUAL TO 0", "WS_STATUS != 0")]
    [InlineData("WS-STATUS NOT EQUAL 0", "WS_STATUS != 0")]
    public void TranslateCondition_EqualOperators(string cobol, string expected)
    {
        var result = ProcedureToCSharpEmitter.TranslateCondition(cobol);
        Assert.Equal(expected, result);
    }

    [Theory]
    [InlineData("WS-AMT GREATER THAN 100", "WS_AMT > 100")]
    [InlineData("WS-AMT LESS THAN 100", "WS_AMT < 100")]
    [InlineData("WS-AMT GREATER THAN OR EQUAL TO 100", "WS_AMT >= 100")]
    [InlineData("WS-AMT LESS THAN OR EQUAL TO 100", "WS_AMT <= 100")]
    [InlineData("WS-AMT NOT LESS THAN 100", "WS_AMT >= 100")]
    [InlineData("WS-AMT NOT GREATER THAN 100", "WS_AMT <= 100")]
    public void TranslateCondition_ComparisonOperators(string cobol, string expected)
    {
        var result = ProcedureToCSharpEmitter.TranslateCondition(cobol);
        Assert.Equal(expected, result);
    }

    [Theory]
    [InlineData("A AND B", "A && B")]
    [InlineData("A OR B", "A || B")]
    [InlineData("NOT A", "! A")]
    public void TranslateCondition_LogicalOperators(string cobol, string expected)
    {
        var result = ProcedureToCSharpEmitter.TranslateCondition(cobol);
        Assert.Equal(expected, result);
    }

    [Fact]
    public void TranslateCondition_FigurativeConstants()
    {
        Assert.Contains("\" \"", ProcedureToCSharpEmitter.TranslateCondition("WS-NAME EQUAL SPACES"));
        Assert.Contains("0", ProcedureToCSharpEmitter.TranslateCondition("WS-COUNT EQUAL ZEROS"));
        Assert.Contains("0", ProcedureToCSharpEmitter.TranslateCondition("WS-COUNT EQUAL ZEROES"));
    }

    [Fact]
    public void TranslateCondition_HyphenatedIdentifiers()
    {
        var result = ProcedureToCSharpEmitter.TranslateCondition("WS-MY-VAR EQUAL TO WS-OTHER-VAR");
        Assert.Contains("WS_MY_VAR", result);
        Assert.Contains("WS_OTHER_VAR", result);
        Assert.DoesNotContain("-", result);
    }

    [Fact]
    public void TranslateCondition_NullOrEmpty_ReturnsTodoComment()
    {
        Assert.Contains("TODO", ProcedureToCSharpEmitter.TranslateCondition(null));
        Assert.Contains("TODO", ProcedureToCSharpEmitter.TranslateCondition(""));
        Assert.Contains("TODO", ProcedureToCSharpEmitter.TranslateCondition("   "));
    }

    // ── ParagraphNameToCSharpMethod ─────────────────────────────

    [Theory]
    [InlineData("MAIN-LOGIC", "MAIN_LOGIC")]
    [InlineData("100-INIT", "100_INIT")]
    [InlineData("SIMPLE", "SIMPLE")]
    public void ParagraphNameToCSharpMethod_ReplacesHyphens(string cobol, string expected)
    {
        Assert.Equal(expected, ProcedureToCSharpEmitter.ParagraphNameToCSharpMethod(cobol));
    }

    [Theory]
    [InlineData(null)]
    [InlineData("")]
    [InlineData("   ")]
    public void ParagraphNameToCSharpMethod_NullOrEmpty_ReturnsDefault(string? input)
    {
        Assert.Equal("UnnamedParagraph", ProcedureToCSharpEmitter.ParagraphNameToCSharpMethod(input!));
    }

    // ── EmitProcedureDivision ───────────────────────────────────

    [Fact]
    public void EmitProcedureDivision_NullProcedure_ReturnsComment()
    {
        var result = _emitter.EmitProcedureDivision(null);
        Assert.Equal("// No procedure division", result);
    }

    [Fact]
    public void EmitProcedureDivision_EmptyParagraph_GeneratesEmptyMethod()
    {
        var proc = new DivisionNode { DivisionName = "PROCEDURE" };
        proc.Children.Add(new ParagraphNode { Name = "MAIN-LOGIC" });

        var result = _emitter.EmitProcedureDivision(proc);
        Assert.Contains("private void MAIN_LOGIC()", result);
        Assert.Contains("{", result);
        Assert.Contains("}", result);
    }

    // ── MOVE emission ───────────────────────────────────────────

    [Fact]
    public void Emit_Move_SingleTarget()
    {
        var result = EmitSingleStatement(new MoveStatement
        {
            MoveFrom = "WS-VALUE",
            MoveTo = "WS-TARGET"
        });
        Assert.Contains("WS_TARGET = WS_VALUE;", result);
    }

    [Fact]
    public void Emit_Move_MultipleTargets()
    {
        var result = EmitSingleStatement(new MoveStatement
        {
            MoveFrom = "ZEROS",
            MoveTo = "WS-A, WS-B"
        });
        Assert.Contains("WS_A = ZEROS;", result);
        Assert.Contains("WS_B = ZEROS;", result);
    }

    // ── PERFORM emission ────────────────────────────────────────

    [Fact]
    public void Emit_PerformParagraph_SimpleCall()
    {
        var result = EmitSingleStatement(new PerformStatement
        {
            PerformTarget = "100-INIT",
            PerformInline = false
        });
        Assert.Contains("100_INIT();", result);
    }

    [Fact]
    public void Emit_PerformParagraph_WithThru()
    {
        var result = EmitSingleStatement(new PerformStatement
        {
            PerformTarget = "100-INIT",
            PerformThru = "100-INIT-EXIT",
            PerformInline = false
        });
        Assert.Contains("PERFORM 100-INIT THRU 100-INIT-EXIT", result);
        Assert.Contains("100_INIT();", result);
    }

    [Fact]
    public void Emit_InlinePerform_Until()
    {
        var result = EmitSingleStatement(new PerformStatement
        {
            PerformInline = true,
            PerformType = "UNTIL",
            PerformUntilCondition = "WS-EOF EQUAL 'Y'",
            PerformStatements = new List<StatementNode>
            {
                new MoveStatement { MoveFrom = "1", MoveTo = "WS-COUNT" }
            }
        });
        Assert.Contains("while (!(", result);
        Assert.Contains("WS_COUNT = 1;", result);
    }

    [Fact]
    public void Emit_InlinePerform_Varying()
    {
        var result = EmitSingleStatement(new PerformStatement
        {
            PerformInline = true,
            PerformType = "VARYING"
        });
        Assert.Contains("while (true)", result);
        Assert.Contains("TODO: translate VARYING", result);
    }

    [Fact]
    public void Emit_InlinePerform_Times()
    {
        var result = EmitSingleStatement(new PerformStatement
        {
            PerformInline = true,
            PerformType = "TIMES"
        });
        Assert.Contains("for (int i = 0;", result);
    }

    // ── CALL emission ───────────────────────────────────────────

    [Fact]
    public void Emit_Call_WithArgs()
    {
        var result = EmitSingleStatement(new CallStatement
        {
            CallTarget = "SUB-PROGRAM",
            CallArgs = new List<string> { "WS-PARAM-1", "WS-PARAM-2" }
        });
        Assert.Contains("SUB_PROGRAM(WS_PARAM_1, WS_PARAM_2);", result);
    }

    [Fact]
    public void Emit_Call_NoArgs()
    {
        var result = EmitSingleStatement(new CallStatement
        {
            CallTarget = "UTILITY"
        });
        Assert.Contains("UTILITY();", result);
    }

    // ── EVALUATE → switch emission ──────────────────────────────

    [Fact]
    public void Emit_Evaluate_WithSubject_GeneratesSwitch()
    {
        var eval = new EvaluateStatement
        {
            EvaluateSubject = "WS-STATUS",
            EvaluateWhenPhrases = new List<EvaluateWhenClause>
            {
                new()
                {
                    WhenConditions = new List<string> { "1" },
                    Statements = new List<StatementNode>
                    {
                        new MoveStatement { MoveFrom = "\"ACTIVE\"", MoveTo = "WS-DESC" }
                    }
                },
                new()
                {
                    WhenConditions = new List<string> { "2" },
                    Statements = new List<StatementNode>
                    {
                        new MoveStatement { MoveFrom = "\"INACTIVE\"", MoveTo = "WS-DESC" }
                    }
                }
            },
            EvaluateWhenOtherStatements = new List<StatementNode>
            {
                new MoveStatement { MoveFrom = "\"UNKNOWN\"", MoveTo = "WS-DESC" }
            }
        };

        var result = EmitSingleStatement(eval);

        Assert.Contains("switch (WS_STATUS)", result);
        Assert.Contains("case 1:", result);
        Assert.Contains("case 2:", result);
        Assert.Contains("WS_DESC = \"ACTIVE\";", result);
        Assert.Contains("WS_DESC = \"INACTIVE\";", result);
        Assert.Contains("default:", result);
        Assert.Contains("WS_DESC = \"UNKNOWN\";", result);
        // Each case should have a break
        Assert.True(CountOccurrences(result, "break;") >= 3);
    }

    [Fact]
    public void Emit_Evaluate_MultipleWhenConditions_GeneratesMultipleCaseLabels()
    {
        var eval = new EvaluateStatement
        {
            EvaluateSubject = "WS-CODE",
            EvaluateWhenPhrases = new List<EvaluateWhenClause>
            {
                new()
                {
                    WhenConditions = new List<string> { "1", "2", "3" },
                    Statements = new List<StatementNode>
                    {
                        new SimpleStatement("CONTINUE") { Text = "CONTINUE" }
                    }
                }
            }
        };

        var result = EmitSingleStatement(eval);
        Assert.Contains("case 1:", result);
        Assert.Contains("case 2:", result);
        Assert.Contains("case 3:", result);
    }

    // ── EVALUATE TRUE → if-else emission ────────────────────────

    [Fact]
    public void Emit_EvaluateTrue_GeneratesIfElseChain()
    {
        var eval = new EvaluateStatement
        {
            EvaluateSubject = "TRUE",
            EvaluateWhenPhrases = new List<EvaluateWhenClause>
            {
                new()
                {
                    WhenConditions = new List<string> { "WS-STATUS EQUAL 1" },
                    Statements = new List<StatementNode>
                    {
                        new MoveStatement { MoveFrom = "\"A\"", MoveTo = "WS-OUT" }
                    }
                },
                new()
                {
                    WhenConditions = new List<string> { "WS-STATUS EQUAL 2" },
                    Statements = new List<StatementNode>
                    {
                        new MoveStatement { MoveFrom = "\"B\"", MoveTo = "WS-OUT" }
                    }
                }
            },
            EvaluateWhenOtherStatements = new List<StatementNode>
            {
                new MoveStatement { MoveFrom = "\"C\"", MoveTo = "WS-OUT" }
            }
        };

        var result = EmitSingleStatement(eval);

        Assert.Contains("if (", result);
        Assert.Contains("else if (", result);
        Assert.Contains("else", result);
        Assert.DoesNotContain("switch", result);
        // Conditions should be translated
        Assert.Contains("== 1", result);
        Assert.Contains("== 2", result);
    }

    [Fact]
    public void Emit_EvaluateTrue_EmptyPhrases_GeneratesComment()
    {
        var eval = new EvaluateStatement
        {
            EvaluateSubject = "TRUE",
            EvaluateWhenPhrases = new List<EvaluateWhenClause>()
        };

        var result = EmitSingleStatement(eval);
        Assert.Contains("EVALUATE TRUE (empty)", result);
    }

    [Fact]
    public void Emit_EvaluateTrue_NullSubject_TreatedAsTrue()
    {
        var eval = new EvaluateStatement
        {
            EvaluateSubject = null,
            EvaluateWhenPhrases = new List<EvaluateWhenClause>
            {
                new()
                {
                    WhenConditions = new List<string> { "WS-FLAG EQUAL 'Y'" },
                    Statements = new List<StatementNode>
                    {
                        new SimpleStatement("CONTINUE") { Text = "CONTINUE" }
                    }
                }
            }
        };

        var result = EmitSingleStatement(eval);
        // Should generate if instead of switch
        Assert.Contains("if (", result);
        Assert.DoesNotContain("switch", result);
    }

    // ── IF → if-else emission ───────────────────────────────────

    [Fact]
    public void Emit_If_ThenOnly()
    {
        var ifStmt = new IfStatement
        {
            IfCondition = "WS-STATUS EQUAL 0",
            ThenStatements = new List<StatementNode>
            {
                new MoveStatement { MoveFrom = "\"OK\"", MoveTo = "WS-MSG" }
            }
        };

        var result = EmitSingleStatement(ifStmt);
        Assert.Contains("if (WS_STATUS == 0)", result);
        Assert.Contains("WS_MSG = \"OK\";", result);
        Assert.DoesNotContain("else", result);
    }

    [Fact]
    public void Emit_If_ThenElse()
    {
        var ifStmt = new IfStatement
        {
            IfCondition = "WS-COUNT GREATER THAN 10",
            ThenStatements = new List<StatementNode>
            {
                new MoveStatement { MoveFrom = "\"HIGH\"", MoveTo = "WS-LEVEL" }
            },
            ElseStatements = new List<StatementNode>
            {
                new MoveStatement { MoveFrom = "\"LOW\"", MoveTo = "WS-LEVEL" }
            }
        };

        var result = EmitSingleStatement(ifStmt);
        Assert.Contains("if (WS_COUNT > 10)", result);
        Assert.Contains("WS_LEVEL = \"HIGH\";", result);
        Assert.Contains("else", result);
        Assert.Contains("WS_LEVEL = \"LOW\";", result);
    }

    [Fact]
    public void Emit_If_MissingCondition_FallsBackToTodo()
    {
        var ifStmt = new IfStatement
        {
            IfCondition = null,
            ThenStatements = new List<StatementNode>
            {
                new SimpleStatement("CONTINUE") { Text = "CONTINUE" }
            }
        };

        var result = EmitSingleStatement(ifStmt);
        Assert.Contains("if (true /* TODO: condition */)", result);
    }

    [Fact]
    public void Emit_If_WithTextFallback()
    {
        var ifStmt = new IfStatement
        {
            IfCondition = "WS-FLAG EQUAL 'Y'",
            IfThenText = "MOVE 1 TO WS-OUT",
            IfElseText = "MOVE 2 TO WS-OUT"
        };

        var result = EmitSingleStatement(ifStmt);
        Assert.Contains("if (", result);
        Assert.Contains("THEN:", result);
        Assert.Contains("else", result);
        Assert.Contains("ELSE:", result);
    }

    // ── DISPLAY / ACCEPT → TODO comment ─────────────────────────

    [Fact]
    public void Emit_Display_GeneratesTodoComment()
    {
        var result = EmitSingleStatement(new DisplayStatement
        {
            Text = "DISPLAY WS-MESSAGE"
        });
        Assert.Contains("// COBOL: DISPLAY WS-MESSAGE", result);
        Assert.Contains("// TODO: DISPLAY -> C# UI/IO", result);
    }

    [Fact]
    public void Emit_Accept_GeneratesTodoComment()
    {
        var result = EmitSingleStatement(new AcceptStatement
        {
            Text = "ACCEPT WS-INPUT"
        });
        Assert.Contains("// COBOL: ACCEPT WS-INPUT", result);
        Assert.Contains("// TODO: ACCEPT -> C# UI/IO", result);
    }

    // ── STOP / GOBACK → return ──────────────────────────────────

    [Fact]
    public void Emit_StopRun_GeneratesReturn()
    {
        var result = EmitSingleStatement(new SimpleStatement("STOP") { Text = "STOP RUN" });
        Assert.Contains("return;", result);
    }

    [Fact]
    public void Emit_Goback_GeneratesReturn()
    {
        var result = EmitSingleStatement(new SimpleStatement("GOBACK") { Text = "GOBACK" });
        Assert.Contains("return;", result);
    }

    // ── File I/O statements → TODO ──────────────────────────────

    [Fact]
    public void Emit_FileIoStatements_GenerateTodoComments()
    {
        var statements = new StatementNode[]
        {
            new OpenStatement { Text = "OPEN INPUT MY-FILE" },
            new CloseStatement { Text = "CLOSE MY-FILE" },
            new ReadStatement { Text = "READ MY-FILE" },
            new WriteStatement { Text = "WRITE MY-RECORD" },
            new RewriteStatement { Text = "REWRITE MY-RECORD" },
            new StartStatement { Text = "START MY-FILE" },
            new InitializeStatement { Text = "INITIALIZE WS-AREA" },
            new ComputeStatement { Text = "COMPUTE WS-A = WS-B + 1" },
            new StringStatement { Text = "STRING A B INTO C" },
            new InspectStatement { Text = "INSPECT WS-DATA TALLYING WS-CT FOR ALL 'X'" }
        };

        foreach (var stmt in statements)
        {
            var result = EmitSingleStatement(stmt);
            Assert.Contains("// COBOL:", result);
            Assert.Contains("// TODO:", result);
        }
    }

    // ── Nested structure ────────────────────────────────────────

    [Fact]
    public void Emit_NestedIfInsideEvaluate()
    {
        var eval = new EvaluateStatement
        {
            EvaluateSubject = "WS-TYPE",
            EvaluateWhenPhrases = new List<EvaluateWhenClause>
            {
                new()
                {
                    WhenConditions = new List<string> { "1" },
                    Statements = new List<StatementNode>
                    {
                        new IfStatement
                        {
                            IfCondition = "WS-SUB EQUAL 0",
                            ThenStatements = new List<StatementNode>
                            {
                                new MoveStatement { MoveFrom = "\"FOUND\"", MoveTo = "WS-RESULT" }
                            }
                        }
                    }
                }
            }
        };

        var result = EmitSingleStatement(eval);
        Assert.Contains("switch (WS_TYPE)", result);
        Assert.Contains("case 1:", result);
        Assert.Contains("if (WS_SUB == 0)", result);
        Assert.Contains("WS_RESULT = \"FOUND\";", result);
    }

    // ── EVALUATE with ZERO/SPACE figurative constants ───────────

    [Fact]
    public void Emit_Evaluate_FigurativeConstants()
    {
        var eval = new EvaluateStatement
        {
            EvaluateSubject = "WS-VAL",
            EvaluateWhenPhrases = new List<EvaluateWhenClause>
            {
                new()
                {
                    WhenConditions = new List<string> { "ZERO" },
                    Statements = new List<StatementNode>
                    {
                        new SimpleStatement("CONTINUE") { Text = "CONTINUE" }
                    }
                },
                new()
                {
                    WhenConditions = new List<string> { "SPACES" },
                    Statements = new List<StatementNode>
                    {
                        new SimpleStatement("CONTINUE") { Text = "CONTINUE" }
                    }
                }
            }
        };

        var result = EmitSingleStatement(eval);
        Assert.Contains("case 0:", result);
        Assert.Contains("case \" \":", result);
    }

    // ── Helper ──────────────────────────────────────────────────

    private string EmitSingleStatement(StatementNode stmt)
    {
        var proc = new DivisionNode { DivisionName = "PROCEDURE" };
        var para = new ParagraphNode { Name = "TEST-PARA" };
        para.Statements.Add(stmt);
        proc.Children.Add(para);
        return _emitter.EmitProcedureDivision(proc);
    }

    private static int CountOccurrences(string text, string pattern)
    {
        int count = 0, index = 0;
        while ((index = text.IndexOf(pattern, index, StringComparison.Ordinal)) != -1)
        {
            count++;
            index += pattern.Length;
        }
        return count;
    }
}
