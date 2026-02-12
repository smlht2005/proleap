# EVALUATE 續行誤併修正 — 摘要（可複製至 Cursor 記憶/規則）

**更新時間：2026-02-11**

## 問題現象

- AST 中出現錯誤合併的 MOVE：
  - `"text": "MOVE Mb-Ok TO Acu-Button-Type\r\n user-defined message\r\n    WHEN 901"`
  - `"text": "MOVE Mb-Ok TO Acu-Button-Type\r\n    WHEN OTHER"`
- 預期：WHEN 901、WHEN OTHER 不應被併入上一句 MOVE，應正確切開。

## 根因

1. **COBOL 續行**：第 7 欄為空白時，該行會與上一行合併，parser 將整段當成一個 statement。
2. **AST 結構**：問題的兩筆 MOVE 在 AST 裡是**段落層級**的 `statements`（與 "MOVE \"Shell not found.\"" 等為兄弟），**不在** EVALUATE 的 `EvaluateWhenPhrases` / `EvaluateWhenOtherStatements` 底下。
3. **原先修正未涵蓋**：`NormalizeEvaluateBlockStatements` 只處理 EVALUATE **內部**的 when 區塊 statement，因此從未處理到這兩筆段落層級的 MOVE。

## 解法（單一函數處理整棵 Procedure）

- **單一入口**：`CobolAstVisitor.NormalizeAllProcedureStatements(DivisionNode? procedure)`
  - 走訪整個 PROCEDURE：每個 `ParagraphNode` 的 `Statements`，以及巢狀的 EVALUATE/IF（ThenStatements、ElseStatements、EvaluateWhenPhrases[].Statements、EvaluateWhenOtherStatements）。
  - 對每個 `StatementNode` 呼叫 `FixStatementTruncateAtWhen`（正則 `\s+WHEN\b` 截斷 `Text` 並修正 MOVE 的 `moveTo`）。
- **呼叫時機**：`Program.cs` 在產出 JSON 前呼叫 `CobolAstVisitor.NormalizeAllProcedureStatements(ast.Procedure)`；不論 full 解析或 Plan 2a procedure-only 都會套用。

## 關鍵檔案

| 項目 | 路徑 |
|------|------|
| 走訪與截斷邏輯 | `ConvertCobol/Visitors/CobolAstVisitor.cs`：`NormalizeAllProcedureStatements`、`NormalizeStatementRecursive`、`FixStatementTruncateAtWhen` |
| 呼叫時機 | `ConvertCobol/Program.cs`：產出前 `CobolAstVisitor.NormalizeAllProcedureStatements(ast.Procedure)` |

## 一句話摘要（供 Cursor 規則/記憶）

EVALUATE 續行誤併：因 COBOL 續行導致 WHEN 901/WHEN OTHER 被併入 MOVE；問題 MOVE 在 AST 為段落層級非 EVALUATE 內。解法：以 NormalizeAllProcedureStatements 走訪整棵 Procedure 對每個 StatementNode 套用 FixStatementTruncateAtWhen；Program 產出 JSON 前呼叫一次。
