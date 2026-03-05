# HRRCB1IF.cbl 解析問題分析報告（修訂版）

> 初版日期：2026-03-04
> 修訂日期：2026-03-04
> 檔案：`cbl/HRRCB1IF.cbl`（20,575 行 ACUCOBOL-GT 程式）
> **修訂前**：195 paragraphs, 1,478 statements（僅 PROCEDURE DIVISION 備援解析）
> **修訂後**：195 paragraphs, 1,394 statements, 0 parse errors（完整解析成功）
> 測試結果：199 tests passed, 0 failed

## 摘要

初版報告識別出 **8 大類解析問題**（Issue 0–7）。經三階段修復後，再發現 **4 項額外問題**
（Issue 8–11）。全部 12 項問題已修復完畢，完整解析（`startRule()`）成功，
**PROGRAM-ID: HRRCB1IF** 已正確擷取。

> **語句數差異說明**：初版的 1,478 statements 是 procedure-only 備援解析的結果，
> 因備援模式下 error recovery 較寬鬆，會多計入無效 token 附近的假語句。
> 完整解析的 1,394 statements 為更精確的數值。

---

## 修復總覽

| Issue | 說明 | 策略 | 修復位置 | 狀態 |
|-------|------|------|----------|------|
| **0** | Space-Star 註解未轉換 | 預處理器 | `CommentNormalizer.cs` | ✅ 已修復 |
| **1** | `INSPECT ... FOR TRAILING` | 文法修改 | `Cobol85Acu.g4:2078` | ✅ 已修復 |
| **2** | `MOVE ... WITH CONVERT` | 預處理器 | `AcuSyntaxNormalizer.cs:16-17` | ✅ 已修復 |
| **3** | `ACCEPT FROM ENVIRONMENT` | 文法修改 | `Cobol85Acu.g4:1578,1599-1601` | ✅ 已修復 |
| **4** | `EXIT PARAGRAPH` / `EXIT SECTION` | 文法修改 | `Cobol85Acu.g4:1964` | ✅ 已修復 |
| **5** | `MODIFY` GUI 保留字屬性名 | 文法修改 | `Cobol85Acu.g4:2729,2748-2755` | ✅ 已修復 |
| **6** | `DISPLAY WINDOW` GUI 語法 | 預處理器 | `AcuSyntaxNormalizer.cs:27-68` | ✅ 已修復 |
| **7** | `REWRITE ... WITH LOCK` | 文法修改 | `Cobol85Acu.g4:2381,2388-2390` | ✅ 已修復 |
| **8** | SCREEN SECTION `EXCEPTION/EVENT PROCEDURE` | 預處理器 | `AcuSyntaxNormalizer.cs:75-94` | ✅ 已修復 |
| **9** | `DESTROY` 逗號分隔 identifiers | 文法修改 | `Cobol85Acu.g4:2737` | ✅ 已修復 |
| **10** | `UNLOCK` 語句缺失 | 文法修改 | `Cobol85Acu.g4:1569,2740-2742,5454-5456` | ✅ 已修復 |
| **11** | `SET ENVIRONMENT` 語句 | 文法修改 | `Cobol85Acu.g4:2451,2479-2481` | ✅ 已修復 |

---

## Issue 0（根因）：`CommentNormalizer` 未處理 Space-Star 註解 ✅

### 問題描述

HRRCB1IF.cbl 中有大量傳統 COBOL 註解行，格式為 ` *` (空格 + 星號)，星號在**第 1 欄**（index 1）。
CommentNormalizer 的 `ConvertTraditionalComments()` 方法只檢查 `line[0] == '*'`，
遺漏了 3,980 行 ` *` 格式的註解，導致 ANTLR 解析器在第一行就遇到非預期的 `*` token。

### 統計

| 模式 | 行數 | CommentNormalizer 處理 |
|------|------|------------------------|
| `*...`（column 0 star） | 4,320 | ✅ 已轉換為 `*>` |
| ` *...`（column 1 space-star） | 3,980 | ✅ **已修正** |
| 全部行數 | 20,575 | — |

### 修復方式

將 `ConvertTraditionalComments()` 改為使用 `TrimStart()` 判斷（與 `NormalizeProcedureComments` 一致），
並透過獨立的 `IsTraditionalComment()` helper 方法避免重複邏輯：

```csharp
// CommentNormalizer.cs
private static bool IsTraditionalComment(string trimmedLine)
    => trimmedLine.Length > 0 && trimmedLine[0] == '*'
       && !trimmedLine.StartsWith("*>", StringComparison.Ordinal);

// ConvertTraditionalComments() 內
var trimmed = line.TrimStart();
if (IsTraditionalComment(trimmed))
{
    var leadingSpaces = line[..^trimmed.Length];
    lines[i] = leadingSpaces + "*> " + trimmed[1..];
}
```

### 結果

修復此根因後，完整解析成功恢復：
- **PROGRAM-ID**: `HRRCB1IF` ✅
- **DATA DIVISION**: 全部 FD、01-level、77-level 資料項目 ✅
- **ENVIRONMENT DIVISION**: FILE-CONTROL SELECT 語句 ✅

---

## Issue 1：`INSPECT ... TALLYING ... FOR TRAILING` ✅

### 出現位置

- Line 97: `INSPECT Acu-Msg-1 TALLYING Acu-Size FOR TRAILING SPACE`
- 共 4 處

### 修復方式：文法修改

```diff
 inspectAllLeadings
-    : (ALL | LEADING) inspectAllLeading+
+    : (ALL | LEADING | TRAILING) inspectAllLeading+
     ;
```

Cobol85Acu.g4:2078 — 新增 `TRAILING` 至 tallying 子句。

---

## Issue 2：`MOVE ... WITH CONVERT` ✅

### 出現位置

約 20+ 處，例如：
- `MOVE W-YMD-YDFSW TO W-YMD-YYDEF WITH CONVERT`

### 修復方式：預處理器

`AcuSyntaxNormalizer.RemoveWithConvert()` 使用 regex 移除 `WITH CONVERT`：

```csharp
[GeneratedRegex(@"\bWITH\s+CONVERT\b", RegexOptions.IgnoreCase)]
private static partial Regex WithConvertPattern();

public static string RemoveWithConvert(string source)
    => WithConvertPattern().Replace(source, "");
```

語意等同標準 MOVE，轉換 hint 不影響 AST 結構。

---

## Issue 3：`ACCEPT ... FROM ENVIRONMENT "literal"` ✅

### 出現位置

約 15 處，例如：
- `ACCEPT W-YMD-YYSW FROM ENVIRONMENT "ZS_SYYW" END-ACCEPT`

### 修復方式：文法修改

新增 `acceptFromEnvironmentStatement` 規則（Cobol85Acu.g4:1578,1599-1601）：

```
acceptFromEnvironmentStatement
    : FROM ENVIRONMENT (identifier | literal)
    ;
```

放在 `acceptStatement` 的 alternatives 中，位於 `acceptFromMnemonicStatement` 之前。

---

## Issue 4：`EXIT PARAGRAPH` / `EXIT SECTION` ✅

### 出現位置

6 處，例如：
- Line 2734: `EXIT PARAGRAPH`

### 修復方式：文法修改

```diff
 exitStatement
-    : EXIT PROGRAM?
+    : EXIT (PROGRAM | PARAGRAPH | SECTION)?
     ;
```

Cobol85Acu.g4:1964 — `PARAGRAPH` lexer token 已新增（Line 4802）。

---

## Issue 5：`MODIFY` GUI 保留字屬性名衝突 ✅

### 出現位置

約 50 處 MODIFY 語句，例如：
- `MODIFY S-FR-LOAD-BAR, FILL-PERCENT = W-PERCENT, TITLE = W-PERCENT-FMT`

### 修復方式：文法修改（方案 A）

引入 `acuGuiPropertyName` 規則，允許常見 keyword tokens 作為屬性名
（Cobol85Acu.g4:2748-2755）：

```
acuGuiPropertyName
    : identifier | TITLE | MESSAGE | SIZE | STATUS | EVENT
    ;
```

同時修正 `acuModifyStatement` 允許前後的可選逗號（Cobol85Acu.g4:2729）：

```
acuModifyStatement
    : MODIFY identifier COMMACHAR? acuGuiPropertyList? COMMACHAR?
    ;
```

以及 `acuGuiProperty` 使用 `acuGuiPropertyName` 替代 `identifier` 作為屬性名。

---

## Issue 6：`DISPLAY WINDOW` GUI 語法 ✅

### 出現位置

4 處多行 DISPLAY GUI 語句：
- `DISPLAY WINDOW ...`（2 處）
- `DISPLAY Floating GRAPHICAL WINDOW ...`（2 處）
- `DISPLAY STATUS-BAR ...`

### 修復方式：預處理器

`AcuSyntaxNormalizer.NeutralizeDisplayGui()` 偵測多行 DISPLAY GUI 區塊，
整塊替換為 `CONTINUE.`（AcuSyntaxNormalizer.cs:27-68）。

偵測模式：以 `DISPLAY [Floating] [GRAPHICAL] WINDOW` 或 `DISPLAY STATUS-BAR` 開頭。
結束條件：行尾句點或包含 `HANDLE IS`。

> 注意：此預處理會移除原始行（非替換），導致 ANTLR 錯誤訊息的行號與原始 .cbl 行號有偏移。
> 4 個 DISPLAY GUI 區塊共移除約 21 行。

---

## Issue 7：`REWRITE ... WITH LOCK` ✅

### 出現位置

少量，例如：
- `REWRITE RNU-MST RECORD FROM W-RNU-MST WITH LOCK`

### 修復方式：文法修改

新增 `rewriteWith` 規則（Cobol85Acu.g4:2381,2388-2390）：

```
rewriteStatement
    : REWRITE recordName rewriteFrom? rewriteWith? invalidKeyPhrase? notInvalidKeyPhrase? END_REWRITE?
    ;

rewriteWith
    : WITH? LOCK
    ;
```

---

## Issue 8（新增）：SCREEN SECTION `EXCEPTION/EVENT PROCEDURE` 衝突 ✅

### 問題描述

SCREEN SECTION 內的 ACUCOBOL-GT GUI 屬性中出現 `EXCEPTION PROCEDURE identifier`
和 `EVENT PROCEDURE identifier` 語法。其中 `PROCEDURE` token 與 `PROCEDURE DIVISION`
共用同一 lexer token，導致 parser 在 SCREEN SECTION 內遇到 `PROCEDURE` 時跳出，
誤認為已進入 PROCEDURE DIVISION。

### 出現位置

SCREEN SECTION 內，作為 GUI 控制項的事件處理屬性。

### 修復方式：預處理器

`AcuSyntaxNormalizer.NormalizeScreenProcedureKeywords()` 在 SCREEN SECTION 範圍內
將 `EXCEPTION PROCEDURE` → `EXCEPTION-PROCEDURE`、`EVENT PROCEDURE` → `EVENT-PROCEDURE`，
防止 `PROCEDURE` token 與 `PROCEDURE DIVISION` 衝突（AcuSyntaxNormalizer.cs:75-94）：

```csharp
[GeneratedRegex(@"\b(EXCEPTION|EVENT)\s+PROCEDURE\b", RegexOptions.IgnoreCase)]
private static partial Regex ScreenProcedureKeywordPattern();
```

同時在 `acuScreenContinuation` 文法規則中移除 `PROCEDURE` token，
防止 parser 在 screen section 內匹配到該關鍵字。

---

## Issue 9（新增）：`DESTROY` 逗號分隔 identifiers ✅

### 問題描述

ACUCOBOL-GT 的 `DESTROY` 語句支援一次銷毀多個 GUI 控制項，以逗號分隔：

```cobol
DESTROY S-RCB1-Fr-1, S-RCB1-GD-1, S-FR-LOAD-BAR
```

原始文法僅支援單一 identifier。

### 修復方式：文法修改

```diff
 acuDestroyStatement
-    : DESTROY identifier
+    : DESTROY identifier (COMMACHAR? identifier)*
     ;
```

Cobol85Acu.g4:2737 — 允許以可選逗號分隔的多個 identifiers。

---

## Issue 10（新增）：`UNLOCK` 語句缺失 ✅

### 問題描述

ACUCOBOL-GT 的 `UNLOCK` 語句用於解除檔案鎖定：

```cobol
UNLOCK RNU-MST
```

原始文法未定義此語句。

### 修復方式：文法修改

1. 新增 `acuUnlockStatement` 規則（Cobol85Acu.g4:2740-2742）：

```
acuUnlockStatement
    : UNLOCK fileName
    ;
```

2. 將 `acuUnlockStatement` 加入 `statement` alternatives（Cobol85Acu.g4:1569）
3. 新增 `UNLOCK` lexer token（Cobol85Acu.g4:5454-5456）
4. 將 `UNLOCK` 加入 `cobolWord` alternatives

---

## Issue 11（新增）：`SET ENVIRONMENT` 語句 ✅

### 問題描述

ACUCOBOL-GT 的 `SET ENVIRONMENT` 語句用於設定環境變數（與 `ACCEPT FROM ENVIRONMENT` 讀取相對）：

```cobol
SET ENVIRONMENT "CURSOR-MODE" TO 2.
SET ENVIRONMENT "CURSOR-MODE" TO 3.
```

原始 `setStatement` 規則僅支援 `SET identifier TO value` 和 `SET identifier UP/DOWN BY value`。
由於 `ENVIRONMENT` 是 keyword token（非 `cobolWord`），無法匹配 `identifier`，
導致 parse error：`mismatched input 'ENVIRONMENT'`。

### 出現位置

2 處（原始 .cbl Line 20418, 20422）。

> 注意：ANTLR 錯誤報告為 preprocessed 行號 20402/20406，
> 因 `NeutralizeDisplayGui` 預處理移除了 16 行（4 個 DISPLAY GUI 區塊在此行之前）。

### 修復方式：文法修改

新增 `setEnvironmentStatement` 規則（Cobol85Acu.g4:2451,2479-2481）：

```diff
 setStatement
-    : SET (setToStatement+ | setUpDownByStatement)
+    : SET (setToStatement+ | setUpDownByStatement | setEnvironmentStatement)
     ;

+setEnvironmentStatement
+    : ENVIRONMENT (identifier | literal) TO (identifier | literal)
+    ;
```

無歧義：`ENVIRONMENT` 是 keyword，無法匹配 `identifier`/`setTo`，
parser 看到 `SET ENVIRONMENT` 時會明確選擇 `setEnvironmentStatement`。

---

## 預處理管線摘要

`AcuSyntaxNormalizer.NormalizeAll()` 依序套用三階段預處理：

1. **`RemoveWithConvert()`** — 移除 `WITH CONVERT` 後綴（Issue 2）
2. **`NeutralizeDisplayGui()`** — 替換多行 DISPLAY GUI 區塊為 `CONTINUE.`（Issue 6）
3. **`NormalizeScreenProcedureKeywords()`** — SCREEN SECTION 內 `EXCEPTION/EVENT PROCEDURE` → hyphenated 形式（Issue 8）

`CommentNormalizer.ConvertTraditionalComments()` 在 `NormalizeAll()` 之前執行，處理：
- 傳統 `*` 和 ` *` 格式註解行轉為 `*>` 格式（Issue 0）
- 註解續行偵測（逗號結尾的註解行之後跟字串字面值）
- `End of ...` 行轉為註解
- 註解後特定短語（`USAGE IS`、`HANDLE OF`）轉為註解

---

## 文法修改摘要

| 規則 | 修改 | Issue |
|------|------|-------|
| `inspectAllLeadings` | 新增 `TRAILING` | #1 |
| `acceptStatement` | 新增 `acceptFromEnvironmentStatement` alternative | #3 |
| `acceptFromEnvironmentStatement` | 新規則：`FROM ENVIRONMENT (identifier \| literal)` | #3 |
| `exitStatement` | 擴充為 `EXIT (PROGRAM \| PARAGRAPH \| SECTION)?` | #4 |
| `acuModifyStatement` | 前後允許可選 `COMMACHAR` | #5 |
| `acuGuiProperty` | 使用 `acuGuiPropertyName` 替代 `identifier` | #5 |
| `acuGuiPropertyName` | 新規則：`identifier \| TITLE \| MESSAGE \| SIZE \| STATUS \| EVENT` | #5 |
| `rewriteStatement` | 新增 `rewriteWith?` | #7 |
| `rewriteWith` | 新規則：`WITH? LOCK` | #7 |
| `acuDestroyStatement` | 支援多個逗號分隔 identifiers | #9 |
| `acuUnlockStatement` | 新規則：`UNLOCK fileName` | #10 |
| `statement` | 新增 `acuUnlockStatement` alternative | #10 |
| `setStatement` | 新增 `setEnvironmentStatement` alternative | #11 |
| `setEnvironmentStatement` | 新規則：`ENVIRONMENT (identifier \| literal) TO (identifier \| literal)` | #11 |
| `PARAGRAPH` | 新 lexer token | #4 |
| `UNLOCK` | 新 lexer token + `cobolWord` | #10 |
| `acuScreenContinuation` | 新增多個 keyword tokens 至 alternatives、移除 `PROCEDURE` | #5, #8 |

---

## 最終驗證結果

```
$ dotnet build ConvertCobol.sln
Build succeeded. 0 Error(s), 13 Warning(s)

$ dotnet run -- ast cbl/HRRCB1IF.cbl
AST 報告已寫入: ast/HRRCB1IF_ast.md
PROGRAM-ID: HRRCB1IF, 語句數: 1394

$ dotnet test ConvertCobol.Tests
Passed! - Failed: 0, Passed: 199, Skipped: 0, Total: 199
```

**0 parse errors** — 完整解析成功。
