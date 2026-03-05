using ConvertCobol.Models;
using ConvertCobol.Visitors;

namespace ConvertCobol.Tests;

public class DataItemHierarchyTests
{
    // ── Null / Empty ──────────────────────────────────────────

    [Fact]
    public void BuildHierarchy_Null_ReturnsEmpty()
    {
        var result = DataItemHierarchyBuilder.BuildHierarchy(null!);
        Assert.Empty(result);
    }

    [Fact]
    public void BuildHierarchy_Empty_ReturnsEmpty()
    {
        var result = DataItemHierarchyBuilder.BuildHierarchy([]);
        Assert.Empty(result);
    }

    // ── Level 01 top-level ────────────────────────────────────

    [Fact]
    public void BuildHierarchy_SingleLevel01_StaysTopLevel()
    {
        var items = new List<AstNode>
        {
            new DataItemNode { Level = 1, Name = "WS-RECORD" }
        };
        var result = DataItemHierarchyBuilder.BuildHierarchy(items);
        Assert.Single(result);
        Assert.Equal("WS-RECORD", ((DataItemNode)result[0]).Name);
    }

    [Fact]
    public void BuildHierarchy_MultipleLevel01_AllTopLevel()
    {
        var items = new List<AstNode>
        {
            new DataItemNode { Level = 1, Name = "REC-A" },
            new DataItemNode { Level = 1, Name = "REC-B" }
        };
        var result = DataItemHierarchyBuilder.BuildHierarchy(items);
        Assert.Equal(2, result.Count);
    }

    // ── Level 77 top-level, no children ───────────────────────

    [Fact]
    public void BuildHierarchy_Level77_TopLevelNoChildren()
    {
        var items = new List<AstNode>
        {
            new DataItemNode { Level = 77, Name = "WS-COUNTER" },
            new DataItemNode { Level = 77, Name = "WS-FLAG" }
        };
        var result = DataItemHierarchyBuilder.BuildHierarchy(items);
        Assert.Equal(2, result.Count);
        Assert.Empty(((DataItemNode)result[0]).Children);
        Assert.Empty(((DataItemNode)result[1]).Children);
    }

    // ── Basic 01/05/10 nesting ────────────────────────────────

    [Fact]
    public void BuildHierarchy_01_05_10_NestedCorrectly()
    {
        var items = new List<AstNode>
        {
            new DataItemNode { Level = 1, Name = "WS-RECORD" },
            new DataItemNode { Level = 5, Name = "WS-FIELD-A" },
            new DataItemNode { Level = 10, Name = "WS-SUB-A" },
            new DataItemNode { Level = 10, Name = "WS-SUB-B" },
            new DataItemNode { Level = 5, Name = "WS-FIELD-B" }
        };
        var result = DataItemHierarchyBuilder.BuildHierarchy(items);

        // Only 01 at top
        Assert.Single(result);
        var record = (DataItemNode)result[0];
        Assert.Equal("WS-RECORD", record.Name);

        // 05 items are children of 01
        Assert.Equal(2, record.Children.Count);
        Assert.Equal("WS-FIELD-A", record.Children[0].Name);
        Assert.Equal("WS-FIELD-B", record.Children[1].Name);

        // 10 items are children of first 05
        Assert.Equal(2, record.Children[0].Children.Count);
        Assert.Equal("WS-SUB-A", record.Children[0].Children[0].Name);
        Assert.Equal("WS-SUB-B", record.Children[0].Children[1].Name);

        // Second 05 has no children
        Assert.Empty(record.Children[1].Children);
    }

    // ── Level 88 condition name ───────────────────────────────

    [Fact]
    public void BuildHierarchy_Level88_AttachedToParent()
    {
        var items = new List<AstNode>
        {
            new DataItemNode { Level = 1, Name = "WS-REC" },
            new DataItemNode { Level = 5, Name = "WS-STATUS" },
            new DataItemNode { Level = 88, Name = "WS-ACTIVE", ValueClause = "1" },
            new DataItemNode { Level = 88, Name = "WS-INACTIVE", ValueClause = "0" }
        };
        var result = DataItemHierarchyBuilder.BuildHierarchy(items);

        Assert.Single(result);
        var record = (DataItemNode)result[0];
        Assert.Single(record.Children); // WS-STATUS
        var status = record.Children[0];
        Assert.Equal(2, status.Children.Count);
        Assert.Equal("WS-ACTIVE", status.Children[0].Name);
        Assert.Equal("WS-INACTIVE", status.Children[1].Name);
    }

    [Fact]
    public void BuildHierarchy_Level88_NoParent_GoesTopLevel()
    {
        var items = new List<AstNode>
        {
            new DataItemNode { Level = 88, Name = "ORPHAN-COND", ValueClause = "1" }
        };
        var result = DataItemHierarchyBuilder.BuildHierarchy(items);
        Assert.Single(result);
        Assert.Equal("ORPHAN-COND", ((DataItemNode)result[0]).Name);
    }

    // ── Level 78 constant ─────────────────────────────────────

    [Fact]
    public void BuildHierarchy_Level78_AttachedToParent()
    {
        var items = new List<AstNode>
        {
            new DataItemNode { Level = 1, Name = "WS-REC" },
            new DataItemNode { Level = 5, Name = "WS-MAX" },
            new DataItemNode { Level = 78, Name = "WS-CONST", ValueClause = "100" }
        };
        var result = DataItemHierarchyBuilder.BuildHierarchy(items);

        var rec = (DataItemNode)result[0];
        var max = rec.Children[0];
        Assert.Single(max.Children);
        Assert.Equal("WS-CONST", max.Children[0].Name);
    }

    // ── Level 66 RENAMES ──────────────────────────────────────

    [Fact]
    public void BuildHierarchy_Level66_TopLevel()
    {
        var items = new List<AstNode>
        {
            new DataItemNode { Level = 1, Name = "WS-REC" },
            new DataItemNode { Level = 5, Name = "WS-A" },
            new DataItemNode { Level = 66, Name = "WS-RENAME" }
        };
        var result = DataItemHierarchyBuilder.BuildHierarchy(items);

        Assert.Equal(2, result.Count); // WS-REC and WS-RENAME both at top
        Assert.Equal("WS-REC", ((DataItemNode)result[0]).Name);
        Assert.Equal("WS-RENAME", ((DataItemNode)result[1]).Name);
    }

    // ── Mixed levels ──────────────────────────────────────────

    [Fact]
    public void BuildHierarchy_ComplexMixedLevels()
    {
        // Simulates a real COBOL structure:
        // 01 WS-REC.
        //   05 WS-GROUP-A.
        //     10 WS-FIELD-1  PIC X.
        //     10 WS-FIELD-2  PIC 9.
        //       88 WS-VALID VALUE 1.
        //   05 WS-GROUP-B.
        //     10 WS-FIELD-3  PIC X(10).
        // 77 WS-STANDALONE  PIC 9(4).
        var items = new List<AstNode>
        {
            new DataItemNode { Level = 1, Name = "WS-REC" },
            new DataItemNode { Level = 5, Name = "WS-GROUP-A" },
            new DataItemNode { Level = 10, Name = "WS-FIELD-1", PicClause = "X" },
            new DataItemNode { Level = 10, Name = "WS-FIELD-2", PicClause = "9" },
            new DataItemNode { Level = 88, Name = "WS-VALID", ValueClause = "1" },
            new DataItemNode { Level = 5, Name = "WS-GROUP-B" },
            new DataItemNode { Level = 10, Name = "WS-FIELD-3", PicClause = "X(10)" },
            new DataItemNode { Level = 77, Name = "WS-STANDALONE", PicClause = "9(4)" }
        };
        var result = DataItemHierarchyBuilder.BuildHierarchy(items);

        // Top level: WS-REC + WS-STANDALONE
        Assert.Equal(2, result.Count);

        var rec = (DataItemNode)result[0];
        Assert.Equal("WS-REC", rec.Name);
        Assert.Equal(2, rec.Children.Count); // GROUP-A, GROUP-B

        var groupA = rec.Children[0];
        Assert.Equal("WS-GROUP-A", groupA.Name);
        Assert.Equal(2, groupA.Children.Count); // FIELD-1, FIELD-2

        var field2 = groupA.Children[1];
        Assert.Equal("WS-FIELD-2", field2.Name);
        Assert.Single(field2.Children); // WS-VALID (88)
        Assert.Equal("WS-VALID", field2.Children[0].Name);

        var groupB = rec.Children[1];
        Assert.Equal("WS-GROUP-B", groupB.Name);
        Assert.Single(groupB.Children); // FIELD-3

        var standalone = (DataItemNode)result[1];
        Assert.Equal("WS-STANDALONE", standalone.Name);
        Assert.Empty(standalone.Children);
    }

    // ── Non-DataItemNode preserved ────────────────────────────

    [Fact]
    public void BuildHierarchy_NonDataItemNodes_PreservedAtTopLevel()
    {
        var items = new List<AstNode>
        {
            new DataItemNode { Level = 1, Name = "WS-REC" },
            new DataItemNode { Level = 5, Name = "WS-FIELD" },
            new ParagraphNode { Name = "STRAY-PARA" }, // non-DataItemNode
            new DataItemNode { Level = 1, Name = "WS-REC2" }
        };
        var result = DataItemHierarchyBuilder.BuildHierarchy(items);

        Assert.Equal(3, result.Count);
        Assert.IsType<DataItemNode>(result[0]);
        Assert.IsType<ParagraphNode>(result[1]);
        Assert.IsType<DataItemNode>(result[2]);

        // First record should still have its child
        var rec1 = (DataItemNode)result[0];
        Assert.Single(rec1.Children);
    }

    // ── Level pop-back (05 → 15 → 05) ────────────────────────

    [Fact]
    public void BuildHierarchy_LevelPopBack_CorrectParent()
    {
        var items = new List<AstNode>
        {
            new DataItemNode { Level = 1, Name = "REC" },
            new DataItemNode { Level = 5, Name = "A" },
            new DataItemNode { Level = 15, Name = "A1" },
            new DataItemNode { Level = 5, Name = "B" },
            new DataItemNode { Level = 15, Name = "B1" }
        };
        var result = DataItemHierarchyBuilder.BuildHierarchy(items);

        Assert.Single(result);
        var rec = (DataItemNode)result[0];
        Assert.Equal(2, rec.Children.Count); // A, B

        Assert.Single(rec.Children[0].Children); // A → A1
        Assert.Single(rec.Children[1].Children); // B → B1
    }

    // ── Multiple 01 records — stack reset ─────────────────────

    [Fact]
    public void BuildHierarchy_Multiple01_StackResets()
    {
        var items = new List<AstNode>
        {
            new DataItemNode { Level = 1, Name = "REC-1" },
            new DataItemNode { Level = 5, Name = "FIELD-1A" },
            new DataItemNode { Level = 1, Name = "REC-2" },
            new DataItemNode { Level = 5, Name = "FIELD-2A" }
        };
        var result = DataItemHierarchyBuilder.BuildHierarchy(items);

        Assert.Equal(2, result.Count);
        Assert.Single(((DataItemNode)result[0]).Children);
        Assert.Single(((DataItemNode)result[1]).Children);
        Assert.Equal("FIELD-1A", ((DataItemNode)result[0]).Children[0].Name);
        Assert.Equal("FIELD-2A", ((DataItemNode)result[1]).Children[0].Name);
    }

    // ── Level 02-49 without 01 parent → top level ─────────────

    [Fact]
    public void BuildHierarchy_NoLevel01Parent_GoesTopLevel()
    {
        var items = new List<AstNode>
        {
            new DataItemNode { Level = 5, Name = "ORPHAN-5" },
            new DataItemNode { Level = 10, Name = "CHILD-10" }
        };
        var result = DataItemHierarchyBuilder.BuildHierarchy(items);

        Assert.Single(result);
        var orphan = (DataItemNode)result[0];
        Assert.Equal("ORPHAN-5", orphan.Name);
        Assert.Single(orphan.Children);
        Assert.Equal("CHILD-10", orphan.Children[0].Name);
    }

    // ── Deep nesting (01/02/03/04/05) ─────────────────────────

    [Fact]
    public void BuildHierarchy_DeepNesting_5Levels()
    {
        var items = new List<AstNode>
        {
            new DataItemNode { Level = 1, Name = "L01" },
            new DataItemNode { Level = 2, Name = "L02" },
            new DataItemNode { Level = 3, Name = "L03" },
            new DataItemNode { Level = 4, Name = "L04" },
            new DataItemNode { Level = 5, Name = "L05" }
        };
        var result = DataItemHierarchyBuilder.BuildHierarchy(items);

        Assert.Single(result);
        var l01 = (DataItemNode)result[0];
        Assert.Single(l01.Children);
        var l02 = l01.Children[0];
        Assert.Single(l02.Children);
        var l03 = l02.Children[0];
        Assert.Single(l03.Children);
        var l04 = l03.Children[0];
        Assert.Single(l04.Children);
        Assert.Equal("L05", l04.Children[0].Name);
    }

    // ── Same level siblings ───────────────────────────────────

    [Fact]
    public void BuildHierarchy_SameLevelSiblings()
    {
        var items = new List<AstNode>
        {
            new DataItemNode { Level = 1, Name = "REC" },
            new DataItemNode { Level = 5, Name = "A" },
            new DataItemNode { Level = 5, Name = "B" },
            new DataItemNode { Level = 5, Name = "C" }
        };
        var result = DataItemHierarchyBuilder.BuildHierarchy(items);

        Assert.Single(result);
        var rec = (DataItemNode)result[0];
        Assert.Equal(3, rec.Children.Count);
        Assert.Equal("A", rec.Children[0].Name);
        Assert.Equal("B", rec.Children[1].Name);
        Assert.Equal("C", rec.Children[2].Name);
    }

    // ── 77 followed by items — no nesting ─────────────────────

    [Fact]
    public void BuildHierarchy_Level77_FollowedByItems_NoNesting()
    {
        var items = new List<AstNode>
        {
            new DataItemNode { Level = 77, Name = "STANDALONE" },
            new DataItemNode { Level = 5, Name = "ORPHAN" }
        };
        var result = DataItemHierarchyBuilder.BuildHierarchy(items);

        // 77 is top-level with no children; orphan 05 also goes top-level
        Assert.Equal(2, result.Count);
        Assert.Empty(((DataItemNode)result[0]).Children);
    }
}
