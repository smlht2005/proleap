/*
 * 更新時間：2026-02-09 22:00
 * 作者：AI Assistant
 * 摘要：註冊 ScreenDescriptionItemNode JsonDerivedType（SCREEN SECTION 螢幕項）
 *
 * 更新時間：2026-02-09 19:45
 * 作者：AI Assistant
 * 摘要：註冊 DATA DIVISION 節點 JsonDerivedType（FileSection、FileDescription、WorkingStorageSection、LinkageSection、ScreenSection）
 *
 * 更新時間：2026-02-09
 * 作者：AI Assistant
 * 摘要：JSON 序列化支援（JsonPolymorphic、JsonDerivedType）
 *
 * 更新時間：2026-02-06
 * 作者：AI Assistant
 * 摘要：COBOL AST 節點基類
 */

using System.Text.Json.Serialization;

namespace ConvertCobol.Models;

[JsonPolymorphic]
[JsonDerivedType(typeof(DivisionNode), typeDiscriminator: "Division")]
[JsonDerivedType(typeof(DataItemNode), typeDiscriminator: "DataItem")]
[JsonDerivedType(typeof(FileControlEntryNode), typeDiscriminator: "FileControlEntry")]
[JsonDerivedType(typeof(InputOutputSectionNode), typeDiscriminator: "InputOutputSection")]
[JsonDerivedType(typeof(FileSectionNode), typeDiscriminator: "FileSection")]
[JsonDerivedType(typeof(FileDescriptionNode), typeDiscriminator: "FileDescription")]
[JsonDerivedType(typeof(WorkingStorageSectionNode), typeDiscriminator: "WorkingStorageSection")]
[JsonDerivedType(typeof(LinkageSectionNode), typeDiscriminator: "LinkageSection")]
[JsonDerivedType(typeof(ScreenSectionNode), typeDiscriminator: "ScreenSection")]
[JsonDerivedType(typeof(ScreenDescriptionItemNode), typeDiscriminator: "ScreenDescriptionItem")]
[JsonDerivedType(typeof(ParagraphNode), typeDiscriminator: "Paragraph")]
[JsonDerivedType(typeof(StatementNode), typeDiscriminator: "Statement")]
public abstract class AstNode
{
    public string? NodeType { get; set; }
}
