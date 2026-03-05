using ConvertCobol.Models;

namespace ConvertCobol.Visitors;

/// <summary>
/// 根據 COBOL level number 語義，將扁平的 DataItemNode 清單建構為層級樹。
/// Level 01/77: 頂層（77 無子項）
/// Level 02-49: 找 stack 中最近 level 小於自己的 item 作為 parent
/// Level 66: RENAMES，附加至頂層
/// Level 78/88: 附加到最近的前一個 item（條件名稱/常數）
/// </summary>
public static class DataItemHierarchyBuilder
{
    /// <summary>
    /// 將扁平的 AstNode 清單（其中 DataItemNode 依出現順序排列）轉為層級樹。
    /// 非 DataItemNode 的節點保留在頂層不動。
    /// 回傳新的頂層清單（已將子項移入 parent.Children）。
    /// </summary>
    public static List<AstNode> BuildHierarchy(List<AstNode> flatItems)
    {
        if (flatItems == null || flatItems.Count == 0)
            return flatItems ?? [];

        var result = new List<AstNode>();
        // Stack tracks (level, DataItemNode) for parent lookup
        var stack = new Stack<(int Level, DataItemNode Node)>();

        foreach (var item in flatItems)
        {
            if (item is not DataItemNode dataItem)
            {
                // Non-DataItemNode (e.g., nested sections) — keep at top level
                result.Add(item);
                continue;
            }

            var level = dataItem.Level;

            if (level == 1 || level == 77)
            {
                // Level 01 and 77 are always top-level
                result.Add(dataItem);
                stack.Clear();
                if (level == 1)
                    stack.Push((level, dataItem));
                // Level 77 has no children, don't push to stack
            }
            else if (level == 66)
            {
                // Level 66 (RENAMES) — top-level, no nesting
                result.Add(dataItem);
            }
            else if (level == 78 || level == 88)
            {
                // Level 78 (constant) / 88 (condition name) — attach to nearest preceding item
                if (stack.Count > 0)
                    stack.Peek().Node.Children.Add(dataItem);
                else
                    result.Add(dataItem);
            }
            else
            {
                // Level 02-49: find parent with level < current
                while (stack.Count > 0 && stack.Peek().Level >= level)
                    stack.Pop();

                if (stack.Count > 0)
                    stack.Peek().Node.Children.Add(dataItem);
                else
                    result.Add(dataItem);

                stack.Push((level, dataItem));
            }
        }

        return result;
    }
}
