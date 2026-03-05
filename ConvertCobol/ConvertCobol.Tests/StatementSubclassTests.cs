using ConvertCobol.Models;
using ConvertCobol.Models.Statements;

namespace ConvertCobol.Tests;

public class StatementSubclassTests
{
    // ── StatementType defaults ───────────────────────────────────

    [Fact]
    public void MoveStatement_DefaultType_IsMOVE()
    {
        var s = new MoveStatement();
        Assert.Equal("MOVE", s.StatementType);
    }

    [Fact]
    public void PerformStatement_DefaultType_IsPERFORM()
    {
        var s = new PerformStatement();
        Assert.Equal("PERFORM", s.StatementType);
    }

    [Fact]
    public void CallStatement_DefaultType_IsCALL()
    {
        var s = new CallStatement();
        Assert.Equal("CALL", s.StatementType);
    }

    [Fact]
    public void IfStatement_DefaultType_IsIF()
    {
        var s = new IfStatement();
        Assert.Equal("IF", s.StatementType);
    }

    [Fact]
    public void EvaluateStatement_DefaultType_IsEVALUATE()
    {
        var s = new EvaluateStatement();
        Assert.Equal("EVALUATE", s.StatementType);
    }

    [Fact]
    public void DisplayStatement_DefaultType_IsDISPLAY()
    {
        var s = new DisplayStatement();
        Assert.Equal("DISPLAY", s.StatementType);
    }

    [Fact]
    public void AcceptStatement_DefaultType_IsACCEPT()
    {
        var s = new AcceptStatement();
        Assert.Equal("ACCEPT", s.StatementType);
    }

    [Fact]
    public void OpenStatement_DefaultType_IsOPEN()
    {
        var s = new OpenStatement();
        Assert.Equal("OPEN", s.StatementType);
    }

    [Fact]
    public void CloseStatement_DefaultType_IsCLOSE()
    {
        var s = new CloseStatement();
        Assert.Equal("CLOSE", s.StatementType);
    }

    [Fact]
    public void ReadStatement_DefaultType_IsREAD()
    {
        var s = new ReadStatement();
        Assert.Equal("READ", s.StatementType);
    }

    [Fact]
    public void WriteStatement_DefaultType_IsWRITE()
    {
        var s = new WriteStatement();
        Assert.Equal("WRITE", s.StatementType);
    }

    [Fact]
    public void RewriteStatement_DefaultType_IsREWRITE()
    {
        var s = new RewriteStatement();
        Assert.Equal("REWRITE", s.StatementType);
    }

    [Fact]
    public void StartStatement_DefaultType_IsSTART()
    {
        var s = new StartStatement();
        Assert.Equal("START", s.StatementType);
    }

    [Fact]
    public void InitializeStatement_DefaultType_IsINITIALIZE()
    {
        var s = new InitializeStatement();
        Assert.Equal("INITIALIZE", s.StatementType);
    }

    [Fact]
    public void StringStatement_DefaultType_IsSTRING()
    {
        var s = new StringStatement();
        Assert.Equal("STRING", s.StatementType);
    }

    [Fact]
    public void InspectStatement_DefaultType_IsINSPECT()
    {
        var s = new InspectStatement();
        Assert.Equal("INSPECT", s.StatementType);
    }

    [Fact]
    public void ComputeStatement_DefaultType_IsCOMPUTE()
    {
        var s = new ComputeStatement();
        Assert.Equal("COMPUTE", s.StatementType);
    }

    [Fact]
    public void SimpleStatement_CustomType_Preserved()
    {
        var s = new SimpleStatement("GOBACK");
        Assert.Equal("GOBACK", s.StatementType);

        var s2 = new SimpleStatement("STOP");
        Assert.Equal("STOP", s2.StatementType);

        var s3 = new SimpleStatement();
        Assert.Equal("", s3.StatementType);
    }

    // ── Property completeness ────────────────────────────────────

    [Fact]
    public void IfStatement_AllProperties_Accessible()
    {
        var s = new IfStatement
        {
            IfCondition = "WS-A > 0",
            IfThenText = "THEN block",
            IfElseText = "ELSE block",
            ThenStatements = [new MoveStatement { MoveFrom = "1", MoveTo = "WS-A" }],
            ElseStatements = [new SimpleStatement("CONTINUE")],
            IfBlockEnd = "END-IF",
            IfThenComments = ["*> comment line"],
            Text = "IF WS-A > 0"
        };

        Assert.Equal("WS-A > 0", s.IfCondition);
        Assert.Equal("THEN block", s.IfThenText);
        Assert.Equal("ELSE block", s.IfElseText);
        Assert.Single(s.ThenStatements);
        Assert.Single(s.ElseStatements);
        Assert.Equal("END-IF", s.IfBlockEnd);
        Assert.Single(s.IfThenComments);
    }

    [Fact]
    public void EvaluateStatement_WhenPhrases_MutableList()
    {
        var s = new EvaluateStatement
        {
            EvaluateSubject = "WS-CODE",
            EvaluateWhenPhrases =
            [
                new EvaluateWhenClause
                {
                    WhenConditions = ["1", "2"],
                    Statements = [new SimpleStatement("CONTINUE")]
                }
            ],
            EvaluateWhenOtherStatements = [new SimpleStatement("STOP")],
            EvaluateBlockEnd = "END-EVALUATE"
        };

        Assert.Equal("WS-CODE", s.EvaluateSubject);
        Assert.Single(s.EvaluateWhenPhrases);
        Assert.Equal(2, s.EvaluateWhenPhrases[0].WhenConditions!.Count);
        Assert.Single(s.EvaluateWhenOtherStatements);
        Assert.Equal("END-EVALUATE", s.EvaluateBlockEnd);

        // Mutable — can add more
        s.EvaluateWhenPhrases.Add(new EvaluateWhenClause { WhenConditions = ["3"] });
        Assert.Equal(2, s.EvaluateWhenPhrases.Count);
    }

    [Fact]
    public void PerformStatement_PerformStatements_NestedList()
    {
        var s = new PerformStatement
        {
            PerformTarget = "MAIN-LOGIC",
            PerformThru = "MAIN-EXIT",
            PerformInline = true,
            PerformType = "UNTIL",
            PerformUntilCondition = "WS-EOF = 1",
            PerformStatements =
            [
                new MoveStatement { MoveFrom = "1", MoveTo = "WS-FLAG" },
                new SimpleStatement("CONTINUE")
            ],
            PerformBlockEnd = "END-PERFORM"
        };

        Assert.Equal("MAIN-LOGIC", s.PerformTarget);
        Assert.Equal("MAIN-EXIT", s.PerformThru);
        Assert.True(s.PerformInline);
        Assert.Equal("UNTIL", s.PerformType);
        Assert.Equal("WS-EOF = 1", s.PerformUntilCondition);
        Assert.Equal(2, s.PerformStatements!.Count);
        Assert.Equal("END-PERFORM", s.PerformBlockEnd);
    }

    [Fact]
    public void DisplayStatement_AllDisplayProperties_Settable()
    {
        var s = new DisplayStatement
        {
            DisplayOperands = new Dictionary<string, string> { ["WS-MSG"] = "literal" },
            DisplayUpon = "STANDARD-OUTPUT",
            DisplayAt = "LINE 5 COL 10",
            DisplayWith = "NO ADVANCING",
            DisplayBlockEnd = "END-DISPLAY",
            DisplayType = "WINDOW",
            DisplayWindow = "INITIAL",
            DisplayLines = "24",
            DisplaySize = "80",
            DisplayCellHeight = "12",
            DisplayCellWidth = "8",
            DisplayColor = "7",
            DisplayLabelOffset = "0",
            DisplayLinkTo = "PROGRAM-B",
            DisplayNoScroll = true,
            DisplayTitle = "Main Window",
            DisplayTitleBar = true,
            DisplayNoWrap = true,
            DisplayHandle = "WS-WIN-HANDLE",
            Text = "DISPLAY WS-MSG UPON STANDARD-OUTPUT"
        };

        Assert.Equal("STANDARD-OUTPUT", s.DisplayUpon);
        Assert.Equal("LINE 5 COL 10", s.DisplayAt);
        Assert.Equal("NO ADVANCING", s.DisplayWith);
        Assert.Equal("END-DISPLAY", s.DisplayBlockEnd);
        Assert.Equal("WINDOW", s.DisplayType);
        Assert.Equal("INITIAL", s.DisplayWindow);
        Assert.Equal("24", s.DisplayLines);
        Assert.Equal("80", s.DisplaySize);
        Assert.Equal("12", s.DisplayCellHeight);
        Assert.Equal("8", s.DisplayCellWidth);
        Assert.Equal("7", s.DisplayColor);
        Assert.Equal("0", s.DisplayLabelOffset);
        Assert.Equal("PROGRAM-B", s.DisplayLinkTo);
        Assert.True(s.DisplayNoScroll);
        Assert.Equal("Main Window", s.DisplayTitle);
        Assert.True(s.DisplayTitleBar);
        Assert.True(s.DisplayNoWrap);
        Assert.Equal("WS-WIN-HANDLE", s.DisplayHandle);
        Assert.Single(s.DisplayOperands);
    }

    [Fact]
    public void MoveStatement_Properties_Settable()
    {
        var s = new MoveStatement
        {
            MoveFrom = "SPACES",
            MoveTo = "WS-BUFFER",
            Text = "MOVE SPACES TO WS-BUFFER"
        };

        Assert.Equal("SPACES", s.MoveFrom);
        Assert.Equal("WS-BUFFER", s.MoveTo);
        Assert.Equal("MOVE SPACES TO WS-BUFFER", s.Text);
    }

    [Fact]
    public void CallStatement_WithArgs_Settable()
    {
        var s = new CallStatement
        {
            CallTarget = "\"PROGRAM-X\"",
            CallArgs = ["WS-A", "WS-B", "WS-C"]
        };

        Assert.Equal("\"PROGRAM-X\"", s.CallTarget);
        Assert.Equal(3, s.CallArgs!.Count);
    }

    [Fact]
    public void ReadStatement_AllProperties_Settable()
    {
        var s = new ReadStatement
        {
            ReadTarget = "INPUT-FILE",
            ReadNext = true,
            ReadInto = "WS-RECORD",
            ReadKey = "WS-KEY"
        };

        Assert.Equal("INPUT-FILE", s.ReadTarget);
        Assert.True(s.ReadNext);
        Assert.Equal("WS-RECORD", s.ReadInto);
        Assert.Equal("WS-KEY", s.ReadKey);
    }

    [Fact]
    public void OpenStatement_Properties_Settable()
    {
        var s = new OpenStatement
        {
            OpenType = "INPUT",
            OpenTargets = ["FILE-A", "FILE-B"]
        };

        Assert.Equal("INPUT", s.OpenType);
        Assert.Equal(2, s.OpenTargets!.Count);
    }

    [Fact]
    public void StartStatement_Properties_Settable()
    {
        var s = new StartStatement
        {
            StartTarget = "IDX-FILE",
            StartKeyOperator = ">=",
            StartKeyDataName = "WS-KEY"
        };

        Assert.Equal("IDX-FILE", s.StartTarget);
        Assert.Equal(">=", s.StartKeyOperator);
        Assert.Equal("WS-KEY", s.StartKeyDataName);
    }

    [Fact]
    public void StringStatement_Properties_Settable()
    {
        var s = new StringStatement
        {
            StringInto = "WS-OUTPUT",
            StringPointer = "WS-PTR"
        };

        Assert.Equal("WS-OUTPUT", s.StringInto);
        Assert.Equal("WS-PTR", s.StringPointer);
    }

    [Fact]
    public void InspectStatement_Properties_Settable()
    {
        var s = new InspectStatement
        {
            InspectTarget = "WS-DATA",
            InspectTallying = "WS-COUNT",
            InspectTallyingFor = "ALL SPACES"
        };

        Assert.Equal("WS-DATA", s.InspectTarget);
        Assert.Equal("WS-COUNT", s.InspectTallying);
        Assert.Equal("ALL SPACES", s.InspectTallyingFor);
    }

    [Fact]
    public void InitializeStatement_Targets_Settable()
    {
        var s = new InitializeStatement
        {
            InitializeTargets = ["WS-REC-A", "WS-REC-B"]
        };

        Assert.Equal(2, s.InitializeTargets!.Count);
    }

    [Fact]
    public void CloseStatement_Targets_Settable()
    {
        var s = new CloseStatement
        {
            CloseTargets = ["FILE-A", "FILE-B", "FILE-C"]
        };

        Assert.Equal(3, s.CloseTargets!.Count);
    }
}
