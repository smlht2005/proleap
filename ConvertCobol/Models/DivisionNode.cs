/*
 * 更新時間：2026-02-06
 * 作者：AI Assistant
 * 摘要：COBOL DIVISION 節點（IDENTIFICATION/ENVIRONMENT/DATA/PROCEDURE）
 */

namespace ConvertCobol.Models;

public class DivisionNode : AstNode
{
    public string DivisionName { get; set; } = "";
    public List<AstNode> Children { get; set; } = [];
}
