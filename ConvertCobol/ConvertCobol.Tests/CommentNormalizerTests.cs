using ConvertCobol.Preprocessing;

namespace ConvertCobol.Tests;

public class CommentNormalizerTests
{
    [Fact]
    public void ConvertTraditionalComments_ConvertsStarToStarGt()
    {
        var input = "* This is a comment\r\n       MOVE A TO B.";
        var result = CommentNormalizer.ConvertTraditionalComments(input);
        Assert.StartsWith("*> ", result);
        Assert.Contains("MOVE A TO B.", result);
    }

    [Fact]
    public void ConvertTraditionalComments_PreservesStarGtLines()
    {
        var input = "*> Already a modern comment\r\n       MOVE A TO B.";
        var result = CommentNormalizer.ConvertTraditionalComments(input);
        Assert.StartsWith("*> Already a modern comment", result);
    }

    [Fact]
    public void ConvertTraditionalComments_HandlesCommentContinuation()
    {
        // Previous line is a comment ending with comma, next line is a string literal
        var input = "* Some comment,\r\n\"continuation string\"";
        var result = CommentNormalizer.ConvertTraditionalComments(input);
        var lines = result.Split(new[] { "\r\n", "\n" }, StringSplitOptions.None);
        Assert.True(lines[0].StartsWith("*>"));
        Assert.True(lines[1].StartsWith("*>"));
    }

    [Fact]
    public void ConvertTraditionalComments_ConvertsEndOfLine()
    {
        var input = "       MOVE A TO B.\r\nEnd of listing";
        var result = CommentNormalizer.ConvertTraditionalComments(input);
        Assert.Contains("*> End of listing", result);
    }

    [Fact]
    public void NormalizeProcedureComments_ConvertsTraditionalInProcedure()
    {
        var input = "PROCEDURE DIVISION.\r\n* Procedure comment\r\n       MOVE A TO B.";
        var result = CommentNormalizer.NormalizeProcedureComments(input);
        Assert.Contains("*> ", result);
        Assert.DoesNotContain("\n* Procedure", result);
    }

    [Fact]
    public void NormalizeProcedureComments_PreservesStarGt()
    {
        var input = "PROCEDURE DIVISION.\r\n*> Already modern\r\n       MOVE A TO B.";
        var result = CommentNormalizer.NormalizeProcedureComments(input);
        Assert.Contains("*> Already modern", result);
    }
}
