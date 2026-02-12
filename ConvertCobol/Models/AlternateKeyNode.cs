/*
 * 更新時間：2026-02-09 16:15
 * 作者：AI Assistant
 * 摘要：ALTERNATE RECORD KEY 單一項目（鍵名 + 欄位列表）
 */

namespace ConvertCobol.Models;

public class AlternateKeyNode
{
    public string KeyName { get; set; } = "";
    public List<string> KeyFields { get; set; } = [];
}
