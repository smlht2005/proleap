using System.Text.Json;
using System.Text.Json.Serialization;
using ConvertCobol.Converters;

namespace ConvertCobol.Tests;

public class BaselineTests
{
    private static readonly JsonSerializerOptions JsonOptions = new()
    {
        WriteIndented = true,
        PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
        DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull,
        Converters = { new StatementNodeJsonConverter() }
    };

    [Fact]
    public void ProgramAst_CanSerializeAndDeserialize()
    {
        var ast = new ProgramAst
        {
            ProgramId = "TEST-PROGRAM",
            FdCount = 2,
            DataItem01Count = 5,
            TotalDataItems = 20,
            ParagraphCount = 3,
            StatementCount = 10
        };

        var json = JsonSerializer.Serialize(ast, JsonOptions);
        Assert.Contains("\"programId\"", json);
        Assert.Contains("TEST-PROGRAM", json);

        var deserialized = JsonSerializer.Deserialize<ProgramAst>(json, JsonOptions);
        Assert.NotNull(deserialized);
        Assert.Equal("TEST-PROGRAM", deserialized.ProgramId);
        Assert.Equal(2, deserialized.FdCount);
        Assert.Equal(10, deserialized.StatementCount);
    }

    [Fact]
    public void StatementNode_CanSerializeWithType()
    {
        var stmt = new MoveStatement
        {
            Text = "MOVE A TO B",
            MoveFrom = "A",
            MoveTo = "B"
        };

        var json = JsonSerializer.Serialize(stmt, JsonOptions);
        Assert.Contains("\"statementType\"", json);
        Assert.Contains("MOVE", json);
        Assert.Contains("\"moveFrom\"", json);
    }

    [Fact]
    public void ParagraphNode_CanHoldStatements()
    {
        var para = new ParagraphNode
        {
            Name = "MAIN-LOGIC",
            IsSection = false,
            Statements =
            [
                new MoveStatement { Text = "MOVE X TO Y", MoveFrom = "X", MoveTo = "Y" },
                new PerformStatement { Text = "PERFORM SUB-ROUTINE", PerformTarget = "SUB-ROUTINE" },
                new CallStatement { Text = "CALL \"MYPROG\"", CallTarget = "MYPROG" }
            ]
        };

        Assert.Equal(3, para.Statements.Count);
        Assert.Equal("MOVE", para.Statements[0].StatementType);
        Assert.Equal("PERFORM", para.Statements[1].StatementType);
        Assert.Equal("CALL", para.Statements[2].StatementType);
    }

    [Fact]
    public void DataItemNode_HasEmptyChildrenByDefault()
    {
        var item = new DataItemNode
        {
            Level = 1,
            Name = "WS-RECORD",
            PicClause = null
        };

        Assert.Empty(item.Children);
    }

    [Fact]
    public void DivisionNode_CanHoldMixedChildren()
    {
        var division = new DivisionNode
        {
            DivisionName = "PROCEDURE",
            Children =
            [
                new ParagraphNode { Name = "PARA-1", Statements = [] },
                new ParagraphNode { Name = "PARA-2", Statements = [] }
            ]
        };

        Assert.Equal(2, division.Children.Count);
        Assert.All(division.Children, c => Assert.IsType<ParagraphNode>(c));
    }
}
