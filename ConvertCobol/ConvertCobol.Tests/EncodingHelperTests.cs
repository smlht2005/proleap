using System.Text;
using ConvertCobol.Preprocessing;

namespace ConvertCobol.Tests;

public class EncodingHelperTests
{
    [Theory]
    [InlineData("big5")]
    [InlineData("Big5")]
    [InlineData("MS950")]
    public void GetEncodingOrDefault_Big5Variants_ReturnCodePage950(string name)
    {
        Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);
        var enc = EncodingHelper.GetEncodingOrDefault(name);
        Assert.Equal(950, enc.CodePage);
    }

    [Fact]
    public void GetEncodingOrDefault_Utf8_ReturnsUtf8()
    {
        var enc = EncodingHelper.GetEncodingOrDefault("utf-8");
        Assert.Equal(Encoding.UTF8.CodePage, enc.CodePage);
    }

    [Fact]
    public void GetEncodingOrDefault_InvalidName_FallsBackToUtf8()
    {
        var enc = EncodingHelper.GetEncodingOrDefault("totally-invalid-encoding-xyz");
        Assert.Equal(Encoding.UTF8.CodePage, enc.CodePage);
    }

    [Fact]
    public void DetectEncoding_Utf8WithBom_ReturnsUtf8()
    {
        var tmpFile = Path.GetTempFileName();
        try
        {
            // Write with BOM
            File.WriteAllBytes(tmpFile, new byte[] { 0xEF, 0xBB, 0xBF, (byte)'H', (byte)'i' });
            var enc = EncodingHelper.DetectEncoding(tmpFile, Encoding.ASCII);
            Assert.Equal(65001, enc.CodePage); // UTF-8
        }
        finally
        {
            File.Delete(tmpFile);
        }
    }

    [Fact]
    public void DetectEncoding_PureAscii_DetectsAsUtf8()
    {
        var tmpFile = Path.GetTempFileName();
        try
        {
            File.WriteAllText(tmpFile, "Hello World\nLine 2\n", new UTF8Encoding(false));
            var enc = EncodingHelper.DetectEncoding(tmpFile, Encoding.ASCII);
            Assert.Equal(65001, enc.CodePage); // UTF-8 (pure ASCII is valid UTF-8)
        }
        finally
        {
            File.Delete(tmpFile);
        }
    }
}
