using System.Text;

namespace ConvertCobol.Preprocessing;

/// <summary>編碼偵測與建立輔助方法。</summary>
public static class EncodingHelper
{
    /// <summary>根據名稱取得 Encoding，Big5/MS950 優先使用 code page 950。</summary>
    public static Encoding GetEncodingOrDefault(string name)
    {
        if (string.Equals(name, "MS950", StringComparison.OrdinalIgnoreCase) ||
            string.Equals(name, "big5", StringComparison.OrdinalIgnoreCase) ||
            string.Equals(name, "Big5", StringComparison.OrdinalIgnoreCase))
        {
            try { return Encoding.GetEncoding(950); } catch { }
            try { return Encoding.GetEncoding("big5"); } catch { }
            try { return Encoding.GetEncoding("MS950"); } catch { }
        }
        try
        {
            return Encoding.GetEncoding(name);
        }
        catch (ArgumentException ex)
        {
            Console.WriteLine($"警告：無法載入編碼 '{name}' ({ex.Message})，改用 UTF-8");
            return Encoding.UTF8;
        }
    }

    /// <summary>偵測檔案編碼，若為 UTF-8 BOM 則回傳 UTF-8，否則嘗試檢測 UTF-8（無 BOM），最後使用指定 fallback。</summary>
    public static Encoding DetectEncoding(string path, Encoding fallback)
    {
        var buf = new byte[Math.Min(4096, new FileInfo(path).Length)];
        using (var fs = File.OpenRead(path))
        {
            var bytesRead = fs.Read(buf, 0, buf.Length);
            if (bytesRead < 3) return fallback;

            // 檢查 UTF-8 BOM
            if (buf[0] == 0xEF && buf[1] == 0xBB && buf[2] == 0xBF)
                return new UTF8Encoding(false);

            // 嘗試檢測 UTF-8（無 BOM）
            try
            {
                var utf8 = new UTF8Encoding(false);
                var decoded = utf8.GetString(buf, 0, bytesRead);
                var replacementCharCount = decoded.Count(c => c == '\uFFFD');
                var validRatio = 1.0 - (double)replacementCharCount / decoded.Length;

                if (validRatio > 0.95)
                {
                    return utf8;
                }
            }
            catch
            {
                // UTF-8 解碼失敗，繼續使用 fallback
            }
        }
        return fallback;
    }
}
