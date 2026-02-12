/*
 * 更新時間：2026-02-11
 * 作者：AI Assistant
 * 摘要：DISPLAY 新增結構化屬性：DisplayType, DisplayLines, DisplaySize, DisplayCellHeight, DisplayCellWidth, DisplayColor, DisplayLabelOffset, DisplayLinkTo, DisplayNoScroll, DisplayTitle, DisplayTitleBar, DisplayNoWrap, DisplayHandle
 *
 * 更新時間：2026-02-11
 * 作者：AI Assistant
 * 摘要：DISPLAY DisplayOperands 改為 Dictionary<string, string>（key-value 物件，key 為索引字串如 "0", "1", "2"）
 *
 * 更新時間：2026-02-11
 * 作者：AI Assistant
 * 摘要：DISPLAY 新增 DisplayOperands、DisplayUpon、DisplayAt、DisplayWith、DisplayBlockEnd（區塊以 . 或 END-DISPLAY 結束）
 *
 * 更新時間：2026-02-11
 * 作者：AI Assistant
 * 摘要：ACCEPT 新增 AcceptTarget、AcceptFromEnvironment、AcceptBlockEnd（如 END-ACCEPT）
 *
 * 更新時間：2026-02-11
 * 作者：AI Assistant
 * 摘要：PERFORM inline 新增 PerformStatements（內嵌語句清單）、PerformBlockEnd（如 END-PERFORM）
 *
 * 更新時間：2026-02-11
 * 作者：AI Assistant
 * 摘要：IF 新增 IfBlockEnd（如 END-IF），與 EVALUATE 的 EvaluateBlockEnd 同結構
 *
 * 更新時間：2026-02-11
 * 作者：AI Assistant
 * 摘要：StatementNode 使用 StatementNodeJsonConverter，僅在 type=PERFORM 時輸出 performInline、type=READ 時輸出 readNext
 *
 * 更新時間：2026-02-11
 * 作者：AI Assistant
 * 摘要：EVALUATE 新增 EvaluateBlockEnd；STRING 新增 StringInto、StringPointer；INSPECT 新增 InspectTarget、InspectTallying、InspectTallyingFor
 *
 * 更新時間：2026-02-11
 * 作者：AI Assistant
 * 摘要：EVALUATE 新增 EvaluateSubject、EvaluateWhenPhrases、EvaluateWhenOtherStatements，與 IF 同為區塊結構化語句
 *
 * 更新時間：2026-02-10
 * 作者：AI Assistant
 * 摘要：OPEN 新增 OpenType/OpenTargets；READ 新增 ReadKey；IF 新增 ThenStatements/ElseStatements 與 IfThenComments，支援巢狀語句 AST 結構與註解保留
 *
 * 更新時間：2026-02-10
 * 作者：AI Assistant
 * 摘要：CLOSE 新增 CloseTargets 陣列，明確列出被關閉的檔案清單
 *
 * 更新時間：2026-02-10
 * 作者：AI Assistant
 * 摘要：PERFORM 新增 PerformInline/PerformType/PerformUntilCondition，支援 PERFORM UNTIL / TIMES / VARYING 等資訊，讓語句更清楚
 *
 * 更新時間：2026-02-10
 * 作者：AI Assistant
 * 摘要：IF 新增 IfCondition/IfThenText/IfElseText 使語句清晰
 *
 * 更新時間：2026-02-10
 * 作者：AI Assistant
 * 摘要：INITIALIZE 改為 InitializeTargets 陣列；READ/START 新增結構化欄位（ReadTarget/ReadNext/ReadInto、StartTarget/StartKeyOperator/StartKeyDataName）使語句更清晰
 *
 * 更新時間：2026-02-10 18:00
 * 作者：AI Assistant
 * 摘要：新增結構化欄位供 PROCEDURE DIVISION 轉 C# 使用（MoveFrom/MoveTo、PerformTarget、CallTarget/CallArgs）
 *
 * 更新時間：2026-02-06
 * 作者：AI Assistant
 * 摘要：COBOL 語句節點（MOVE、CALL、IF、CREATE 等）
 */

namespace ConvertCobol.Models;

public class StatementNode : AstNode
{
    public string StatementType { get; set; } = "";
    public string? Text { get; set; }

    /// <summary>MOVE 來源（由 Visitor 填入或由 CodeGen 從 Text 解析）</summary>
    public string? MoveFrom { get; set; }
    /// <summary>MOVE 目標，多目標時以逗號分隔</summary>
    public string? MoveTo { get; set; }
    /// <summary>PERFORM 目標段落名（單一或 THRU 起點）</summary>
    public string? PerformTarget { get; set; }
    /// <summary>PERFORM THRU 終點段落名</summary>
    public string? PerformThru { get; set; }
    /// <summary>PERFORM 是否為 inline（有內嵌 statement* / END-PERFORM）</summary>
    public bool PerformInline { get; set; }
    /// <summary>PERFORM 類型：TIMES / UNTIL / VARYING 等（若有 performType）</summary>
    public string? PerformType { get; set; }
    /// <summary>PERFORM UNTIL 條件（若為 UNTIL）</summary>
    public string? PerformUntilCondition { get; set; }
    /// <summary>PERFORM inline 內嵌語句清單（PERFORM ... END-PERFORM 區塊內的 statement*）</summary>
    public List<StatementNode>? PerformStatements { get; set; }
    /// <summary>PERFORM inline 區塊結束關鍵字（如 END-PERFORM）</summary>
    public string? PerformBlockEnd { get; set; }
    /// <summary>CALL 被呼叫名（identifier 或 literal）</summary>
    public string? CallTarget { get; set; }
    /// <summary>CALL USING 參數列</summary>
    public List<string>? CallArgs { get; set; }

    /// <summary>ACCEPT 目標 identifier（如 W-YMD-YYCOM）</summary>
    public string? AcceptTarget { get; set; }
    /// <summary>ACCEPT FROM ENVIRONMENT 的環境變數 literal（如 ZS_SYCM）</summary>
    public string? AcceptFromEnvironment { get; set; }
    /// <summary>ACCEPT 區塊結束關鍵字（如 END-ACCEPT）</summary>
    public string? AcceptBlockEnd { get; set; }

    /// <summary>DISPLAY 運算元（key-value 物件，key 為運算元索引或屬性名稱，value 為運算元值）</summary>
    public Dictionary<string, string>? DisplayOperands { get; set; }
    /// <summary>DISPLAY UPON 目標（mnemonic 或 environment name）</summary>
    public string? DisplayUpon { get; set; }
    /// <summary>DISPLAY AT 位置（identifier 或 literal）</summary>
    public string? DisplayAt { get; set; }
    /// <summary>DISPLAY WITH 子句（如 NO ADVANCING）</summary>
    public string? DisplayWith { get; set; }
    /// <summary>DISPLAY 區塊結束：句點 . 或 END-DISPLAY</summary>
    public string? DisplayBlockEnd { get; set; }
    /// <summary>DISPLAY WINDOW 類型（如 Floating、GRAPHICAL）</summary>
    public string? DisplayType { get; set; }
    /// <summary>DISPLAY WINDOW 標記</summary>
    public string? DisplayWindow { get; set; }
    /// <summary>DISPLAY LINES 值</summary>
    public string? DisplayLines { get; set; }
    /// <summary>DISPLAY SIZE 值</summary>
    public string? DisplaySize { get; set; }
    /// <summary>DISPLAY CELL HEIGHT 值</summary>
    public string? DisplayCellHeight { get; set; }
    /// <summary>DISPLAY CELL WIDTH 值</summary>
    public string? DisplayCellWidth { get; set; }
    /// <summary>DISPLAY COLOR IS 值</summary>
    public string? DisplayColor { get; set; }
    /// <summary>DISPLAY LABEL-OFFSET 值</summary>
    public string? DisplayLabelOffset { get; set; }
    /// <summary>DISPLAY LINK TO 值</summary>
    public string? DisplayLinkTo { get; set; }
    /// <summary>DISPLAY NO SCROLL 標記</summary>
    public bool DisplayNoScroll { get; set; }
    /// <summary>DISPLAY TITLE 值</summary>
    public string? DisplayTitle { get; set; }
    /// <summary>DISPLAY TITLE-BAR 標記</summary>
    public bool DisplayTitleBar { get; set; }
    /// <summary>DISPLAY NO WRAP 標記</summary>
    public bool DisplayNoWrap { get; set; }
    /// <summary>DISPLAY HANDLE IS 值</summary>
    public string? DisplayHandle { get; set; }

    /// <summary>INITIALIZE 目標項（陣列，多個 identifier）</summary>
    public List<string>? InitializeTargets { get; set; }

    /// <summary>READ 檔案名稱</summary>
    public string? ReadTarget { get; set; }
    /// <summary>READ NEXT RECORD 是否為 NEXT</summary>
    public bool ReadNext { get; set; }
    /// <summary>READ INTO 目標 identifier</summary>
    public string? ReadInto { get; set; }
    /// <summary>READ KEY IS 後面的 key 名稱（如 HTCTM-KEY）</summary>
    public string? ReadKey { get; set; }

    /// <summary>OPEN 類型：INPUT / OUTPUT / I-O / EXTEND</summary>
    public string? OpenType { get; set; }
    /// <summary>OPEN 涉及的檔案清單</summary>
    public List<string>? OpenTargets { get; set; }

    /// <summary>START 檔案名稱</summary>
    public string? StartTarget { get; set; }
    /// <summary>START KEY 比較運算（如 NOT LESS THAN、EQUAL TO、GREATER THAN）</summary>
    public string? StartKeyOperator { get; set; }
    /// <summary>START KEY 的 qualifiedDataName</summary>
    public string? StartKeyDataName { get; set; }

    /// <summary>CLOSE 關閉的檔案列表</summary>
    public List<string>? CloseTargets { get; set; }

    /// <summary>IF 條件式（condition 子樹文字）</summary>
    public string? IfCondition { get; set; }
    /// <summary>IF THEN 區塊文字（statement* 或 NEXT SENTENCE）</summary>
    public string? IfThenText { get; set; }
    /// <summary>IF ELSE 區塊文字（若有）；無 ELSE 時為 null</summary>
    public string? IfElseText { get; set; }

    /// <summary>IF THEN 子語句清單（巢狀 AST）</summary>
    public List<StatementNode>? ThenStatements { get; set; }
    /// <summary>IF ELSE 子語句清單（巢狀 AST）</summary>
    public List<StatementNode>? ElseStatements { get; set; }
    /// <summary>IF 區塊結束關鍵字（如 END-IF）</summary>
    public string? IfBlockEnd { get; set; }
    /// <summary>IF THEN 區塊中的註解行（以 \"*>\"
    /// 開頭）</summary>
    public List<string>? IfThenComments { get; set; }

    /// <summary>EVALUATE 主體（evaluateSelect 來源文字，如 Acu-Msg-Id）</summary>
    public string? EvaluateSubject { get; set; }
    /// <summary>EVALUATE 各 WHEN 區塊（條件 + 語句）</summary>
    public List<EvaluateWhenClause>? EvaluateWhenPhrases { get; set; }
    /// <summary>EVALUATE WHEN OTHER 區塊內語句</summary>
    public List<StatementNode>? EvaluateWhenOtherStatements { get; set; }
    /// <summary>EVALUATE 區塊結束關鍵字（如 END-EVALUATE）</summary>
    public string? EvaluateBlockEnd { get; set; }

    /// <summary>STRING INTO 目標（identifier）</summary>
    public string? StringInto { get; set; }
    /// <summary>STRING POINTER 變數（qualifiedDataName）</summary>
    public string? StringPointer { get; set; }

    /// <summary>INSPECT 主體 identifier（被 INSPECT 的資料項）</summary>
    public string? InspectTarget { get; set; }
    /// <summary>INSPECT TALLYING 目標（計數項，如 Acu-Size）</summary>
    public string? InspectTallying { get; set; }
    /// <summary>INSPECT TALLYING FOR 後段文字（如 TRAILING SPACE）</summary>
    public string? InspectTallyingFor { get; set; }
}
