using System.Text.Json.Serialization;
using ConvertCobol.Models.Statements;

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
[JsonDerivedType(typeof(MoveStatement), typeDiscriminator: "MoveStatement")]
[JsonDerivedType(typeof(PerformStatement), typeDiscriminator: "PerformStatement")]
[JsonDerivedType(typeof(CallStatement), typeDiscriminator: "CallStatement")]
[JsonDerivedType(typeof(IfStatement), typeDiscriminator: "IfStatement")]
[JsonDerivedType(typeof(EvaluateStatement), typeDiscriminator: "EvaluateStatement")]
[JsonDerivedType(typeof(DisplayStatement), typeDiscriminator: "DisplayStatement")]
[JsonDerivedType(typeof(AcceptStatement), typeDiscriminator: "AcceptStatement")]
[JsonDerivedType(typeof(OpenStatement), typeDiscriminator: "OpenStatement")]
[JsonDerivedType(typeof(CloseStatement), typeDiscriminator: "CloseStatement")]
[JsonDerivedType(typeof(ReadStatement), typeDiscriminator: "ReadStatement")]
[JsonDerivedType(typeof(WriteStatement), typeDiscriminator: "WriteStatement")]
[JsonDerivedType(typeof(RewriteStatement), typeDiscriminator: "RewriteStatement")]
[JsonDerivedType(typeof(StartStatement), typeDiscriminator: "StartStatement")]
[JsonDerivedType(typeof(InitializeStatement), typeDiscriminator: "InitializeStatement")]
[JsonDerivedType(typeof(StringStatement), typeDiscriminator: "StringStatement")]
[JsonDerivedType(typeof(InspectStatement), typeDiscriminator: "InspectStatement")]
[JsonDerivedType(typeof(ComputeStatement), typeDiscriminator: "ComputeStatement")]
[JsonDerivedType(typeof(SimpleStatement), typeDiscriminator: "SimpleStatement")]
public abstract class AstNode
{
    public string? NodeType { get; set; }
}
