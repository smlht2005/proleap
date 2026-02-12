/*
 * 更新時間：2026-02-11
 * 作者：AI Assistant
 * 摘要：EVALUATE WHEN 區塊模型，供 StatementNode.EvaluateWhenPhrases 使用（WhenConditions、Statements）
 */

namespace ConvertCobol.Models;

/// <summary>EVALUATE 單一 WHEN 區塊：一組 WHEN 條件與其下語句。</summary>
public class EvaluateWhenClause
{
    /// <summary>該 phrase 內所有 WHEN 條件的來源文字（一個 phrase 可有多個 WHEN evaluateCondition）。</summary>
    public List<string>? WhenConditions { get; set; }

    /// <summary>該 phrase 的 statement*，與 IF ThenStatements 同結構。</summary>
    public List<StatementNode>? Statements { get; set; }
}
