/*
 * 更新時間：2026-02-11
 * 作者：AI Assistant
 * 摘要：DISPLAY 修正：從原始 COBOL 文字向後查找語句結束句點（跳過小數點），取得完整多行 DISPLAY 語句文字（含擴充語法如 LINES、SIZE、HANDLE 等）
 *
 * 更新時間：2026-02-11
 * 作者：AI Assistant
 * 摘要：DISPLAY 新增 VisitDisplayStatement、EnrichDisplayFromText，產出 displayOperands、displayUpon、displayAt、displayWith、displayBlockEnd（. 或 END-DISPLAY）
 *
 * 更新時間：2026-02-11
 * 作者：AI Assistant
 * 摘要：ACCEPT 新增 VisitAcceptStatement、EnrichAcceptFromText，產出 acceptTarget、acceptFromEnvironment、acceptBlockEnd（如 END-ACCEPT）
 *
 * 更新時間：2026-02-11
 * 作者：AI Assistant
 * 摘要：WHEN 901/WHEN OTHER 根因：誤併的 MOVE 位於段落層級 statements 非 EVALUATE 內，新增 NormalizeAllProcedureStatements 走訪整個 Procedure 樹（含段落層級與巢狀 EVALUATE/IF），單一函數對所有 StatementNode 套用 FixStatementTruncateAtWhen
 *
 * 更新時間：2026-02-11
 * 作者：AI Assistant
 * 摘要：EVALUATE 根因修正：因 COBOL 續行導致 WHEN 901/WHEN OTHER 被併入上一句 MOVE，新增 NormalizeEvaluateBlockStatements + FixStatementTruncateAtWhen 單一後處理，截斷 Text 並修正 moveTo
 *
 * 更新時間：2026-02-11
 * 作者：AI Assistant
 * 摘要：EVALUATE 新增 EvaluateBlockEnd；MOVE 過濾 moveTo 誤入 WHEN/OTHER/901；STRING 新增 VisitStringStatement（StringInto、StringPointer）；INSPECT 新增 VisitInspectStatement（InspectTarget、InspectTallying、InspectTallyingFor）
 *
 * 更新時間：2026-02-11
 * 作者：AI Assistant
 * 摘要：Part A GetStatementType 新增 ADD/CONTINUE/GOTO/SEARCH/CANCEL/DELETE/INSPECT/SET；Part B EVALUATE 結構化 VisitEvaluateStatement（evaluateSubject、evaluateWhenPhrases、evaluateWhenOtherStatements）
 *
 * 更新時間：2026-02-11
 * 作者：AI Assistant
 * 摘要：GetStatementType 新增 exitStatement → "EXIT"，使 EXIT 語句產出 statementType 為 "EXIT" 而非 "OTHER"
 *
 * 更新時間：2026-02-10 20:30
 * 作者：AI Assistant
 * 摘要：簡化 PROCEDURE SECTION AST：不再為 SECTION 標頭產生 isSection=true 的 Paragraph 節點，只累計 SectionCount，避免誤將一般變數名稱（如 Acu-Size）輸出為 Section
 *
 * 更新時間：2026-02-10
 * 作者：AI Assistant
 * 更新時間：2026-02-10
 * 作者：AI Assistant
 * 摘要：IF 語句新增 VisitIfStatement，填入 IfCondition/IfThenText/IfElseText 使 IF 結構清晰
 *
 * 更新時間：2026-02-10
 * 作者：AI Assistant
 * 摘要：INITIALIZE 以 initializeTargets 陣列收集目標；READ 新增 readTarget/readNext/readInto；START 新增 startTarget/startKeyOperator/startKeyDataName，語句結構更清晰
 *
 * 更新時間：2026-02-10 18:00
 * 作者：AI Assistant
 * 摘要：VisitStatement 派發至 VisitMoveStatement/VisitPerformStatement/VisitCallStatement，填入 MoveFrom/MoveTo、PerformTarget/PerformThru、CallTarget/CallArgs 供 C# CodeGen 使用
 *
 * 更新時間：2026-02-09 18:35
 * 作者：AI Assistant
 * 摘要：Overview 統計：VisitFileControlParagraph 累加 FileControlEntryCount；VisitScreenSection 完成後以 CountScreenItemsRecursive 計算 ScreenSectionItemCount 並寫入 _ast
 *
 * 更新時間：2026-02-09 18:30
 * 作者：AI Assistant
 * 摘要：修復 ParseGuiProperties：正確區分新 entry（以兩位數字開頭如 "03 S-RCB1-Fr-1"）和屬性名稱（如 "3-D"），確保以數字開頭的屬性名稱（如 "3-D"）能被正確解析為 "3-D": "True"
 *
 * 更新時間：2026-02-09 16:22
 * 作者：AI Assistant
 * 摘要：修改 CreateScreenItemFromLine：從原始字符串提取 level，保留前導零（如 "03" 而不是 "3"），確保 JSON 輸出中 level 為字符串格式且保留原始格式
 *
 * 更新時間：2026-02-09 16:30
 * 作者：AI Assistant
 * 摘要：修復 continuation lines 解析：新增 MergeContinuationLinesWithParentheses 和 SplitRespectingParentheses 方法，正確處理包含括號和引號的跨行屬性值（如 DISPLAY-COLUMNS (1, 5, ...) 和 ALIGNMENT ("R", "U", ...)）
 *
 * 更新時間：2026-02-09 16:15
 * 作者：AI Assistant
 * 摘要：修復 ParseGuiProperties：移除 value 開頭的 "IS " 前綴（如 "COLOR IS 2" → "COLOR": "2", "FONT IS 細明體12" → "FONT": "細明體12"）
 *
 * 更新時間：2026-02-09 15:47
 * 作者：AI Assistant
 * 摘要：修復 Screen Section 解析只輸出一個 item 的問題：在 FillSingleScreenItemProperties 中檢測到新 entry 時創建 ScreenDescriptionItemNode 並添加到 AST，新增 CreateScreenItemFromLine 和 FindParentForScreenItem 輔助方法
 *
 * 更新時間：2026-02-10 16:00
 * 作者：AI Assistant
 * 摘要：重構 ScreenDescriptionItem：處理 continuation 中的新 entry（03 S-RCB1-Fr-1），建立父子關係，將 guiProperties 改為 Dictionary<string, string> 格式
 *
 * 更新時間：2026-02-10 14:30
 * 作者：AI Assistant
 * 摘要：添加日誌追蹤（VisitScreenSection、VisitScreenDescriptionEntry、VisitAcuScreenContinuation）以診斷 guiProperties 為空問題
 *
 * 更新時間：2026-02-09 22:00
 * 作者：AI Assistant
 * 摘要：實作 VisitScreenDescriptionEntry，產出 ScreenDescriptionItemNode（level/name、子句欄位、GuiType/GuiProperties）
 *
 * 更新時間：2026-02-09 19:50
 * 作者：AI Assistant
 * 摘要：DATA DIVISION 依 section 分組（FileSection/FD、WorkingStorageSection、LinkageSection、ScreenSection），DataItem 歸於各 section/FD
 *
 * 更新時間：2026-02-09 17:00
 * 作者：AI Assistant
 * 摘要：新增 INPUT-OUTPUT SECTION 層級，FileControlEntry 改為置於 InputOutputSectionNode.children
 *
 * 更新時間：2026-02-09 16:00
 * 作者：AI Assistant
 * 摘要：FILE-CONTROL 解析並寫入 Environment（FileControlEntryNode：檔名 + 子句列表）
 *
 * 更新時間：2026-02-09 15:30
 * 作者：AI Assistant
 * 摘要：78/88 級 ValueClause 改為實際值（VALUE 1 → "1", VALUE ZERO → "0"）
 *
 * 更新時間：2026-02-06
 * 作者：AI Assistant
 * 摘要：ANTLR parse tree 走訪器，建構 COBOL AST 模型
 */

using System.Linq;
using System.Text;
using Antlr4.Runtime;
using Antlr4.Runtime.Tree;
using ConvertCobol.Generated;
using ConvertCobol.Models;
using ConvertCobol.Models.Statements;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Logging.Abstractions;

namespace ConvertCobol.Visitors;

public class CobolAstVisitor : Cobol85AcuBaseVisitor<object?>
{
    private readonly ProgramAst _ast = new();
    private readonly ILogger _logger;
    private DivisionNode? _currentDataDivision;
    private DivisionNode? _currentProcedureDivision;
    private InputOutputSectionNode? _currentInputOutputSection;
    private List<AstNode>? _currentDataItemTarget;
    private FileSectionNode? _currentFileSection;
    private string? _cobolSource;
    private ScreenSectionVisitor? _screenVisitor;

    public CobolAstVisitor() : this(NullLogger<CobolAstVisitor>.Instance) { }
    public CobolAstVisitor(ILogger<CobolAstVisitor> logger) { _logger = logger; }

    public ProgramAst Result => _ast;

    /// <summary>設定原始 COBOL 文字，用於後處理 continuation lines。</summary>
    public void SetCobolSource(string source)
    {
        _cobolSource = source;
    }

    public override object? VisitProgramUnit(Cobol85AcuParser.ProgramUnitContext context)
    {
        VisitChildren(context);
        return _ast;
    }

    public override object? VisitProgramIdParagraph(Cobol85AcuParser.ProgramIdParagraphContext context)
    {
        var nameNode = context.programName();
        if (nameNode != null)
            _ast.ProgramId = GetText(nameNode);
        return VisitChildren(context);
    }

    public override object? VisitIdentificationDivision(Cobol85AcuParser.IdentificationDivisionContext context)
    {
        _ast.Identification = new DivisionNode { DivisionName = "IDENTIFICATION" };
        return VisitChildren(context);
    }

    public override object? VisitEnvironmentDivision(Cobol85AcuParser.EnvironmentDivisionContext context)
    {
        _ast.Environment = new DivisionNode { DivisionName = "ENVIRONMENT" };
        return VisitChildren(context);
    }

    public override object? VisitInputOutputSection(Cobol85AcuParser.InputOutputSectionContext context)
    {
        var section = new InputOutputSectionNode { SectionName = "INPUT-OUTPUT" };
        _currentInputOutputSection = section;
        VisitChildren(context);
        _currentInputOutputSection = null;
        if (_ast.Environment != null)
            _ast.Environment.Children.Add(section);
        return null;
    }

    public override object? VisitFileControlParagraph(Cobol85AcuParser.FileControlParagraphContext context)
    {
        var entries = context.fileControlEntry();
        _ast.FileControlEntryCount += entries?.Length ?? 0;
        var target = _currentInputOutputSection != null ? _currentInputOutputSection.Children : _ast.Environment?.Children;
        if (target == null) return VisitChildren(context);
        for (var i = 0; i < entries.Length; i++)
        {
            var entry = entries[i];
            var select = entry.selectClause();
            if (select == null) continue;
            var node = new FileControlEntryNode
            {
                FileName = GetText(select.fileName()) ?? "",
                Optional = select.OPTIONAL() != null
            };
            var clauses = entry.fileControlClause();
            if (clauses != null)
            {
                foreach (var clause in clauses)
                    FillFileControlClause(node, clause);
            }
            target.Add(node);
        }
        return VisitChildren(context);
    }

    private static void FillFileControlClause(FileControlEntryNode node, Cobol85AcuParser.FileControlClauseContext clause)
    {
        if (clause.assignClause() != null)
        {
            node.AssignTo = GetAssignToValue(clause.assignClause());
        }
        else if (clause.organizationClause() != null)
        {
            node.Organization = GetOrganizationValue(clause.organizationClause());
        }
        else if (clause.accessModeClause() != null)
        {
            node.AccessMode = GetAccessModeValue(clause.accessModeClause());
        }
        else if (clause.acuLockModeClause() != null)
        {
            node.LockMode = GetLockModeValue(clause.acuLockModeClause());
        }
        else if (clause.fileStatusClause() != null)
        {
            var names = clause.fileStatusClause().qualifiedDataName();
            node.FileStatus = names != null && names.Length > 0 ? GetText(names[0]) : null;
        }
        else if (clause.recordKeyClause() != null)
        {
            var ctx = clause.recordKeyClause();
            var qnames = ctx.qualifiedDataName();
            if (qnames != null && qnames.Length > 0)
            {
                node.RecordKeyName = GetText(qnames[0]);
                // 後續 qnames 可能同時包含 RECORD KEY 欄位與 STATUS 子句
                for (var j = 1; j < qnames.Length; j++)
                {
                    var name = GetText(qnames[j]);
                    if (!string.IsNullOrEmpty(name) &&
                        string.Equals(name, "STATUS", StringComparison.OrdinalIgnoreCase) &&
                        j + 1 < qnames.Length)
                    {
                        // 將 STATUS 之後的一個名稱當作 FileStatus，而非 RecordKey 欄位
                        var statusName = GetText(qnames[j + 1]);
                        if (!string.IsNullOrEmpty(statusName))
                            node.FileStatus ??= statusName;
                        j++; // 跳過 STATUS 對應的名稱
                        continue;
                    }
                    node.RecordKeyFields.Add(name ?? "");
                }
            }
        }
        else if (clause.alternateRecordKeyClause() != null)
        {
            var ctx = clause.alternateRecordKeyClause();
            var qnames = ctx.qualifiedDataName();
            if (qnames != null && qnames.Length > 0)
            {
                var alt = new AlternateKeyNode { KeyName = GetText(qnames[0]) ?? "" };
                for (var j = 1; j < qnames.Length; j++)
                    alt.KeyFields.Add(GetText(qnames[j]) ?? "");
                node.AlternateRecordKeys.Add(alt);
            }
        }
        else if (clause.acuCompressionClause() != null)
        {
            var ctx = clause.acuCompressionClause();
            node.Compression = true;
            var ilit = ctx.integerLiteral();
            if (ilit != null && int.TryParse(GetText(ilit), out var v))
                node.CompressionControlValue = v;
        }
        else
        {
            node.OtherClauses.Add(GetText(clause) ?? "");
        }
    }

    public override object? VisitDataDivision(Cobol85AcuParser.DataDivisionContext context)
    {
        _ast.Data = new DivisionNode { DivisionName = "DATA" };
        _currentDataDivision = _ast.Data;
        _currentDataItemTarget = _ast.Data.Children;
        VisitChildren(context);
        _currentDataItemTarget = null;
        return null;
    }

    public override object? VisitFileSection(Cobol85AcuParser.FileSectionContext context)
    {
        var section = new FileSectionNode { SectionName = "FILE" };
        _currentFileSection = section;
        VisitChildren(context);
        _currentFileSection = null;
        if (_currentDataDivision != null)
            _currentDataDivision.Children.Add(section);
        return null;
    }

    public override object? VisitFileDescriptionEntry(Cobol85AcuParser.FileDescriptionEntryContext context)
    {
        _ast.FdCount++;
        var fd = new FileDescriptionNode
        {
            FdName = context.fileName() != null ? GetText(context.fileName()) ?? "" : "",
            FdType = context.FD() != null ? "FD" : (context.SD() != null ? "SD" : "FD"),
            External = false
        };
        var clauses = context.fileDescriptionEntryClause();
        if (clauses != null)
        {
            foreach (var clause in clauses)
            {
                if (clause.externalClause() != null)
                {
                    fd.External = true;
                    break;
                }
            }
        }
        var prevTarget = _currentDataItemTarget;
        _currentDataItemTarget = fd.Children;
        VisitChildren(context);
        _currentDataItemTarget = prevTarget;
        fd.Children = DataItemHierarchyBuilder.BuildHierarchy(fd.Children);
        _currentFileSection?.Children.Add(fd);
        return null;
    }

    public override object? VisitWorkingStorageSection(Cobol85AcuParser.WorkingStorageSectionContext context)
    {
        var section = new WorkingStorageSectionNode { SectionName = "WORKING-STORAGE" };
        var prevTarget = _currentDataItemTarget;
        _currentDataItemTarget = section.Children;
        VisitChildren(context);
        _currentDataItemTarget = prevTarget;
        section.Children = DataItemHierarchyBuilder.BuildHierarchy(section.Children);
        if (_currentDataDivision != null)
            _currentDataDivision.Children.Add(section);
        return null;
    }

    public override object? VisitLinkageSection(Cobol85AcuParser.LinkageSectionContext context)
    {
        var section = new LinkageSectionNode { SectionName = "LINKAGE" };
        var prevTarget = _currentDataItemTarget;
        _currentDataItemTarget = section.Children;
        VisitChildren(context);
        _currentDataItemTarget = prevTarget;
        section.Children = DataItemHierarchyBuilder.BuildHierarchy(section.Children);
        if (_currentDataDivision != null)
            _currentDataDivision.Children.Add(section);
        return null;
    }

    public override object? VisitScreenSection(Cobol85AcuParser.ScreenSectionContext context)
    {
        _screenVisitor = new ScreenSectionVisitor(_logger, _cobolSource, VisitChildren);
        var result = _screenVisitor.VisitScreenSection(context, _ast, _currentDataDivision);
        _screenVisitor = null;
        return result;
    }

    public override object? VisitScreenDescriptionEntry(Cobol85AcuParser.ScreenDescriptionEntryContext context)
    {
        if (_screenVisitor != null)
            return _screenVisitor.VisitScreenDescriptionEntry(context);
        return base.VisitScreenDescriptionEntry(context);
    }

    public override object? VisitAcuScreenContinuation(Cobol85AcuParser.AcuScreenContinuationContext context)
    {
        if (_screenVisitor != null)
            return _screenVisitor.VisitAcuScreenContinuation(context);
        return base.VisitAcuScreenContinuation(context);
    }

    public override object? VisitDataDescriptionEntryFormat1(Cobol85AcuParser.DataDescriptionEntryFormat1Context context)
    {
        var item = new DataItemNode();
        var level = context.INTEGERLITERAL() ?? context.LEVEL_NUMBER_77();
        if (level != null)
        {
            var lv = int.TryParse(level.GetText(), out var v) ? v : 0;
            item.Level = lv;
            if (lv == 1) _ast.DataItem01Count++;
            if (lv == 77) _ast.DataItem77Count++;
        }
        _ast.TotalDataItems++;

        var dataName = context.dataName();
        if (dataName != null)
            item.Name = GetText(dataName) ?? "FILLER";

        var picClauses = context.dataPictureClause();
        if (picClauses.Length > 0 && picClauses[0].pictureString() != null)
            item.PicClause = GetText(picClauses[0].pictureString());

        var redefClauses = context.dataRedefinesClause();
        if (redefClauses.Length > 0 && redefClauses[0].dataName() != null)
            item.Redefines = GetText(redefClauses[0].dataName());

        var occursClauses = context.dataOccursClause();
        if (occursClauses.Length > 0)
            item.Occurs = GetText(occursClauses[0]);

        var valClauses = context.dataValueClause();
        if (valClauses.Length > 0)
        {
            if (item.Level == 78 || item.Level == 88)
                item.ValueClause = GetRealValueFromValueClause(valClauses[0]);
            if (item.ValueClause == null)
                item.ValueClause = GetText(valClauses[0]);
        }

        _currentDataItemTarget?.Add(item);
        return VisitChildren(context);
    }

    public override object? VisitProcedureDivision(Cobol85AcuParser.ProcedureDivisionContext context)
    {
        _ast.Procedure = new DivisionNode { DivisionName = "PROCEDURE" };
        _currentProcedureDivision = _ast.Procedure;
        return VisitChildren(context);
    }

    public override object? VisitProcedureSection(Cobol85AcuParser.ProcedureSectionContext context)
    {
        _ast.SectionCount++;
        // 為簡化 PROCEDURE AST（Plan 2：以「段落 = Paragraph」為主），目前不再將 SECTION 標頭單獨生出 isSection=true 的 Paragraph 節點，
        // 僅累計 SectionCount 後繼續走訪其內部的 paragraph/sentence。
        return VisitChildren(context);
    }

    public override object? VisitParagraph(Cobol85AcuParser.ParagraphContext context)
    {
        var paraName = context.paragraphName();
        var name = paraName != null ? GetText(paraName) ?? "" : "";
        if (string.IsNullOrEmpty(name) && context.sentence().Length == 0)
            return VisitChildren(context);

        _ast.ParagraphCount++;
        var para = new ParagraphNode { Name = name, IsSection = false };

        foreach (var sent in context.sentence())
        {
            foreach (var stmt in sent.statement())
            {
                var result = Visit(stmt);
                if (result is StatementNode stmtNode)
                {
                    para.Statements.Add(stmtNode);
                    _ast.StatementCount++;
                }
            }
        }

        _currentProcedureDivision?.Children.Add(para);
        return para;
    }

    public override object? VisitStatement(Cobol85AcuParser.StatementContext context)
    {
        // 派發至具體語句 Visitor，以產出結構化欄位供 PROCEDURE → C# 轉換使用
        if (context.moveStatement() != null)
            return VisitMoveStatement(context.moveStatement());
        if (context.performStatement() != null)
            return VisitPerformStatement(context.performStatement());
        if (context.callStatement() != null)
            return VisitCallStatement(context.callStatement());
        if (context.openStatement() != null)
            return VisitOpenStatement(context.openStatement());
        if (context.initializeStatement() != null)
            return VisitInitializeStatement(context.initializeStatement());
        if (context.readStatement() != null)
            return VisitReadStatement(context.readStatement());
        if (context.startStatement() != null)
            return VisitStartStatement(context.startStatement());
        if (context.ifStatement() != null)
            return VisitIfStatement(context.ifStatement());
        if (context.closeStatement() != null)
            return VisitCloseStatement(context.closeStatement());
        if (context.evaluateStatement() != null)
            return VisitEvaluateStatement(context.evaluateStatement());
        if (context.stringStatement() != null)
            return VisitStringStatement(context.stringStatement());
        if (context.inspectStatement() != null)
            return VisitInspectStatement(context.inspectStatement());
        if (context.acceptStatement() != null)
            return VisitAcceptStatement(context.acceptStatement());
        if (context.displayStatement() != null)
            return VisitDisplayStatement(context.displayStatement());
        var text = GetSourceSlice(context);
        var stmtType = GetStatementType(context);
        return stmtType switch
        {
            "WRITE" => new WriteStatement { Text = text },
            "REWRITE" => new RewriteStatement { Text = text },
            "COMPUTE" => new ComputeStatement { Text = text },
            _ => new SimpleStatement(stmtType) { Text = text }
        };
    }

    public override object? VisitMoveStatement(Cobol85AcuParser.MoveStatementContext context)
    {
        var node = new MoveStatement { Text = GetSourceSlice(context) };
        var moveTo = context.moveToStatement();
        if (moveTo != null)
        {
            var sending = moveTo.moveToSendingArea();
            if (sending != null)
                node.MoveFrom = GetText(sending);
            var ids = moveTo.identifier();
            if (ids != null && ids.Length > 0)
            {
                var parts = ids.Select(id => GetText(id)).Where(s => !string.IsNullOrEmpty(s)).ToList();
                // 過濾誤入的 EVALUATE 關鍵字/條件（如 WHEN、OTHER、901 或含 WHEN/OTHER 的誤併 token）避免 moveTo 變成 "Acu-Button-Type, user-definedmessageWHEN, 901" 或 "Acu-Button-TypeWHENOTHER"
                var valid = new List<string>();
                foreach (var s in parts)
                {
                    if (string.IsNullOrWhiteSpace(s)) continue;
                    var t = s.Trim();
                    if (t == "WHEN" || t == "OTHER" || t == "901" || System.Text.RegularExpressions.Regex.IsMatch(t, @"^\d+$")) break;
                    if (valid.Count > 0 && (t.Contains("message", StringComparison.OrdinalIgnoreCase) || t.Contains("user-defined", StringComparison.OrdinalIgnoreCase))) break;
                    if (t.Contains("WHEN", StringComparison.OrdinalIgnoreCase))
                    {
                        var idx = t.IndexOf("WHEN", StringComparison.OrdinalIgnoreCase);
                        var before = t.Substring(0, idx).Trim();
                        if (!string.IsNullOrEmpty(before)) valid.Add(before);
                        break;
                    }
                    if (t.Contains("OTHER", StringComparison.OrdinalIgnoreCase))
                    {
                        var idx = t.IndexOf("OTHER", StringComparison.OrdinalIgnoreCase);
                        var before = t.Substring(0, idx).Trim();
                        if (!string.IsNullOrEmpty(before)) valid.Add(before);
                        break;
                    }
                    valid.Add(t);
                }
                node.MoveTo = valid.Count > 0 ? string.Join(", ", valid) : (parts.Count > 0 ? parts[0].Trim() : null);
            }
        }
        return node;
    }

    public override object? VisitPerformStatement(Cobol85AcuParser.PerformStatementContext context)
    {
        var procStmt = context.performProcedureStatement();
        if (procStmt == null)
        {
            // inline PERFORM（PERFORM ... END-PERFORM）
            var inlineNode = new PerformStatement { Text = GetSourceSlice(context), PerformInline = true };
            var inline = context.performInlineStatement();
            var typeCtx = inline?.performType();
            if (typeCtx != null)
            {
                if (typeCtx.performTimes() != null)
                    inlineNode.PerformType = "TIMES";
                else if (typeCtx.performUntil() != null)
                {
                    inlineNode.PerformType = "UNTIL";
                    var until = typeCtx.performUntil();
                    var cond = until?.condition();
                    if (cond != null)
                        inlineNode.PerformUntilCondition = GetText(cond);
                }
                else if (typeCtx.performVarying() != null)
                {
                    inlineNode.PerformType = "VARYING";
                }
            }
            if (inline != null)
            {
                var stmts = inline.statement();
                var stmtList = BuildChildStatements(stmts);
                if (stmtList != null && stmtList.Count > 0)
                    inlineNode.PerformStatements = stmtList;
                if (inline.END_PERFORM() != null)
                    inlineNode.PerformBlockEnd = "END-PERFORM";
            }
            return inlineNode;
        }
        // 段落 PERFORM（PERFORM 段落 [THRU 段落] [TIMES/UNTIL/VARYING]）
        var node = new PerformStatement { Text = GetSourceSlice(context), PerformInline = false };
        var names = procStmt.procedureName();
        if (names != null && names.Length > 0)
        {
            node.PerformTarget = GetText(names[0]);
            if (names.Length > 1)
                node.PerformThru = GetText(names[1]);
        }
        var procType = procStmt.performType();
        if (procType != null)
        {
            if (procType.performTimes() != null)
                node.PerformType = "TIMES";
            else if (procType.performUntil() != null)
            {
                node.PerformType = "UNTIL";
                var until = procType.performUntil();
                var cond = until?.condition();
                if (cond != null)
                    node.PerformUntilCondition = GetText(cond);
            }
            else if (procType.performVarying() != null)
            {
                node.PerformType = "VARYING";
            }
        }
        return node;
    }

    public override object? VisitCallStatement(Cobol85AcuParser.CallStatementContext context)
    {
        var node = new CallStatement { Text = GetSourceSlice(context) };
        var id = context.identifier();
        if (id != null)
            node.CallTarget = GetText(id);
        else
        {
            var lit = context.literal();
            if (lit != null)
                node.CallTarget = GetText(lit)?.Trim('"');
        }
        var usingPhrase = context.callUsingPhrase();
        if (usingPhrase?.callUsingParameter() != null)
        {
            var args = new List<string>();
            foreach (var param in usingPhrase.callUsingParameter())
            {
                // 拆解 BY REFERENCE/BY VALUE/BY CONTENT 內的每一個 callByReference/Value/Content，逐一擷取 identifier/literal/fileName
                if (param.callByReferencePhrase() is { } byRef)
                {
                    foreach (var cref in byRef.callByReference())
                    {
                        var argId = cref.identifier();
                        var lit = cref.literal();
                        var fn = cref.fileName();
                        string? t = null;
                        if (argId != null) t = GetText(argId);
                        else if (lit != null) t = GetText(lit);
                        else if (fn != null) t = GetText(fn);
                        if (!string.IsNullOrWhiteSpace(t))
                            args.Add(t!);
                    }
                }
                else if (param.callByValuePhrase() is { } byVal)
                {
                    foreach (var v in byVal.callByValue())
                    {
                        var argId = v.identifier();
                        var lit = v.literal();
                        string? t = null;
                        if (argId != null) t = GetText(argId);
                        else if (lit != null) t = GetText(lit);
                        if (!string.IsNullOrWhiteSpace(t))
                            args.Add(t!);
                    }
                }
                else if (param.callByContentPhrase() is { } byCont)
                {
                    foreach (var c in byCont.callByContent())
                    {
                        var argId = c.identifier();
                        var lit = c.literal();
                        string? t = null;
                        if (argId != null) t = GetText(argId);
                        else if (lit != null) t = GetText(lit);
                        if (!string.IsNullOrWhiteSpace(t))
                            args.Add(t!);
                    }
                }
            }
            if (args.Count > 0)
                node.CallArgs = args;
        }
        return node;
    }

    public override object? VisitOpenStatement(Cobol85AcuParser.OpenStatementContext context)
    {
        var node = new OpenStatement { Text = GetSourceSlice(context) };
        var targets = new List<string>();
        string? openType = null;

        // OPEN INPUT ...
        var inputStmts = context.openInputStatement();
        if (inputStmts != null)
        {
            foreach (var s in inputStmts)
            {
                openType ??= "INPUT";
                foreach (var oi in s.openInput())
                {
                    var fn = oi.fileName();
                    var name = GetText(fn);
                    if (!string.IsNullOrEmpty(name))
                        targets.Add(name!);
                }
            }
        }

        // OPEN OUTPUT ...
        var outputStmts = context.openOutputStatement();
        if (outputStmts != null)
        {
            foreach (var s in outputStmts)
            {
                openType ??= "OUTPUT";
                foreach (var oo in s.openOutput())
                {
                    var fn = oo.fileName();
                    var name = GetText(fn);
                    if (!string.IsNullOrEmpty(name))
                        targets.Add(name!);
                }
            }
        }

        // OPEN I-O ...
        var ioStmts = context.openIOStatement();
        if (ioStmts != null)
        {
            foreach (var s in ioStmts)
            {
                openType ??= "I-O";
                var fns = s.fileName();
                if (fns != null)
                {
                    foreach (var fn in fns)
                    {
                        var name = GetText(fn);
                        if (!string.IsNullOrEmpty(name))
                            targets.Add(name!);
                    }
                }
            }
        }

        // OPEN EXTEND ...
        var extStmts = context.openExtendStatement();
        if (extStmts != null)
        {
            foreach (var s in extStmts)
            {
                openType ??= "EXTEND";
                var fns = s.fileName();
                if (fns != null)
                {
                    foreach (var fn in fns)
                    {
                        var name = GetText(fn);
                        if (!string.IsNullOrEmpty(name))
                            targets.Add(name!);
                    }
                }
            }
        }

        if (!string.IsNullOrEmpty(openType))
            node.OpenType = openType;
        if (targets.Count > 0)
            node.OpenTargets = targets;

        return node;
    }

    public override object? VisitCloseStatement(Cobol85AcuParser.CloseStatementContext context)
    {
        var node = new CloseStatement { Text = GetSourceSlice(context) };
        var closeFiles = context.closeFile();
        if (closeFiles != null && closeFiles.Length > 0)
        {
            var targets = new List<string>();
            foreach (var cf in closeFiles)
            {
                var fn = cf.fileName();
                var name = fn != null ? GetText(fn) : null;
                if (!string.IsNullOrEmpty(name))
                    targets.Add(name);
            }
            if (targets.Count > 0)
                node.CloseTargets = targets;
        }
        return node;
    }

    public override object? VisitInitializeStatement(Cobol85AcuParser.InitializeStatementContext context)
    {
        var node = new InitializeStatement { Text = GetSourceSlice(context) };
        var ids = context.identifier();
        if (ids != null && ids.Length > 0)
        {
            node.InitializeTargets = ids.Select(id => GetText(id)).Where(s => !string.IsNullOrEmpty(s)).Select(s => s!).ToList();
        }
        return node;
    }

    public override object? VisitReadStatement(Cobol85AcuParser.ReadStatementContext context)
    {
        var node = new ReadStatement { Text = GetSourceSlice(context) };
        var fileName = context.fileName();
        if (fileName != null)
            node.ReadTarget = GetText(fileName);
        node.ReadNext = context.NEXT() != null;
        var readInto = context.readInto();
        if (readInto?.identifier() != null)
            node.ReadInto = GetText(readInto.identifier());
        var readKey = context.readKey();
        if (readKey?.qualifiedDataName() != null)
            node.ReadKey = GetText(readKey.qualifiedDataName());
        return node;
    }

    public override object? VisitStartStatement(Cobol85AcuParser.StartStatementContext context)
    {
        var node = new StartStatement { Text = GetSourceSlice(context) };
        var fileName = context.fileName();
        if (fileName != null)
            node.StartTarget = GetText(fileName);
        var keyCtx = context.startKey();
        if (keyCtx != null)
        {
            var qdn = keyCtx.qualifiedDataName();
            if (qdn != null)
                node.StartKeyDataName = GetText(qdn);
            var keyText = keyCtx.GetText();
            if (!string.IsNullOrEmpty(node.StartKeyDataName) && !string.IsNullOrEmpty(keyText))
            {
                var idx = keyText.IndexOf(node.StartKeyDataName!, StringComparison.Ordinal);
                if (idx > 0)
                    node.StartKeyOperator = keyText[..idx].Trim();
            }
            else
                node.StartKeyOperator = keyText;
        }
        return node;
    }

    public override object? VisitIfStatement(Cobol85AcuParser.IfStatementContext context)
    {
        var node = new IfStatement { Text = GetSourceSlice(context) };
        var cond = context.condition();
        if (cond != null)
            node.IfCondition = GetSourceSlice(cond);
        var ifThen = context.ifThen();
        if (ifThen != null)
        {
            node.IfThenText = GetSourceSlice(ifThen);
            var thenStmts = ifThen.statement();
            var thenList = BuildChildStatements(thenStmts);
            if (thenList != null && thenList.Count > 0)
                node.ThenStatements = thenList;
            // 擷取 THEN 區塊中的註解行（以 *>
            // 開頭）
            var thenText = node.IfThenText;
            if (!string.IsNullOrEmpty(thenText))
            {
                var lines = thenText.Split(new[] { "\r\n", "\r", "\n" }, StringSplitOptions.None);
                var comments = new List<string>();
                foreach (var line in lines)
                {
                    var trimmed = line.TrimStart();
                    if (trimmed.StartsWith("*>", StringComparison.Ordinal))
                        comments.Add(trimmed);
                }
                if (comments.Count > 0)
                    node.IfThenComments = comments;
            }
        }
        var ifElse = context.ifElse();
        if (ifElse != null)
        {
            node.IfElseText = GetSourceSlice(ifElse);
            var elseStmts = ifElse.statement();
            var elseList = BuildChildStatements(elseStmts);
            if (elseList != null && elseList.Count > 0)
                node.ElseStatements = elseList;
        }
        if (context.END_IF() != null)
            node.IfBlockEnd = "END-IF";
        return node;
    }

    public override object? VisitEvaluateStatement(Cobol85AcuParser.EvaluateStatementContext context)
    {
        var node = new EvaluateStatement { Text = GetSourceSlice(context) };
        var selectCtx = context.evaluateSelect();
        if (selectCtx != null)
            node.EvaluateSubject = GetSourceSlice(selectCtx);
        var whenPhrases = context.evaluateWhenPhrase();
        if (whenPhrases != null && whenPhrases.Length > 0)
        {
            node.EvaluateWhenPhrases = new List<EvaluateWhenClause>();
            for (var i = 0; i < whenPhrases.Length; i++)
            {
                var phrase = whenPhrases[i];
                var clause = new EvaluateWhenClause { WhenConditions = new List<string>() };
                var whens = phrase.evaluateWhen();
                if (whens != null)
                {
                    for (var j = 0; j < whens.Length; j++)
                    {
                        var cond = whens[j].evaluateCondition();
                        if (cond != null)
                            clause.WhenConditions.Add(GetSourceSlice(cond) ?? "");
                    }
                }
                clause.Statements = BuildChildStatements(phrase.statement());
                node.EvaluateWhenPhrases.Add(clause);
            }
        }
        var whenOther = context.evaluateWhenOther();
        if (whenOther != null)
        {
            var otherList = BuildChildStatements(whenOther.statement());
            if (otherList != null && otherList.Count > 0)
                node.EvaluateWhenOtherStatements = otherList;
        }
        if (context.END_EVALUATE() != null)
            node.EvaluateBlockEnd = "END-EVALUATE";
        NormalizeEvaluateBlockStatements(node);
        return node;
    }

    /// <summary>修正 EVALUATE 內因 COBOL 續行而誤併的 statement：續行導致 \" WHEN 901\"、\" WHEN OTHER\" 被併入上一句 MOVE，此函數截斷 Text 並修正 moveTo。</summary>
    private static void NormalizeEvaluateBlockStatements(EvaluateStatement evaluateNode)
    {
        if (evaluateNode.EvaluateWhenPhrases != null)
        {
            foreach (var clause in evaluateNode.EvaluateWhenPhrases)
            {
                if (clause.Statements == null) continue;
                foreach (var stmt in clause.Statements)
                    FixStatementTruncateAtWhen(stmt);
            }
        }
        if (evaluateNode.EvaluateWhenOtherStatements != null)
        {
            foreach (var stmt in evaluateNode.EvaluateWhenOtherStatements)
                FixStatementTruncateAtWhen(stmt);
        }
    }

    /// <summary>若 statement.Text 含換行後接空白與 WHEN（如 WHEN 901、WHEN OTHER），截斷至該處並修正 MOVE 的 moveTo。</summary>
    internal static void FixStatementTruncateAtWhen(StatementNode stmt)
    {
        var text = stmt.Text;
        if (string.IsNullOrEmpty(text)) return;
        var match = System.Text.RegularExpressions.Regex.Match(text, @"(?:\r\n|\n|\r)\s+WHEN\b", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
        if (!match.Success) return;
        var whenIdx = match.Index;
        var truncated = text.Substring(0, whenIdx).TrimEnd();
        if (truncated.IndexOf('\r') >= 0 || truncated.IndexOf('\n') >= 0)
            truncated = truncated.Split(new[] { "\r\n", "\n", "\r" }, StringSplitOptions.None)[0].Trim();
        stmt.Text = truncated;
        if (stmt is not MoveStatement moveStmt || string.IsNullOrEmpty(moveStmt.MoveTo)) return;
        var moveTo = moveStmt.MoveTo;
        var firstComma = moveTo.IndexOf(',');
        if (firstComma >= 0) moveTo = moveTo.Substring(0, firstComma).Trim();
        var whenInTo = moveTo.IndexOf("WHEN", StringComparison.OrdinalIgnoreCase);
        if (whenInTo >= 0) moveTo = moveTo.Substring(0, whenInTo).Trim();
        var otherInTo = moveTo.IndexOf("OTHER", StringComparison.OrdinalIgnoreCase);
        if (otherInTo >= 0) moveTo = moveTo.Substring(0, otherInTo).Trim();
        if (moveTo.Contains("message", StringComparison.OrdinalIgnoreCase) || moveTo.Contains("user-defined", StringComparison.OrdinalIgnoreCase))
        {
            var msgIdx = moveTo.IndexOf("message", StringComparison.OrdinalIgnoreCase);
            if (msgIdx > 0) moveTo = moveTo.Substring(0, msgIdx).Trim().TrimEnd(',', ' ');
            var udIdx = moveTo.IndexOf("user-defined", StringComparison.OrdinalIgnoreCase);
            if (udIdx > 0) moveTo = moveTo.Substring(0, udIdx).Trim().TrimEnd(',', ' ');
        }
        if (!string.IsNullOrEmpty(moveTo))
            moveStmt.MoveTo = moveTo;
    }

    /// <summary>走訪整個 PROCEDURE 樹，對所有 StatementNode（含段落層級與巢狀 EVALUATE/IF）套用續行誤併修正。單一入口，確保 WHEN 901 / WHEN OTHER 被截斷。</summary>
    public static void NormalizeAllProcedureStatements(DivisionNode? procedure)
    {
        if (procedure?.Children == null) return;
        foreach (var child in procedure.Children)
        {
            if (child is ParagraphNode para && para.Statements != null)
            {
                foreach (var stmt in para.Statements)
                    NormalizeStatementRecursive(stmt);
            }
        }
    }

    private static void NormalizeStatementRecursive(StatementNode stmt)
    {
        if (stmt == null) return;
        FixStatementTruncateAtWhen(stmt);
        if (stmt is AcceptStatement acceptStmt)
            EnrichAcceptFromText(acceptStmt);
        if (stmt is DisplayStatement displayStmt)
        {
            EnrichDisplayFromText(displayStmt);
            EnrichDisplayProperties(displayStmt);
        }
        if (stmt is IfStatement ifStmt)
        {
            if (ifStmt.ThenStatements != null) foreach (var s in ifStmt.ThenStatements) NormalizeStatementRecursive(s);
            if (ifStmt.ElseStatements != null) foreach (var s in ifStmt.ElseStatements) NormalizeStatementRecursive(s);
        }
        if (stmt is PerformStatement perfStmt)
        {
            if (perfStmt.PerformStatements != null) foreach (var s in perfStmt.PerformStatements) NormalizeStatementRecursive(s);
        }
        if (stmt is EvaluateStatement evalStmt)
        {
            if (evalStmt.EvaluateWhenPhrases != null)
            {
                foreach (var clause in evalStmt.EvaluateWhenPhrases)
                    if (clause.Statements != null) foreach (var s in clause.Statements) NormalizeStatementRecursive(s);
            }
            if (evalStmt.EvaluateWhenOtherStatements != null)
                foreach (var s in evalStmt.EvaluateWhenOtherStatements) NormalizeStatementRecursive(s);
        }
    }

    /// <summary>當文法無法解析 ACCEPT FROM ENVIRONMENT literal 時，從 Text 以 regex 擷取 AcceptTarget、AcceptFromEnvironment、AcceptBlockEnd。</summary>
    internal static void EnrichAcceptFromText(AcceptStatement stmt)
    {
        if (stmt?.Text == null) return;
        var text = stmt.Text;
        if (string.IsNullOrEmpty(stmt.AcceptTarget) || string.IsNullOrEmpty(stmt.AcceptFromEnvironment))
        {
            var m = System.Text.RegularExpressions.Regex.Match(text,
                @"ACCEPT\s+(\S+)\s+FROM\s+ENVIRONMENT\s+""([^""]+)""",
                System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            if (m.Success)
            {
                if (string.IsNullOrEmpty(stmt.AcceptTarget)) stmt.AcceptTarget = m.Groups[1].Value.Trim();
                if (string.IsNullOrEmpty(stmt.AcceptFromEnvironment)) stmt.AcceptFromEnvironment = m.Groups[2].Value.Trim();
            }
        }
        if (string.IsNullOrEmpty(stmt.AcceptBlockEnd) && text.Contains("END-ACCEPT", StringComparison.OrdinalIgnoreCase))
            stmt.AcceptBlockEnd = "END-ACCEPT";
    }

    /// <summary>從 DISPLAY 語句 Text 擷取 DisplayUpon、DisplayOperands、DisplayBlockEnd（區塊以 . 或 END-DISPLAY 結束）。</summary>
    internal static void EnrichDisplayFromText(DisplayStatement stmt)
    {
        if (stmt?.Text == null) return;
        var text = stmt.Text;
        if (string.IsNullOrEmpty(stmt.DisplayUpon))
        {
            var mUpon = System.Text.RegularExpressions.Regex.Match(text, @"UPON\s+([^\s.]+)", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            if (mUpon.Success)
                stmt.DisplayUpon = mUpon.Groups[1].Value.Trim().TrimEnd('.');
        }
        if (stmt.DisplayOperands == null || stmt.DisplayOperands.Count == 0)
        {
            var mOperands = System.Text.RegularExpressions.Regex.Match(text, @"DISPLAY\s+(.+?)(?:\s+UPON\s|\s+AT\s|$)", System.Text.RegularExpressions.RegexOptions.IgnoreCase | System.Text.RegularExpressions.RegexOptions.Singleline);
            if (mOperands.Success)
            {
                var part = mOperands.Groups[1].Value.Trim();
                if (!string.IsNullOrEmpty(part))
                {
                    var tokens = System.Text.RegularExpressions.Regex.Split(part, @"\s+").Where(s => !string.IsNullOrEmpty(s)).ToList();
                    if (tokens.Count > 0)
                    {
                        var dict = new Dictionary<string, string>();
                        for (int i = 0; i < tokens.Count; i++)
                            dict[i.ToString()] = tokens[i];
                        stmt.DisplayOperands = dict;
                    }
                }
            }
        }
        if (string.IsNullOrEmpty(stmt.DisplayBlockEnd) && text.Contains("END-DISPLAY", StringComparison.OrdinalIgnoreCase))
            stmt.DisplayBlockEnd = "END-DISPLAY";
        else if (string.IsNullOrEmpty(stmt.DisplayBlockEnd) && (text.TrimEnd().EndsWith(".", StringComparison.Ordinal) || text.TrimEnd().EndsWith(".\r\n", StringComparison.Ordinal)))
            stmt.DisplayBlockEnd = ".";
    }

    /// <summary>從 DISPLAY 語句文字解析擴充語法屬性（LINES, SIZE, COLOR, TITLE, HANDLE 等）</summary>
    internal static void EnrichDisplayProperties(DisplayStatement stmt)
    {
        if (stmt?.Text == null) return;
        var text = stmt.Text;
        
        // 解析 WINDOW 類型（Floating、GRAPHICAL 等）
        var mWindow = System.Text.RegularExpressions.Regex.Match(text, @"DISPLAY\s+(\w+)\s+WINDOW", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
        if (mWindow.Success)
        {
            stmt.DisplayType = mWindow.Groups[1].Value;
            stmt.DisplayWindow = "WINDOW";
        }
        
        // 解析 LINES
        var mLines = System.Text.RegularExpressions.Regex.Match(text, @"LINES\s+([\d.]+)", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
        if (mLines.Success) stmt.DisplayLines = mLines.Groups[1].Value;
        
        // 解析 SIZE
        var mSize = System.Text.RegularExpressions.Regex.Match(text, @"SIZE\s+([\d.]+)", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
        if (mSize.Success) stmt.DisplaySize = mSize.Groups[1].Value;
        
        // 解析 CELL HEIGHT
        var mCellHeight = System.Text.RegularExpressions.Regex.Match(text, @"CELL\s+HEIGHT\s+(\d+)", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
        if (mCellHeight.Success) stmt.DisplayCellHeight = mCellHeight.Groups[1].Value;
        
        // 解析 CELL WIDTH
        var mCellWidth = System.Text.RegularExpressions.Regex.Match(text, @"CELL\s+WIDTH\s+(\d+)", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
        if (mCellWidth.Success) stmt.DisplayCellWidth = mCellWidth.Groups[1].Value;
        
        // 解析 COLOR IS
        var mColor = System.Text.RegularExpressions.Regex.Match(text, @"COLOR\s+IS\s+(\d+)", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
        if (mColor.Success) stmt.DisplayColor = mColor.Groups[1].Value;
        
        // 解析 LABEL-OFFSET
        var mLabelOffset = System.Text.RegularExpressions.Regex.Match(text, @"LABEL-OFFSET\s+(\d+)", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
        if (mLabelOffset.Success) stmt.DisplayLabelOffset = mLabelOffset.Groups[1].Value;
        
        // 解析 LINK TO
        var mLinkTo = System.Text.RegularExpressions.Regex.Match(text, @"LINK\s+TO\s+(\w+)", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
        if (mLinkTo.Success) stmt.DisplayLinkTo = mLinkTo.Groups[1].Value;
        
        // 解析 NO SCROLL
        if (System.Text.RegularExpressions.Regex.IsMatch(text, @"NO\s+SCROLL", System.Text.RegularExpressions.RegexOptions.IgnoreCase))
            stmt.DisplayNoScroll = true;
        
        // 解析 TITLE
        var mTitle = System.Text.RegularExpressions.Regex.Match(text, @"TITLE\s+([^\s,]+)", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
        if (mTitle.Success) stmt.DisplayTitle = mTitle.Groups[1].Value;
        
        // 解析 TITLE-BAR
        if (System.Text.RegularExpressions.Regex.IsMatch(text, @"TITLE-BAR", System.Text.RegularExpressions.RegexOptions.IgnoreCase))
            stmt.DisplayTitleBar = true;
        
        // 解析 NO WRAP
        if (System.Text.RegularExpressions.Regex.IsMatch(text, @"NO\s+WRAP", System.Text.RegularExpressions.RegexOptions.IgnoreCase))
            stmt.DisplayNoWrap = true;
        
        // 解析 HANDLE IS
        var mHandle = System.Text.RegularExpressions.Regex.Match(text, @"HANDLE\s+IS\s+([^\s.]+)", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
        if (mHandle.Success) stmt.DisplayHandle = mHandle.Groups[1].Value;
    }

    public override object? VisitStringStatement(Cobol85AcuParser.StringStatementContext context)
    {
        var node = new StringStatement { Text = GetSourceSlice(context) };
        var intoPhrase = context.stringIntoPhrase();
        if (intoPhrase?.identifier() != null)
            node.StringInto = GetText(intoPhrase.identifier());
        var ptrPhrase = context.stringWithPointerPhrase();
        if (ptrPhrase?.qualifiedDataName() != null)
            node.StringPointer = GetText(ptrPhrase.qualifiedDataName());
        return node;
    }

    public override object? VisitAcceptStatement(Cobol85AcuParser.AcceptStatementContext context)
    {
        var node = new AcceptStatement { Text = GetSourceSlice(context) };
        var id = context.identifier();
        if (id != null)
            node.AcceptTarget = GetText(id);
        if (context.END_ACCEPT() != null)
            node.AcceptBlockEnd = "END-ACCEPT";
        var envStmt = context.acceptFromEnvironmentStatement();
        if (envStmt != null)
        {
            // FROM ENVIRONMENT "literal" or FROM ENVIRONMENT identifier
            var envArg = envStmt.literal() != null ? GetText(envStmt.literal()) : envStmt.identifier() != null ? GetText(envStmt.identifier()) : null;
            if (envArg != null)
                node.AcceptFromEnvironment = envArg.Trim('"', '\'');
        }
        else
        {
            var mnemonic = context.acceptFromMnemonicStatement();
            if (mnemonic?.mnemonicName() != null)
            {
                node.AcceptFromEnvironment = GetText(mnemonic.mnemonicName());
            }
        }
        return node;
    }

    public override object? VisitDisplayStatement(Cobol85AcuParser.DisplayStatementContext context)
    {
        // 取得完整語句文字：從 DISPLAY 開始位置向後查找句點，取得完整範圍（處理擴充語法如 LINES、SIZE 等）
        string? fullText = null;
        if (_cobolSource != null && context.Start != null)
        {
            var startIdx = context.Start.StartIndex;
            if (startIdx >= 0 && startIdx < _cobolSource.Length)
            {
                // 從 DISPLAY 開始位置向後查找句點（跳過註解行）
                var searchStart = startIdx;
                var periodIdx = -1;
                while (searchStart < _cobolSource.Length)
                {
                    periodIdx = _cobolSource.IndexOf('.', searchStart);
                    if (periodIdx < 0) break;
                    
                    // 檢查句點後是否為行尾（換行、檔案結尾，或空白後換行）
                    var afterPeriod = periodIdx + 1;
                    var isLineEnd = false;
                    if (afterPeriod >= _cobolSource.Length)
                    {
                        isLineEnd = true; // 檔案結尾
                    }
                    else
                    {
                        var afterText = _cobolSource.Substring(afterPeriod, Math.Min(10, _cobolSource.Length - afterPeriod));
                        // 句點後是換行，或空白後換行，視為行尾
                        if (afterText.Length > 0 && (afterText[0] == '\r' || afterText[0] == '\n'))
                            isLineEnd = true;
                        else if (afterText.Length > 1 && char.IsWhiteSpace(afterText[0]) && (afterText[1] == '\r' || afterText[1] == '\n'))
                            isLineEnd = true;
                    }
                    
                    if (isLineEnd)
                    {
                        // 檢查句點所在行是否為註解行（*> 或 * 在行首）
                        var beforeStart = Math.Max(0, periodIdx - 200);
                        var beforePeriod = _cobolSource.Substring(beforeStart, periodIdx - beforeStart);
                        var lastNewline = beforePeriod.LastIndexOfAny(new[] { '\r', '\n' });
                        if (lastNewline >= 0)
                        {
                            var lineStart = beforeStart + lastNewline + 1;
                            var lineText = _cobolSource.Substring(lineStart, periodIdx - lineStart).TrimStart();
                            // 若句點所在行以 *> 或 * 開頭（註解），繼續查找
                            if (lineText.StartsWith("*>", StringComparison.Ordinal) || 
                                (lineText.StartsWith("*", StringComparison.Ordinal) && !lineText.StartsWith("**", StringComparison.Ordinal)))
                            {
                                searchStart = periodIdx + 1;
                                continue;
                            }
                        }
                        // 找到語句結束句點，取得完整文字
                        fullText = _cobolSource.Substring(startIdx, periodIdx - startIdx + 1).Trim();
                        break;
                    }
                    // 不是行尾句點（可能是小數點），繼續查找
                    searchStart = periodIdx + 1;
                }
            }
        }
        
        // 若無法從原始文字取得，嘗試從 SentenceContext 取得
        if (string.IsNullOrEmpty(fullText))
        {
            var current = context.Parent;
            while (current != null && fullText == null)
            {
                if (current is Cobol85AcuParser.SentenceContext sentCtx)
                {
                    fullText = GetSourceSlice(sentCtx);
                    break;
                }
                current = current.Parent;
            }
        }
        
        // 最後回退到 displayStatement context
        if (string.IsNullOrEmpty(fullText))
        {
            if (context.Parent is Cobol85AcuParser.StatementContext stmtCtx)
                fullText = GetSourceSlice(stmtCtx);
            if (string.IsNullOrEmpty(fullText))
                fullText = GetSourceSlice(context);
        }
        
        var node = new DisplayStatement { Text = fullText };
        var operands = context.displayOperand();
        if (operands != null && operands.Length > 0)
        {
            var dict = new Dictionary<string, string>();
            var idx = 0;
            foreach (var op in operands)
            {
                var text = GetText(op);
                if (!string.IsNullOrEmpty(text))
                    dict[idx++.ToString()] = text;
            }
            if (dict.Count > 0) node.DisplayOperands = dict;
        }
        var upon = context.displayUpon();
        if (upon != null)
            node.DisplayUpon = GetText(upon);
        var at = context.displayAt();
        if (at != null)
            node.DisplayAt = GetText(at);
        var with = context.displayWith();
        if (with != null)
            node.DisplayWith = GetText(with);
        return node;
    }

    public override object? VisitInspectStatement(Cobol85AcuParser.InspectStatementContext context)
    {
        var node = new InspectStatement { Text = GetSourceSlice(context) };
        if (context.identifier() != null)
            node.InspectTarget = GetText(context.identifier());
        var tallying = context.inspectTallyingPhrase();
        if (tallying != null)
        {
            var fors = tallying.inspectFor();
            if (fors != null && fors.Length > 0)
            {
                var first = fors[0];
                if (first.identifier() != null)
                    node.InspectTallying = GetText(first.identifier());
                var slice = GetSourceSlice(first);
                if (!string.IsNullOrEmpty(slice))
                {
                    var forIdx = slice.IndexOf("FOR", StringComparison.OrdinalIgnoreCase);
                    node.InspectTallyingFor = forIdx >= 0 ? slice.Substring(forIdx + 3).Trim() : slice;
                }
            }
        }
        return node;
    }

    public override object? VisitAcuCreateStatement(Cobol85AcuParser.AcuCreateStatementContext context)
    {
        var id = context.identifier();
        var name = id?.Length > 0 ? GetText(id[0]) : "";
        return new SimpleStatement("CREATE") { Text = GetSourceSlice(context) };
    }

    public override object? VisitAcuModifyStatement(Cobol85AcuParser.AcuModifyStatementContext context)
    {
        return new SimpleStatement("MODIFY") { Text = GetSourceSlice(context) };
    }

    public override object? VisitAcuInquireStatement(Cobol85AcuParser.AcuInquireStatementContext context)
    {
        return new SimpleStatement("INQUIRE") { Text = GetSourceSlice(context) };
    }

    public override object? VisitAcuDestroyStatement(Cobol85AcuParser.AcuDestroyStatementContext context)
    {
        return new SimpleStatement("DESTROY") { Text = GetSourceSlice(context) };
    }

    private static string GetStatementType(Cobol85AcuParser.StatementContext ctx)
    {
        if (ctx.moveStatement() != null) return "MOVE";
        if (ctx.displayStatement() != null) return "DISPLAY";
        if (ctx.callStatement() != null) return "CALL";
        if (ctx.performStatement() != null) return "PERFORM";
        if (ctx.ifStatement() != null) return "IF";
        if (ctx.evaluateStatement() != null) return "EVALUATE";
        if (ctx.openStatement() != null) return "OPEN";
        if (ctx.closeStatement() != null) return "CLOSE";
        if (ctx.readStatement() != null) return "READ";
        if (ctx.writeStatement() != null) return "WRITE";
        if (ctx.rewriteStatement() != null) return "REWRITE";
        if (ctx.initializeStatement() != null) return "INITIALIZE";
        if (ctx.startStatement() != null) return "START";
        if (ctx.gobackStatement() != null) return "GOBACK";
        if (ctx.stopStatement() != null) return "STOP";
        if (ctx.computeStatement() != null) return "COMPUTE";
        if (ctx.stringStatement() != null) return "STRING";
        if (ctx.acceptStatement() != null) return "ACCEPT";
        if (ctx.acuCreateStatement() != null) return "CREATE";
        if (ctx.acuModifyStatement() != null) return "MODIFY";
        if (ctx.acuInquireStatement() != null) return "INQUIRE";
        if (ctx.acuDestroyStatement() != null) return "DESTROY";
        if (ctx.exitStatement() != null) return "EXIT";
        if (ctx.addStatement() != null) return "ADD";
        if (ctx.continueStatement() != null) return "CONTINUE";
        if (ctx.goToStatement() != null) return "GOTO";
        if (ctx.searchStatement() != null) return "SEARCH";
        if (ctx.cancelStatement() != null) return "CANCEL";
        if (ctx.deleteStatement() != null) return "DELETE";
        if (ctx.inspectStatement() != null) return "INSPECT";
        if (ctx.setStatement() != null) return "SET";
        return "OTHER";
    }

    private static string? GetText(IParseTree? node) => node?.GetText()?.Trim();

    /// <summary>從原始 COBOL 文字中擷取指定 parse context 的原始片段（含空白），用於 StatementNode.Text。</summary>
    private string? GetSourceSlice(ParserRuleContext? context)
    {
        if (context == null || _cobolSource == null)
            return context?.GetText();
        var start = context.Start;
        var stop = context.Stop;
        if (start == null || stop == null)
            return context.GetText();
        var s = start.StartIndex;
        var e = stop.StopIndex;
        if (s < 0 || e < 0 || e < s || e >= _cobolSource.Length)
            return context.GetText();
        return _cobolSource.Substring(s, e - s + 1).Trim();
    }

    /// <summary>將一組 StatementContext 轉成 StatementNode 巢狀清單。</summary>
    private List<StatementNode>? BuildChildStatements(Cobol85AcuParser.StatementContext[]? statements)
    {
        if (statements == null || statements.Length == 0)
            return null;
        var list = new List<StatementNode>();
        foreach (var stmt in statements)
        {
            var result = Visit(stmt);
            if (result is StatementNode sn)
                list.Add(sn);
        }
        return list.Count == 0 ? null : list;
    }

    private static string? GetOrganizationValue(Cobol85AcuParser.OrganizationClauseContext ctx)
    {
        if (ctx.INDEXED() != null) return "INDEXED";
        if (ctx.SEQUENTIAL() != null) return "SEQUENTIAL";
        if (ctx.RELATIVE() != null) return "RELATIVE";
        return null;
    }

    private static string? GetAccessModeValue(Cobol85AcuParser.AccessModeClauseContext ctx)
    {
        if (ctx.DYNAMIC() != null) return "DYNAMIC";
        if (ctx.SEQUENTIAL() != null) return "SEQUENTIAL";
        if (ctx.RANDOM() != null) return "RANDOM";
        if (ctx.EXCLUSIVE() != null) return "EXCLUSIVE";
        return null;
    }

    private static string? GetLockModeValue(Cobol85AcuParser.AcuLockModeClauseContext ctx)
    {
        if (ctx.MANUAL() != null) return "MANUAL";
        if (ctx.AUTOMATIC() != null) return "AUTOMATIC";
        if (ctx.EXCLUSIVE() != null) return "EXCLUSIVE";
        return null;
    }

    /// <summary>從 ASSIGN 子句取出實際指定值（如 HG_MNID），引號會去除。</summary>
    private static string? GetAssignToValue(Cobol85AcuParser.AssignClauseContext assign)
    {
        var lit = assign.literal();
        if (lit != null)
        {
            var t = GetText(lit);
            return UnquoteLiteral(t);
        }
        var name = assign.assignmentName();
        if (name != null)
            return GetText(name);
        // 若 parser 未分出 literal/assignmentName，從整段文字擷取引號內或最後一段
        var full = GetText(assign);
        if (string.IsNullOrEmpty(full)) return null;
        var q = full.IndexOf('"');
        if (q >= 0)
        {
            var end = full.IndexOf('"', q + 1);
            if (end > q)
                return full[(q + 1)..end];
        }
        return full;
    }

    private static string? UnquoteLiteral(string? t)
    {
        if (string.IsNullOrEmpty(t)) return t;
        t = t.Trim();
        if (t.Length >= 2 && t[0] == '"' && t[^1] == '"')
            return t[1..^1];
        if (t.Length >= 2 && t[0] == '\'' && t[^1] == '\'')
            return t[1..^1];
        return t;
    }

    /// <summary>從 VALUE 子句取第一個區間的實際值，供 78/88 使用（如 VALUE 1 → "1", VALUE ZERO → "0"）。</summary>
    private static string? GetRealValueFromValueClause(Cobol85AcuParser.DataValueClauseContext clause)
    {
        var intervals = clause.dataValueInterval();
        if (intervals == null || intervals.Length == 0) return null;
        var from = intervals[0].dataValueIntervalFrom();
        if (from == null) return null;
        var raw = GetText(from);
        return string.IsNullOrEmpty(raw) ? null : NormalizeFigurativeConstant(raw);
    }

    private static string NormalizeFigurativeConstant(string text)
    {
        var s = text.Trim();
        if (s.Length == 0) return s;
        var u = s.ToUpperInvariant();
        if (u == "ZERO" || u == "ZEROS" || u == "ZEROES") return "0";
        if (u == "SPACE" || u == "SPACES") return " ";
        if (u == "HIGH-VALUE" || u == "HIGH-VALUES") return "HIGH-VALUE";
        if (u == "LOW-VALUE" || u == "LOW-VALUES") return "LOW-VALUE";
        return s;
    }

}
