# HISCore COBOL Parser - ACUCOBOL-GT 列表檔解析工具

> 更新時間：2026-02-11
> 作者：AI Assistant
> 摘要：ConvertCobol AST：Part A 將 8 種 OTHER 改為 ADD/CONTINUE/GOTO/SEARCH/CANCEL/DELETE/INSPECT/SET；Part B EVALUATE 區塊結構化（evaluateSubject、evaluateWhenPhrases、evaluateWhenOtherStatements），WHEN 內 MOVE 等為獨立 statement 節點
>
> 更新時間：2026-02-10 21:00
> 作者：AI Assistant
> 摘要：ConvertCobol ast 指令輸出重構：每次執行只產生三個 JSON（完整 AST、data-only、procedure-only），命名依輸出檔名自動附加 _data / _proc；dev_readme 新增「AST JSON 輸出」小節說明
>
> 更新時間：2026-02-10 10:00
> 作者：AI Assistant
> 摘要：ConvertCobol 預設不註解 SCREEN SECTION（AcuListingCleaner 已移除註解螢幕項邏輯）；移除 --no-comment-screen；ast 參數改為 args 優先、其次環境變數（CONVERTCOBOL_AST_INPUT/OUTPUT/CHARSET）、再來 App.config（AstDefaultInputPath/OutputPath/Charset）
>
> 更新時間：2026-02-09 22:40
> 作者：AI Assistant
> 摘要：比對 list/HRRCB1IF.lst 與 cbl：.lst 中「COL 1.00, LINE 1.00...」為「03 S-RCB1-Fr-1, Frame,」之續行；由 .lst 產生之 .cbl 現預設不再註解 SCREEN SECTION
>
> 更新時間：2026-02-09 22:15
> 作者：AI Assistant
> 摘要：ConvertCobol SCREEN SECTION 解析增強：螢幕項可逗號結尾（screenDescriptionEntryTerminator）、新增 ScreenDescriptionItemNode（level/name、子句欄位、GuiType/GuiProperties）、VisitScreenDescriptionEntry 與 acuScreenContinuation（ACUCOBOL GUI 續行）
>
> 更新時間：2026-02-09 20:20
> 作者：AI Assistant
> 摘要：ConvertCobol AST overview 新增 hasScreenSection（來源含 SCREEN SECTION 註解標記時為 true，如 HRRCB1IF.cbl）
>
> 更新時間：2026-02-09 20:00
> 作者：AI Assistant
> 摘要：AST JSON DATA DIVISION 依 section 分組（FileSection/FD、WorkingStorageSection、LinkageSection、ScreenSection），DataItem 歸於各 section/FD
>
> 更新時間：2026-02-09 19:34
> 作者：AI Assistant
> 摘要：AST JSON 新增 INPUT-OUTPUT SECTION 層級（ConvertCobol），environment.children 為 InputOutputSection，其 children 為 FileControlEntry
>
> 更新時間：2026-02-09 15:00
> 作者：AI Assistant

## 概述

使用 [ProLeap COBOL Parser](https://github.com/uwol/proleap-cobol-parser) (ANTLR4-based) 解析 ACUCOBOL-GT 編譯器產生的列表檔 (.lst)，提取程式結構資訊（AST / ASG）。

## 專案結構

```
proleap/
├── pom.xml                          # Maven 專案定義（ProLeap from JitPack）
├── dev_readme.md                    # 本文件
├── list/                            # 輸入：ACUCOBOL-GT 列表檔
│   ├── HRMETKF.lst                  # 門診掛號維護 (42536 行)
│   └── HRRCB1IF.lst                 # 住院處方 (21663 行)
├── cbl/                             # 輸出：清理後的 COBOL 原始碼（自動產生）
│   ├── HRMETKF.cbl
│   └── HRRCB1IF.cbl
├── ast/                             # 輸出：AST/ASG 報告（自動產生）
│   └── HRRCB1IF_ast.md             # AST 報告 (ast 指令)
├── docs/                            # 輸出：遷移參考書（自動產生）
│   └── HRMETKF_migration_guide.md   # 遷移參考書 (help_book)
└── src/main/java/com/hiscore/cobol/
    ├── ast/
    │   └── AstGenerator.java        # AST/ASG 報告產生器
    ├── cleaner/
    │   └── AcuListingCleaner.java   # 列表檔清理工具
    ├── migration/
    │   └── MigrationGuideGenerator.java  # 遷移參考書產生器
    └── parser/
        └── CobolParserApp.java      # COBOL 解析主程式
```

## 快速開始

### 環境需求

- **Java**: JDK 17+ (已測試 Java 22)
- **Maven**: 3.x+
- **網路**: 首次建置需從 JitPack 下載 ProLeap 依賴

### 編譯與執行

```bash
# 編譯
mvn clean compile

# 解析摘要（ProLeap AST/ASG 基本分析）
mvn exec:java "-Dexec.args=list/HRMETKF.lst"

# 指定編碼與格式
mvn exec:java "-Dexec.args=list/HRMETKF.lst MS950 TANDEM"

# 產生完整 AST 報告 (ast 模式 → ast/*.md)
mvn exec:java "-Dexec.args=ast list/HRRCB1IF.lst"

# 產生遷移參考書 (help_book 模式 → docs/*.md)
mvn exec:java "-Dexec.args=help_book list/HRMETKF.lst"

# 指定輸出路徑與編碼
mvn exec:java "-Dexec.args=help_book list/HRMETKF.lst docs/output.md MS950"

# 打包為可執行 JAR
mvn clean package
java -jar target/cobol-parser-1.0.0-SNAPSHOT.jar list/HRMETKF.lst
java -jar target/cobol-parser-1.0.0-SNAPSHOT.jar ast list/HRRCB1IF.lst
java -jar target/cobol-parser-1.0.0-SNAPSHOT.jar help_book list/HRMETKF.lst
```

### 參數說明

**解析模式：**

| 參數 | 預設值 | 說明 |
|------|--------|------|
| input.lst | (必填) | ACUCOBOL-GT 編譯器列表檔路徑 |
| charset | MS950 | 檔案編碼 (MS950/Big5/UTF-8) |
| format | TANDEM | COBOL 行格式 (TANDEM/FIXED/VARIABLE) |

**ast 模式（AST 報告）：**

| 參數 | 預設值 | 說明 |
|------|--------|------|
| input.lst | (必填) | ACUCOBOL-GT 編譯器列表檔路徑 |
| output.md | ast/{name}_ast.md | 輸出 Markdown 路徑 |
| charset | MS950 | 檔案編碼 |

**AST JSON 輸出（ConvertCobol ast）**

指定副檔名為 `.json` 時，每次執行只會產生**三個** JSON 檔案，命名依你指定的輸出檔名自動推導：

- **完整 AST**：寫入你指定的路徑（例：`ast\HRRCB1IF_ast.json`），含 Identification / Environment / Data / Procedure。
- **data-only**：同一目錄下，檔名由 `_ast.json` 替換為 `_ast_data.json`（例：`HRRCB1IF_ast_data.json`），僅含 Identification / Environment / Data，Procedure 為 null。
- **procedure-only**：同一目錄下，檔名由 `_ast.json` 替換為 `_ast_proc.json`（例：`HRRCB1IF_ast_proc.json`），僅含 ProgramId 與 Procedure（及相關統計）。

範例：

```bash
ConvertCobol ast cbl\HRRCB1IF.cbl ast\HRRCB1IF_ast.json
```

會產生：`HRRCB1IF_ast.json`、`HRRCB1IF_ast_data.json`、`HRRCB1IF_ast_proc.json`。若指定其他檔名（例如 `debug.json`），則衍生為 `debug_data.json`、`debug_proc.json`。

**help_book 模式（遷移參考書）：**

| 參數 | 預設值 | 說明 |
|------|--------|------|
| help_book | (指令) | 第一參數，啟動遷移參考書產生 |
| input.lst | (必填) | ACUCOBOL-GT 編譯器列表檔路徑 |
| output.md | docs/{name}_migration_guide.md | 輸出 Markdown 檔案路徑 |
| charset | MS950 | 檔案編碼 |

## 技術細節

### ACUCOBOL-GT 列表檔格式分析

經分析確認，ACUCOBOL-GT v6.1.0 列表檔的欄位佈局為：

```
Pos 0-5 : 6 字元 hex address 或 spaces (序號區)
Pos 6   : 1 字元 padding space (額外空白)
Pos 7   : indicator (* 註解 / 空白 正常 / - 續行)
Pos 8+  : code area (Area A/B)
```

此格式比標準 COBOL 的 6 字元序號區多了 1 字元 padding。

### AcuListingCleaner 清理流程

1. **移除頁首標頭** — 含 `ACUCOBOL-GT...Page:` 的行及後續 2 行空白
2. **移除 STATISTICS 統計區段** — 檔案末尾的編譯統計
3. **Strip 前 7 字元** — 去除序號區 + padding，對齊 TANDEM 格式
4. **TANDEM indicator 修正** — 非合法 indicator 字元自動補空白
5. **COPY 語句註解化** — 因列表已含展開內容，將 COPY 行改為 `*` 註解
6. **$ 編譯器指令註解化** — `$XFD`, `$IF`, `$SET` 等 ACUCOBOL 專有指令
7. **Copybook 標頭偵測** — 檔名行、Copyright、小寫/混合大小寫描述文字
8. **SCREEN SECTION 註解化** — ACUCOBOL GUI 定義（Frame, Label, FONT 等）
9. **`*>` 轉傳統註解** — ProLeap 不完全支援 COBOL 2002 `*>` 語法
10. **註解中關鍵字清理** — 防止 ProLeap 前處理器誤偵測 COPY/REPLACE

### 解析策略

- **格式**: 使用 ProLeap **TANDEM** 格式（column 1 = indicator）
- **錯誤容忍**: 啟用 `ignoreSyntaxErrors=true`，ACUCOBOL 特有語法會產生 parse error 但不中斷
- **ACUCOBOL 不支援語法**: `ASSIGN TO DISK`, `WITH COMPRESSION`, `LOCK MANUAL`, `UNSIGNED-LONG` 等
- **PROCEDURE DIVISION 限制**: ACUCOBOL GUI 語句（CREATE, MODIFY, INQUIRE, DESTROY）使 ProLeap 無法建構 procedure ASG
- **DATA DIVISION**: 完整解析（FD、WORKING-STORAGE、LINKAGE 含 PIC/OCCURS/REDEFINES）

### HRMETKF.lst 解析結果摘要

```
=== 清理結果 ===
輸入行數：42536
輸出行數：40422
移除頁首：698
移除空白行：1396
註解化 COPY：343
移除統計行：20

=== 解析結果 ===
PROGRAM-ID: HRMETKF
IDENTIFICATION DIVISION: ✓
ENVIRONMENT DIVISION: ✓
DATA DIVISION: ✓ (FILE SECTION: 1 FD, WORKING-STORAGE)
PROCEDURE DIVISION: ✓ (部分解析，因 ACUCOBOL 特有語法)
解析耗時: ~5.6 秒
```

### MigrationGuideGenerator 遷移參考書

`help_book` 指令以文字模式比對（regex-based）從原始 .lst 列表檔提取遷移相關資訊，產生結構化的 Markdown 文件。

**產出內容包括：**

| 章節 | 說明 |
|------|------|
| 1. 程式概要 | PROGRAM-ID、行數、各統計數據 |
| 2. 檔案清單 | SELECT/FD 完整定義，含 Key、Compression、Lock 等 |
| 3. COPY 相依性 | 所有 copybook 引用，依類型分類 |
| 4. 外部程式呼叫 | CALL 語句（含註解中的歷史參考） |
| 5. 資料結構摘要 | 01-Level 項目清單 |
| 6. PROCEDURE DIVISION | Section/Paragraph 完整列表 |
| 7. GUI 功能分析 | Screen Section、CREATE/MODIFY/DESTROY/INQUIRE |
| 8. 遷移風險評估 | 高/中/低風險矩陣與建議 |
| 9. 遷移檢核清單 | 可勾選的 Checklist |
| 10. 附錄 | 產生工具資訊 |

### HRMETKF 遷移參考書摘要

| 項目 | 數值 |
|------|------|
| 檔案定義 | 111 |
| COPY 相依 | 356 (320 個 copybook) |
| 外部呼叫 | 114 (4 有效 CALL W$FONT) |
| 段落/區段 | 408 |
| GUI 操作 | 295 |
| Screen Section | 有 |
| 遷移高風險項 | Screen Section GUI、GUI 控制項操作 |

## C# ConvertCobol 工具 (ANTLR4)

另提供 .NET 8 版 ConvertCobol 工具，使用 Cobol85 + ACUCOBOL 擴充文法解析 COBOL 產生 AST 報告。

```bash
cd ConvertCobol
dotnet run -- ast ../cbl/HRRCB1IF.cbl
dotnet run -- ast ../cbl/HRRCB1IF.cbl ../ast/HRRCB1IF_ast.json   # 輸出 JSON
dotnet run -- read ../ast/HRRCB1IF_ast.json                     # 從 JSON 載入並顯示摘要
dotnet run -- ast ../list/HRRCB1IF.lst
# 指定輸出與編碼：ast input [output] [charset]，副檔名 .json 則輸出 JSON；預設 charset: big5
```

**Chinese token 修復（2026-02-06）**：已實作 ConvertTraditionalComments（傳統 `*` 註解轉 `*>`）、CJK IDENTIFIER、OTHER_CHAR 兜底規則、Big5/MS950 編碼偵測與 BOM 偵測。PROGRAM-ID 可正確擷取，無 token recognition error。

**ACUCOBOL FILE-CONTROL 文法修復（2026-02-09）**：已修正 assignClause（ASSIGN TO DISK "quoted"）、recordKeyClause（key = keylist）、alternateRecordKeyClause（ALTERNATE KEY、= keylist）、acuCompressionClause（ENCRYPTION）、COMMENTLINE（*> 獨立行與 *>2019/12/24 格式）。FILE-CONTROL 段落可完整解析，解析可通過至 DATA DIVISION。語句數仍受 DATA DIVISION（HANDLE OF、UNSIGNED-LONG 等）文法差異影響。

**JSON 輸出與讀入（2026-02-09）**：新增 JsonAstReporter、AstJsonLoader。`ast input output.json` 產生 JSON；`read input.json` 載入 JSON 並顯示摘要。載入後的 ProgramAst 可用 Visitor 走訪。

## 已知限制

1. **ACUCOBOL-GT 特有語法** — `ASSIGN TO DISK`, `WITH COMPRESSION`, `COMPRESSION CONTROL VALUE`, `LOCK MANUAL` 等不被 ProLeap 支援，會產生 parse error
2. **Screen Section GUI** — ACUCOBOL 的圖形化 Screen Section 定義（`CREATE`, `MODIFY`, `INQUIRE`, `DESTROY`）不受支援
3. **EXEC SQL / EXEC CICS** — ProLeap 會提取為文字但不深度解析
4. **中文字元** — 列表檔中的中文註解（Big5/MS950 編碼）在清理時轉為 UTF-8，部分字元可能以 `?` 替代

## 依賴

- [ProLeap COBOL Parser](https://github.com/uwol/proleap-cobol-parser) (main branch via JitPack)
- ANTLR4 (ProLeap 內含)
- SLF4J Simple (日誌)

## 更新歷程

| 日期 | 作者 | 摘要 |
|------|------|------|
| 2026-02-09 | AI Assistant | C# ConvertCobol：COBOL 解析錯誤修正（HANDLE OF、UNSIGNED-LONG、孤立註解續行、IS SPECIAL-NAMES、dataDescriptionEntry 逗號、語句數由 0 提升為 3） |
| 2026-02-09 | AI Assistant | C# ConvertCobol：JSON 輸出與讀入（JsonAstReporter、AstJsonLoader、read 指令） |
| 2026-02-09 | AI Assistant | C# ConvertCobol：ACUCOBOL FILE-CONTROL 文法修復（ASSIGN TO DISK、RECORD KEY = keylist、ALTERNATE KEY、ENCRYPTION、COMMENTLINE） |
| 2026-02-06 | AI Assistant | C# ConvertCobol：Chinese token 修復（ConvertTraditionalComments、CJK IDENTIFIER、OTHER_CHAR、Big5 編碼） |
| 2026-02-06 15:15 | AI Assistant | 新增 help_book 遷移參考書產生功能（MigrationGuideGenerator） |
| 2026-02-06 14:51 | AI Assistant | 初版：列表檔清理 + ProLeap 解析 + TANDEM 格式策略 |
