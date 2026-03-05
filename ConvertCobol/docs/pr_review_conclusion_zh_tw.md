---
name: PR 審查結語（zh-TW）
overview: 針對「新增 Pseudo Code 與 Mermaid 產生器、修復 JSON 多型往返」PR 的完整審查結語，記錄所有已解決的 Copilot 審查意見及最終驗證結果。
---

<!-- 更新時間：2026-03-05；摘要：PR 審查全數完成，199 項測試通過，8 個 Copilot 意見均已修復。 -->

# PR 審查結語

> **PR 標題**：新增 Pseudo Code 與 Mermaid 產生器，修復 JSON 多型往返  
> **審查完成日期**：2026-03-05  
> **最終測試結果**：199 / 199 通過 ✅

---

## 一、PR 背景摘要

本 PR 在現有 ConvertCobol 工具鏈的基礎上，新增了以下功能：

| 元件 | 說明 |
|------|------|
| `ProcedureToPseudoCodeEmitter` | 將 Procedure Division AST 轉換為結構化 COBOL-like Pseudo Code，支援 IF / EVALUATE / PERFORM 縮排 |
| `ProcedureToMermaidEmitter` | 產生 `flowchart TD` Mermaid 圖，展示段落間的 PERFORM 呼叫關係 |
| `emit` CLI 指令 | 供 `Program.cs` 使用，將 `*_proc.json` 轉換為 Pseudo Code 或 Mermaid 輸出 |
| JSON 多型往返修復 | `StatementNodeJsonConverter` 改為透過 `AstNode` 序列化，保留 `$type` 鑑別器；`AstJsonLoader` 同步註冊此 Converter |

---

## 二、Copilot 審查意見處理紀錄

下表列出本 PR 所有 8 個 Copilot 自動審查意見及其處理結果：

| # | 檔案 / 位置 | 問題描述 | 處理結果 |
|---|------------|----------|----------|
| 1 | `JsonRoundTripTests.cs:11-14` | 測試類別文件說明不符：舊註解警告 `$type` 鑑別器可能遺失，但新實作已保留 | ✅ 已更新：改為說明 `$type` 鑑別器現已正確保留 |
| 2 | `Program.cs:26-33` | `ast` 指令的說明行遺漏 `--verbose/-v` 旗標 | ✅ 已修復：`ast` 用法行加入 `[--verbose]` |
| 3 | `ProcedureToMermaidEmitter.cs:19-44` | PERFORM 目標不在 `allNames` 中，造成 Mermaid 出現未定義節點 | ✅ 已修復：改為兩階段收集——先收集所有段落名稱，再以大小寫不敏感方式正規化 PERFORM 目標並加入 `allNames` |
| 4 | `HRRCB1IF_flowchart.mmd:230-244` | 已產生的 `.mmd` 檔包含無定義的邊目標（舊版產生器產物） | ✅ 已重新產生：195 個定義節點、106 條邊、0 個未定義節點引用 |
| 5 | `README.md:93-108` | README 未記錄新增的 `emit` 指令 | ✅ 已補充：完整記錄 `emit` 指令語法及 `--format` 選項說明 |
| 6 | `ProcedureToPseudoCodeEmitter.cs:78-102` | CLOSE / WRITE / REWRITE / START / COMPUTE / STRING / INSPECT 案例先加關鍵字前綴再附上 `stmt.Text`，導致輸出重複（如 `CLOSE CLOSE MY-FILE`） | ✅ 已修復：改為直接輸出 `stmt.Text`（若為 null 則回退至關鍵字常數） |
| 7 | `ProcedureToPseudoCodeEmitter.cs:255` | `EmitDisplay` 輸出 `DISPLAY {display.Text}`，但 `Text` 已含 `DISPLAY` 前綴，造成重複 | ✅ 已修復：改為直接輸出 `display.Text` 而不加前綴 |
| 8 | `ProcedureToPseudoCodeEmitter.cs:260-267` | `EmitAccept` 的環境變數值未加引號，與原始 COBOL 字串語義不符 | ✅ 已修復：`AcceptFromEnvironment` 值現以雙引號包覆輸出 |

---

## 三、EmitInitialize 額外修正

除上述 8 個 Copilot 意見外，另外修正了 `EmitInitialize` 的 else 分支：

- **問題**：`INITIALIZE {init.Text}` 若 `init.Text` 已含 `INITIALIZE` 前綴，會產生 `INITIALIZE INITIALIZE ...` 重複輸出。
- **修正**：改為 `init.Text ?? "INITIALIZE"`，直接輸出原始文字（若為 null 則回退至 `"INITIALIZE"`）。

---

## 四、Mermaid 產生器架構改進

原始實作為單次迭代——在同一個迴圈中同時收集段落名稱與建立邊；修正後改為兩階段：

```
第一階段：收集所有段落名稱（paragraphNames HashSet）
第二階段：收集 PERFORM 目標，以大小寫不敏感方式對應至既有段落名稱
          → 若找到對應名稱，使用正規化名稱（避免大小寫不一致造成重複節點）
          → 若未找到對應名稱，仍將目標加入 allNames（保持圖的完整性）
```

`SanitizeId()` 統一將連字號與空格轉換為底線，確保 Mermaid 節點 ID 合法。

---

## 五、Pseudo Code 產生器輸出範例

修正後的各語句類型輸出方式：

| 語句類型 | 修正前 | 修正後 |
|---------|--------|--------|
| `CloseStatement` | `CLOSE CLOSE MY-FILE` | `CLOSE MY-FILE` |
| `WriteStatement` | `WRITE WRITE REC-001` | `WRITE REC-001` |
| `DisplayStatement` | `DISPLAY DISPLAY "HELLO"` | `DISPLAY "HELLO"` |
| `InitializeStatement`（無目標） | `INITIALIZE INITIALIZE WS-VAR` | `INITIALIZE WS-VAR` |
| `AcceptStatement`（環境變數） | `ACCEPT VAR FROM ENVIRONMENT HOME_DIR` | `ACCEPT VAR FROM ENVIRONMENT "HOME_DIR"` |

---

## 六、JSON 多型往返修復摘要

| 元件 | 修正內容 |
|------|----------|
| `StatementNodeJsonConverter` | `Write()` 透過 `AstNode` 序列化（而非 `StatementNode` 介面），確保 `$type` 鑑別器被寫入 |
| `AstJsonLoader` | 在 `JsonSerializerOptions` 中註冊 `StatementNodeJsonConverter`，確保反序列化時能正確還原 `PerformStatement`、`IfStatement` 等子類型 |
| `AstNode` | 宣告所有語句子類型的 `JsonDerivedType` 對應 |
| `JsonRoundTripTests` | 測試覆蓋序列化 → 反序列化流程，驗證 `$type` 鑑別器在往返後仍保留正確型別 |

---

## 七、測試結果

```
總計：199 項
通過：199 ✅
失敗：0
跳過：0
```

所有既有測試（BaselineTests、CommentNormalizerTests、EncodingHelperTests、EmitterTests、DataItemHierarchyTests、JsonRoundTripTests 等）均通過，無退化。

---

## 八、結語

本 PR 的所有 8 個 Copilot 自動審查意見已全數解決，並額外修正了 `EmitInitialize` 的重複輸出問題。程式碼品質方面：
- Pseudo Code 產生器不再有關鍵字重複的問題
- Mermaid 產生器確保所有邊的目標節點都已定義
- JSON 多型往返現可正確保留語句子類型
- CLI 說明與 README 文件與實際功能保持一致

後續可依 `plan2_ast_json_to_csharp_and_nextjs.md` 繼續推進 **Plan 2**（C# API + Next.js 前端）的開發。
