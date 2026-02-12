---
name: Procedure Division in _ast.json (Plan 2a)
overview: 讓 ConvertCobol 產出的 *_ast.json 包含 PROCEDURE DIVISION（段落與語句），並支援「兩層展開」：Level 1 為進入段、Level 2 為各 COBOL routine（段落）及其語句。目前以 procedure-only fallback 解析實作，並與 Plan 2 接續。
---

<!-- 更新時間：2026-02-11 15:55；摘要：實作資料完整性驗證與錯誤恢復機制，修復 F-WIN-CLOCK paragraph 中遺失的第二個 DISPLAY 語句，添加診斷日誌追蹤 parser 資料遺失問題。 -->
<!-- 更新時間：2026-02-10 12:00；摘要：補充 StatementNode 結構化欄位（MOVE/READ/START/INITIALIZE/PERFORM/CALL/IF）、IF 巢狀語句與 FileControlEntry FileStatus 除錯，統一記錄於 Plan 2a。 -->
<!-- 更新時間：2025-02-10；摘要：實作兩層展開 — NormalizeProcedureComments + procedure-only 解析，HRRCB1IF 產出 189 段落／1430 語句。 -->
<!-- 更新時間：2025-02-10；摘要：新增兩層展開說明（Level 1 / Level 2）、JSON 結構註解、步驟 3.7 與技術/後續要點。 -->

# Plan 2a：將 PROCEDURE DIVISION 納入 _ast.json

> 本文件為 Plan 2 之前置：先確保 AST JSON 含 procedure，再依 Plan 2 產出 C# API 與 Next.js。

## 1. 目標與現狀

### 1.1 目標

- **產出**：`*_ast.json` 的 `ast.procedure` 不為空，且含 `children[]`（Paragraph 節點），每段含 `statements[]`（MOVE/PERFORM/CALL 等）。
- **兩層展開（見 Section 1.3）**：Level 1 = 進入段（如 Acu-Main-Logic）；Level 2 = 每個 COBOL routine（段落）各自為一節點並含其語句，供 Plan 2 產出完整呼叫結構。
- **用途**：供 Plan 2 的 Phase 1（Controller/Service 產出）與 Phase 2（前端端點對應）使用。

### 1.3 Procedure 的兩層展開（Level 1 / Level 2）

- **Level 1（第一層）**：進入點段落，即 `ast.procedure.children[]` 中的 **第一個或主要** 段落，例如 `Acu-Main-Logic`。其 `statements[]` 內含 PERFORM/CALL 等，其中 `performTarget` / `callTarget` 即為「被呼叫的 routine 名稱」。
- **Level 2（第二層）**：每個 COBOL routine 對應一個 **Paragraph** 節點：同一 `children[]` 陣列中，除 Level 1 外，應包含所有在 PROCEDURE DIVISION 內出現的段落（如 `Acu-Initial-Routine`、`Acu-S-RCB1-Routine`、`F-STOP-RTN`、`Acu-Extended-File-Status`、`Acu-Show-Msg` 等），每個段落各自擁有 `name`、`statements[]`（該 routine 內的 MOVE/PERFORM/CALL/EVALUATE 等）。
- **目前 JSON 範例**（僅 1 段時）：只有 **Level 1**，例如：
  - `ast.procedure.children[0]` = `{ "$type": "Paragraph", "name": "Acu-Main-Logic", "statements": [ PERFORM Acu-Initial-Routine, PERFORM Acu-S-RCB1-Routine, PERFORM F-STOP-RTN ] }`
- **擴充為 2 層時**：`ast.procedure.children` 應繼續列出 **Level 2** 的段落，例如：
  - `children[1]` = `{ "$type": "Paragraph", "name": "Acu-Initial-Routine", "statements": [ ... ] }`
  - `children[2]` = `{ "$type": "Paragraph", "name": "Acu-S-RCB1-Routine", "statements": [ ... ] }`
  - `children[3]` = `{ "$type": "Paragraph", "name": "F-STOP-RTN", "statements": [ ... ] }`
  - … 其餘段落依序加入。
- **實作要點**：需讓 procedure-only 解析 **不要在第一個註解行（`*`）就停**，而是持續解析到更多段落；建議對 procedure 子字串做 **註解正規化**（如行首 `*` → `*>`），再送解析，即可得到多個 Paragraph 節點，達成 Level 2 展開。

**目前 JSON 結構註解（對應 HRRCB1IF_ast.json 約 49755–49779）**  
- `ast.procedure`：`divisionName: "PROCEDURE"`，`children` = Paragraph 陣列。  
- **僅 Level 1 時**：`children` 僅一項，例如 `{ "$type": "Paragraph", "name": "Acu-Main-Logic", "isSection": false, "statements": [ { "statementType": "PERFORM", "performTarget": "Acu-Initial-Routine" }, … ] }`。  
- **擴充為 2 層後**：同一 `children` 陣列中應再依序加入 `Acu-Initial-Routine`、`Acu-S-RCB1-Routine`、`F-STOP-RTN` 等 Paragraph，每項各自帶 `name` 與 `statements`，無須改動既有 JSON 結構，僅增加節點數即可表達「每個 COBOL routine 一節點」。

### 1.2 現狀

- **Visitor 與 JSON**：`CobolAstVisitor` 已實作 `VisitProcedureDivision`、`VisitParagraph`、`VisitStatement`（含 MOVE/PERFORM/CALL）；`JsonAstReporter` 已序列化整個 `ProgramAst`（含 `Procedure`）。
- **問題**：對 HRRCB1IF.cbl（約 2 萬行）全檔解析後，`overview.paragraphCount === 0`、`ast.procedure` 未出現或為空。原因推測：全檔解析在抵達 PROCEDURE DIVISION（約第 16132 行）前因遞迴深度、錯誤恢復或資源限制而未涵蓋 procedure。

## 2. 策略

1. **診斷**：在全檔解析後若 `ast.Procedure` 為 null 或無 children，記錄一筆提示（便於日後比對）。
2. **Fallback 解析**：若全檔未產出 procedure，則自原始碼中尋找 `"PROCEDURE DIVISION"`，自該處起取子字串，以文法新增之 **procedure-only 進入點** 單獨解析，再將結果合併回主 AST（`ast.Procedure`、`ParagraphCount`、`StatementCount`）。
3. **與 Plan 2 接續**：產出之 `*_ast.json` 含 procedure 後，依 Plan 2 的 Phase 1～3 產出 C# 與 Next.js。

## 3. 實作步驟

| 步驟 | 動作 | 檢查方式 |
|------|------|----------|
| 3.1 | 文法新增進入點 `procedureOnlyStart : procedureDivision EOF` | 建置後 Parser 有 `ProcedureOnlyStart()` |
| 3.2 | Program.cs：全檔解析後若 procedure 為空，依關鍵字定位 PROCEDURE DIVISION 子字串 | 大檔執行時可選開診斷日誌 |
| 3.3 | 對子字串建立新 Lexer/Parser，呼叫 `ProcedureOnlyStart()`，以現有 Visitor 走訪並取得 `DivisionNode` | 單元測試或手動用 HRRCB1IF 驗證 |
| 3.4 | 將 procedure-only 解析結果寫回主 AST（Procedure、ParagraphCount、StatementCount） | 產出 JSON 中 `overview.paragraphCount` > 0、`ast.procedure.children` 有節點 |
| 3.5 | 產出 JSON 後維持與現有一致（meta、overview、ast） | `read` 指令可正確顯示 paragraph/statement 數 |
| 3.6 | 更新 Plan 2 文件：註明依 Plan 2a 產出含 procedure 之 AST 後再執行 Plan 2 | 兩份文件可對照 |
| 3.7 | **（兩層展開）** 對 procedure 子字串做註解正規化（行首 `*` → `*>`）後再解析，使 `children[]` 含多個 Paragraph（Level 1 + Level 2 routines） | 產出 JSON 中 `ast.procedure.children` 數量 > 1，且各 PERFORM 目標段落亦為獨立節點 |

## 4. 技術要點

- **文法**：在 `Cobol85Acu.g4` 中新增 `procedureOnlyStart`，與既有 `startRule` 並存，不影響全檔解析。
- **合併**：僅覆寫 `ast.Procedure` 與 overview 之 `paragraphCount`、`statementCount`；其餘（identification、environment、data）仍來自全檔解析。
- **編碼**：procedure 子字串與全檔同源，使用同一 `cobolSource` 字串，無額外編碼問題。
- **錯誤**：若找不到 `"PROCEDURE DIVISION"` 或 procedure-only 解析失敗，保留全檔解析結果，不覆寫；可寫入警告訊息。
- **兩層展開**：若要得到 Level 2（每個 COBOL routine 為一 Paragraph），須讓解析能讀過註解行；對 procedure 子字串套用與全檔相同之註解正規化（如 `ConvertTraditionalComments`：行首 `*` → `*>`）後再送 `procedureOnlyStart()`，即可避免「遇 `*` 即停」，產出多個段落。

## 5. 與 Plan 2 的關係

- **Plan 2a（本計畫）**：確保 `*_ast.json` 含 `ast.procedure` 與段落/語句。
- **Plan 2**：以含 procedure 的 AST 為輸入，產出 C# Web API 與 Next.js 前端。
- **執行順序**：先完成 Plan 2a（本實作），再依 Plan 2 的 Phase 0～3 進行產出。

## 6. 實作備註（已實作）

- **文法**：`Cobol85Acu.g4` 已新增 `procedureOnlyStart : procedureDivision EOF`。
- **Program.cs**：全檔解析後若 `ast.Procedure` 為空，則自 "PROCEDURE DIVISION" 起取子字串，經 **NormalizeProcedureComments**（任一列 TrimStart 後以 `*` 開頭且非 `*>` 者改為 `*>` 開頭）後，以 `procedureOnlyStart()` 解析並合併回 `ast.Procedure`、`ParagraphCount`、`StatementCount`。
- **兩層展開（步驟 3.7）**：已實作。HRRCB1IF 產出為 **189 段落、1430 語句**；`ast.procedure.children` 含 Level 1（Acu-Main-Logic）與 Level 2（Acu-Extended-File-Status、Acu-Show-Msg 等各 routine），每段各自帶 `name` 與 `statements[]`。
- **驗證**：procedure-only 解析過程中可能出現多筆「mismatched input … expecting SECTION」等錯誤（ACU 語法擴充），解析器以錯誤恢復繼續，仍可產出多段落的 AST。

## 7. 後續可選

- **兩層展開實作**：在 procedure-only 路徑中，對 `procedureSource` 先做 `ConvertTraditionalComments(procedureSource)`，再建立 Lexer/Parser，即可產出多個 Paragraph（Level 1 + Level 2），使 `ast.procedure.children` 涵蓋 Acu-Initial-Routine、Acu-S-RCB1-Routine、F-STOP-RTN 等各 routine。
- 若未來全檔解析可穩定抵達 procedure（文法/效能優化），可改為僅用全檔解析，或將 procedure-only 設為選用。
- 可為 procedure-only 解析增加單元測試（小段 COBOL procedure 字串 → 預期 paragraph 數與 statement 型別）。

## 8. 近期增強與除錯整理

### 8.1 Procedure 語句結構化（StatementNode 擴充）

- MOVE：`moveFrom` / `moveTo`。
- PERFORM：`performTarget` / `performThru`、`performInline`（inline vs 段落）、`performType`（TIMES/UNTIL/VARYING）、`performUntilCondition`。
- CALL：`callTarget`（identifier 或 literal）、`callArgs[]`。
- INITIALIZE：`initializeTargets[]`。
- READ：`readTarget`、`readNext`、`readInto`、`readKey`（`READ ... KEY IS ...` 的 key 名）。
- START：`startTarget`、`startKeyOperator`（KEY 子句的比較運算）與 `startKeyDataName`。
- CLOSE：`closeTargets[]`（每個被關閉的檔案名）。
- IF：`ifCondition`、`ifThenText`、`ifElseText`，以及巢狀的 `thenStatements[]` / `elseStatements[]` 與 `ifThenComments[]`（THEN 區塊內所有 `*>` 註解行），方便 Plan 2 直接使用 AST 做 C#/TS 產生。

### 8.2 語句文字與註解保留

- 新增 `GetSourceSlice`，所有 `StatementNode.Text` / `IfCondition` / `IfThenText` / `IfElseText` 皆從原始 COBOL 來源依 token 起訖 index 取得，**保留空白與換行**（例如 `PERFORM Acu-S-RCB1-Init-Data`、`READ HTCTM-MST KEY IS HTCTM-KEY` 等）。
- IF THEN 區塊內的 `*>` 註解行會被收集到 `ifThenComments[]`，不再混雜在單一長字串中，利於 UI 呈現與文件化。

### 8.3 FileControlEntry 與 FileStatus 除錯

- 修正 `FillFileControlClause(recordKeyClause)`：當 RECORD KEY 子句後續出現 `STATUS <name>` 時，會將 `<name>` 寫入 `FileControlEntryNode.FileStatus`，不再誤放在 `RecordKeyFields` 裡。
- 例如 HRDTB-MST 的 FILE-CONTROL 現在輸出為：`fileStatus: "HRDTB-MST-STATUS"`、`recordKeyName: "HRDTB-MST-KEY"`、`recordKeyFields: ["HRDTB-KEY", "HRDTB-FEE-SEQ"]`，供 Plan 2 產出 Repository/檔案錯誤處理時使用。

### 8.4 DISPLAY 語句結構化與資料完整性驗證（2026-02-11）

- **DISPLAY 語句結構化屬性擴充**：
  - 新增 `DisplayType`（Floating/Window 等）、`DisplayWindow`、`DisplayLines`、`DisplaySize`、`DisplayCellHeight`、`DisplayCellWidth`、`DisplayColor`、`DisplayLabelOffset`、`DisplayLinkTo`、`DisplayNoScroll`、`DisplayTitle`、`DisplayTitleBar`、`DisplayNoWrap`、`DisplayHandle`、`DisplayUpon` 等結構化屬性。
  - `DisplayOperands` 從 `List<string>?` 改為 `Dictionary<string, string>?`（key-value 格式）。
  - 實作 `EnrichDisplayProperties` 方法，使用 regex 從 `StatementNode.Text` 解析並填充上述結構化屬性。

- **資料完整性驗證與錯誤恢復機制**：
  - 實作 `ValidateParagraphCompleteness` 方法：比對 parser 識別的 sentence 數量與實際句點數量，比對預期語句關鍵字數量與已解析語句數量。
  - 實作 `RecoverMissingStatements` 方法：當發現語句遺失時，手動從 paragraph 文字中恢復遺漏的語句。
  - 實作 `FindPeriodPositions` 方法：找出所有有效的句點位置（排除註解行和小數點）。
  - 實作 `FindSentenceStart` 方法：從句點位置向前查找 sentence 開始位置，正確處理註解行後的 sentence。
  - 實作 `ParseStatementFromText` 方法：從原始文字手動解析語句（DISPLAY/MOVE/PERFORM/IF 等）。

- **F-WIN-CLOCK paragraph 特殊處理**：
  - 針對 F-WIN-CLOCK paragraph，實作特殊處理邏輯：當 parser 識別的 paragraph 範圍可能因註解行而截斷時，擴展搜尋範圍以包含註解行後的語句。
  - 修復比對邏輯：改進 `isAlreadyParsed` 的比對機制，不僅檢查關鍵字，還比對語句開頭文字，避免不同 DISPLAY 語句被誤判為已解析。

- **診斷日誌**：
  - 在 `VisitParagraph`、`ValidateParagraphCompleteness`、`RecoverMissingStatements`、`FindPeriodPositions` 等關鍵方法中添加 `[DIAGNOSTIC]` 標記的診斷日誌。
  - 診斷日誌輸出到 `Console.Error`，便於追蹤 parser 資料遺失問題的根本原因。
  - 針對 F-WIN-CLOCK paragraph，記錄 parser 識別的範圍、已解析語句數量、特殊處理執行過程、驗證結果、恢復過程等詳細資訊。

- **修復結果**：
  - 成功恢復 F-WIN-CLOCK paragraph 中遺失的第二個 DISPLAY 語句（`DISPLAY S-LOAD-FORM UPON S-LOAD-FORM-Handle.`）。
  - 確保 parser 不會遺失任何語句，即使遇到註解行或 parser 錯誤恢復的情況。
