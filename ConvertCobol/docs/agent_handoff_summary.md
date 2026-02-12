# Agent 交接摘要（供新 Agent 啟動用）

> 更新時間：2026-02-10  
> 用途：新 agent 啟動時可讀此檔 + `plan2a_procedure_division_in_ast.md`、`plan2_ast_json_to_csharp_and_nextjs.md` 延續工作。

## 專案與目標

- **ConvertCobol**：COBOL → AST JSON 工具，產出供 **C# Web API** 與 **Next.js 前端**（Plan 2）使用。
- **Plan 2**：從 AST JSON 產出 C# API + Next.js 頁面；**Plan 2a** 先確保 PROCEDURE DIVISION 完整進 `*_ast.json`，再接 Plan 2。

## 已完成的修正與重構

### 1. 錯誤的 Paragraph（isSection: true）修正

- **現象**：資料項如 `Acu-Size`、`Acu-Msg-1` 等被誤輸出為 `Paragraph` 且 `isSection: true`、`statements: []`。
- **原因**：`VisitProcedureSection` 為每個 `procedureSectionHeader` 建立 `ParagraphNode(IsSection=true)`，ANTLR 錯誤恢復有時把 DATA 等結構誤判為 section header。
- **修正**：`CobolAstVisitor.cs` 的 `VisitProcedureSection` 改為**不再**為 section 標頭建立 Paragraph 節點，僅累加 `_ast.SectionCount` 並 `VisitChildren(context)`，避免假 Section 節點。

### 2. AST JSON 輸出重構（僅 3 個檔案）

- **原狀**：會出現 `*_ast_data_proc.json`、`*_ast_proc_proc.json` 等混淆檔名。
- **規範**：每次 `ast` 執行只產出 **3 個 JSON**：
  - **完整**：使用者指定的路徑（例 `HRRCB1IF_ast.json`）
  - **data-only**：`*_ast.json` → `*_ast_data.json`（僅 Identification/Environment/Data，Procedure 為 null）
  - **procedure-only**：`*_ast.json` → `*_ast_proc.json`（僅 ProgramId + Procedure）
- **實作**：`Program.cs` 中依 `outputPath` 檔名推導 `dataPath`、`procPath`：若檔名為 `*_ast.json` 則替換為 `_ast_data.json` / `_ast_proc.json`，否則為 `{name}_data.json`、`{name}_proc.json`。變數改為 `jsonOutDir` 避免與外層 `outDir` 遮蔽。
- **文件**：`dev_readme.md` 已補充「AST JSON 輸出」小節與範例指令。

### 3. 已刪除的舊檔

- `HRRCB1IF_ast_data_proc.json`、`HRRCB1IF_ast_proc_proc.json` 已刪除，不再產出。

## 關鍵檔案

| 檔案 | 說明 |
|------|------|
| `ConvertCobol/Visitors/CobolAstVisitor.cs` | Procedure/Section/Paragraph/Statement 走訪與 AST 組裝 |
| `ConvertCobol/Program.cs` | 進入點；ast 指令與 JSON 三檔路徑計算 |
| `ConvertCobol/docs/plan2a_procedure_division_in_ast.md` | Procedure 結構、兩層展開、Statement 結構化欄位、除錯紀錄 |
| `ConvertCobol/docs/plan2_ast_json_to_csharp_and_nextjs.md` | Plan 2 整體：C# API + Next.js 產出步驟與範本 |
| `dev_readme.md` | 專案說明與 AST 輸出行為 |

## 目前 AST 輸出結構（簡要）

- **完整**：`*_ast.json` — 含 Identification / Environment / Data / Procedure。
- **data-only**：`*_ast_data.json` — Procedure 為 null，其餘同完整。
- **procedure-only**：`*_ast_proc.json` — ProgramId + Procedure（Paragraph 陣列，每段有 `name`、`statements`），其餘 Division 為 null。

Procedure 的 **Level 1** = 進入段（如 Acu-Main-Logic），**Level 2** = 各 COBOL routine 對應之 Paragraph，各自帶 `statements`（含 MOVE/PERFORM/CALL/IF/READ/INITIALIZE 等結構化欄位）。詳見 `plan2a_procedure_division_in_ast.md`。

## 建議新 Agent 的下一步

1. 若要繼續 **Plan 2**：依 `plan2_ast_json_to_csharp_and_nextjs.md` 做 Phase 1～3（C# DTO/API、Next.js 頁面）。
2. 若要加強 **Procedure AST**：依 `plan2a_procedure_division_in_ast.md` 擴充語句結構（如 IF thenStatements/elseStatements、OPEN/CLOSE/READ 等陣列欄位）或除錯 FileStatus/parser。
3. 建置與測試：`dotnet build` 在 ConvertCobol 目錄；AST 產出範例：`ConvertCobol ast cbl\HRRCB1IF.cbl ast\HRRCB1IF_ast.json`。
