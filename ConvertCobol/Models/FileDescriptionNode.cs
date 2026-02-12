/*
 * 更新時間：2026-02-09 19:45
 * 作者：AI Assistant
 * 摘要：FD/SD 檔描述節點，children 為該 FD 下的 DataItem 列表
 */

namespace ConvertCobol.Models;

public class FileDescriptionNode : AstNode
{
    public string FdName { get; set; } = "";
    public string FdType { get; set; } = "FD";
    public bool External { get; set; }
    public List<AstNode> Children { get; set; } = [];
}
