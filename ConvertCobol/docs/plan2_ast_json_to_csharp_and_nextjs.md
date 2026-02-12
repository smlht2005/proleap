---
name: AST JSON to C# and Next.js
overview: 以 ConvertCobol 產出的「完整 AST JSON」（含 PROCEDURE、DATA、SCREEN、ENVIRONMENT）為唯一輸入，下游依此 JSON 產生 C# 變數/DTO/API 與 Next.js 頁面；本計畫為第二計畫，採「程式實作版」：具體 JSON 路徑、命名規則與程式範例，供 C# / Next.js / COBOL 實作對照。
---

<!-- 更新時間：2025-02-10；摘要：新增 Section 10 第二輪審閱（與實際程式碼/AST 差異、範例檔 paragraphCount 為 0、前端錯誤處理、命名與路由對應、procedure 為空時步驟、測試策略）。 -->
<!-- 更新時間：2025-02-10；摘要：新增 Section 9 審閱與修正建議（優點、缺口與建議補強、風險與緩解、建議優先修正）。 -->

# Plan 2（程式實作版）：從完整 AST JSON 產出 C# 與 Next.js

> 本文件存放於 `ConvertCobol/docs/`，與 ConvertCobol 專案一併版控。

## 1. AST JSON 結構速查（單一來源）

- **檔案**：ConvertCobol 產出之 `*_ast.json`（例如 `ast/HRRCB1IF_ast.json`）。
- **根結構**：`meta`、`overview`、`ast`。
- **關鍵路徑**（camelCase，與 [JsonAstReporter](../Reporters/JsonAstReporter.cs) 一致）：

| 用途 | JSON 路徑 | 說明 |
|------|------------|------|
| 程式識別 | `ast.programId` | 對應 C# 命名空間/Next.js 模組前綴 |
| Procedure | `ast.procedure.children[]` | 每項 `$type: "Paragraph"`，含 `name`、`isSection`、`statements[]` |
| Statement | `statements[].statementType`, `text`, `moveFrom`/`moveTo`, `performTarget`/`performThru`, `callTarget`/`callArgs` | 驅動 API 邏輯與 C# 方法骨架 |
| Data (WS/Linkage) | `ast.data.children[]` | 項目標記 `$type: "WorkingStorageSection"` / `"LinkageSection"`，其下 `children[]` 為 DataItem |
| DataItem | `$type: "DataItem"`, `level`, `name`, `picClause`, `valueClause`, `occurs`, `children` | 驅動 C# 變數/DTO 與 TypeScript 型別 |
| Screen | 位於 `ast.data.children[]` 內 `$type: "ScreenSection"` 的 `children[]` | 每項 `$type: "ScreenDescriptionItem"`, `level`, `name`, `guiType`, `guiProperties`, `children` |
| File control | `ast.environment.children[]` 中 `$type: "InputOutputSection"` → `children[]` 為 `$type: "FileControlEntry"` | `fileName`, `recordKeyName`, `recordKeyFields` 等，驅動 Repository/資料存取 |

- **註**：若 `overview.paragraphCount === 0`，表示 procedure 未成功解析，需先修正 parser 或改用較小 COBOL 驗證。

---

## 2. C# 產出：變數、DTO、API（可實作規則）

### 2.1 COBOL 名稱 → C# 命名

- **規則**：`W-RUNL-CHK` → `WRunlChk`（PascalCase 屬性/類別）；連字號 `-` 移除並將下一字母大寫。
- **實作**：可與 [ProcedureToCSharpEmitter](../CodeGen/ProcedureToCSharpEmitter.cs) 的 `ParagraphNameToCSharpMethod` 一致；資料名建議統一產出 PascalCase 屬性。

### 2.2 PIC → C# 型別對照表

| COBOL PIC（從 `picClause`） | C# 型別 | 備註 |
|-----------------------------|---------|------|
| `X(n)` | `string` | 必要時 `[MaxLength(n)]` |
| `9(n)`、`9(n) DISPLAY` | `int` 或 `long` | n <= 9 → int；否則 long |
| `9(n)V9(m)`、`S9(n)V9(m)` | `decimal` | 小數位依 m |
| `S9(n)` | `int`/`long` | 依 n |
| `A(n)` | `string` | 同 X |
| 無 PIC（僅 valueClause） | 依 value 推斷或 `string` | 可當常數/列舉 |

- **OCCURS**：`occurs` 有值 → C# 為 `List<T>` 或 `T[]`。

### 2.3 從 JSON 讀取 AST 並產出 DTO（C# 端）

- **反序列化**：使用 `System.Text.Json`，根型別可定義為 `AstJsonRoot`，內含 `Ast`、`Overview`。
- **DataItem 走訪**：遞迴 `ast.data.children`，篩選 WorkingStorageSection / LinkageSection，再走訪其 `children`；對每個 level 01 或 77 產出一個 C# 類別，子層為屬性或巢狀類別。
- **產出範例**：見 Section 4.5。

### 2.4 從 JSON 產出 API（Controller + Service）

- **段落 → 端點**：`ast.procedure.children[]` 每筆 Paragraph 的 `name` 對應一個 C# 方法與 REST 端點（例：Acu-Main-Logic → POST /api/rcb1/main）。
- **Service 方法內**：依 `statements[]` 產出 MOVE→指派、PERFORM→呼叫他法、CALL→TODO 或實際呼叫、其餘→註解。
- **註**：可從 JSON 反序列化後重用或改寫 [ProcedureToCSharpEmitter](../CodeGen/ProcedureToCSharpEmitter.cs) 的邏輯。

### 2.5 檔案控制 → 資料存取（C#）

- 每個 FileControlEntry 產出 Repository 介面（如 `INID_MSTRepository`）；FD 下 DataItem 產出錄格式 DTO。

---

## 3. Next.js 產出：頁面與元件（可實作規則）

### 3.1 GuiType → React 對照

| guiType | Next.js / React 建議 |
|---------|------------------------|
| Frame | `<section>` 或自訂 Frame（div + border） |
| Label | `<label>` 或 `<span>` |
| Entry | `<input>` |
| Grid | `<table>` 或 DataGrid |
| Button | `<button>`，onClick 呼叫 C# API 端點 |

- **guiProperties**：COL、LINE → 排版；SIZE、VALUE → 寬度/預設值。

### 3.2 頁面結構（App Router）

- 一屏一頁：每個頂層 Screen 區塊對應 `app/<programId>/page.tsx`。
- 表單欄位 `name` 與 C# DTO 屬性一致；提交按鈕呼叫對應 paragraph 端點。

### 3.3 TypeScript 型別與 API Client

- DTO 介面與 C# 對齊（camelCase 建議）；API client 基底 URL 用 `NEXT_PUBLIC_API_URL`。

---

## 4. C# Web API 範本程式碼

### 4.1 專案結構建議

```
HISCore.Api/
├── Program.cs
├── appsettings.json
├── Controllers/
├── Services/
├── Dtos/
├── Data/
└── Ast/
```

### 4.2 Program.cs 範本（ASP.NET Core 8，含 CORS）

```csharp
var builder = WebApplication.CreateBuilder(args);
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
// builder.Services.AddScoped<IRcb1Service, Rcb1Service>();

var app = builder.Build();
app.UseCors(policy =>
{
    policy.WithOrigins(
            app.Environment.IsDevelopment() ? "http://localhost:3000" : builder.Configuration["Frontend:Origin"] ?? "")
        .AllowAnyMethod()
        .AllowAnyHeader();
});
app.UseSwagger();
app.UseSwaggerUI();
app.MapControllers();
app.Run();
```

### 4.3 Controller 範本

```csharp
[ApiController]
[Route("api/[controller]")]
[Produces("application/json")]
public class Rcb1Controller : ControllerBase
{
    private readonly IRcb1Service _service;
    public Rcb1Controller(IRcb1Service service) => _service = service;

    [HttpPost("main")]
    public async Task<IActionResult> AcuMainLogic([FromBody] WsRcb1Request? request, CancellationToken ct)
    {
        try
        {
            var result = await _service.Acu_Main_LogicAsync(request ?? new WsRcb1Request(), ct);
            return Ok(result);
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { message = "Execution failed.", detail = ex.Message });
        }
    }
}
```

### 4.4 Service 範本

```csharp
public interface IRcb1Service
{
    Task<WsRcb1Response> Acu_Main_LogicAsync(WsRcb1Request request, CancellationToken ct = default);
}

public class Rcb1Service : IRcb1Service
{
    public async Task<WsRcb1Response> Acu_Main_LogicAsync(WsRcb1Request request, CancellationToken ct)
    {
        await Task.CompletedTask;
        return new WsRcb1Response { Success = true };
    }
}
```

### 4.5 DTO 範本

```csharp
public class WsRcb1Request
{
    public string? PatNo { get; set; }
    public decimal? Amount { get; set; }
}

public class WsRcb1Response
{
    public bool Success { get; set; }
    public string? Message { get; set; }
}
```

### 4.6 appsettings.json 要點

```json
{
  "Logging": { "LogLevel": { "Default": "Information" } },
  "AllowedHosts": "*",
  "Frontend:Origin": "http://localhost:3000",
  "ConnectionStrings": {}
}
```

---

## 5. Next.js 範本程式碼

### 5.1 專案結構建議

```
his-core-ui/
├── app/
│   ├── layout.tsx
│   ├── page.tsx
│   └── rcb1/page.tsx
├── components/ScreenFromAst.tsx
├── lib/api.ts
├── lib/types.ts
├── .env.local
└── next.config.js
```

### 5.2 單一畫面頁面範本（app/rcb1/page.tsx）

```tsx
"use client";
import { useState } from "react";
import { api } from "@/lib/api";
import type { WsRcb1Request, WsRcb1Response } from "@/lib/types";

export default function Rcb1Page() {
  const [form, setForm] = useState<WsRcb1Request>({});
  const [result, setResult] = useState<WsRcb1Response | null>(null);
  const [error, setError] = useState<string | null>(null);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);
    try {
      const res = await api.post<WsRcb1Response>("/api/rcb1/main", form);
      setResult(res);
    } catch (err: unknown) {
      setError(err instanceof Error ? err.message : "Request failed");
    }
  };

  return (
    <section className="p-4">
      <h1>RCB1 (from COBOL screen S-RCB1)</h1>
      <form onSubmit={handleSubmit}>
        <input name="patNo" value={form.patNo ?? ""} onChange={(e) => setForm((f) => ({ ...f, patNo: e.target.value }))} placeholder="PatNo" />
        <input name="amount" type="number" value={form.amount ?? ""} onChange={(e) => setForm((f) => ({ ...f, amount: Number(e.target.value) || undefined }))} placeholder="Amount" />
        <button type="submit">Execute (Acu-Main-Logic)</button>
      </form>
      {error && <p className="text-red-600">{error}</p>}
      {result && <pre>{JSON.stringify(result, null, 2)}</pre>}
    </section>
  );
}
```

### 5.3 API Client（lib/api.ts）

```ts
const BASE_URL = process.env.NEXT_PUBLIC_API_URL ?? "http://localhost:5000";

export const api = {
  async get<T>(path: string): Promise<T> {
    const res = await fetch(`${BASE_URL}${path}`, { method: "GET", headers: { "Content-Type": "application/json" } });
    if (!res.ok) throw new Error(await res.text());
    return res.json();
  },
  async post<T>(path: string, body: unknown): Promise<T> {
    const res = await fetch(`${BASE_URL}${path}`, { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify(body) });
    if (!res.ok) throw new Error(await res.text());
    return res.json();
  },
};
```

### 5.4 TypeScript 型別（lib/types.ts）

```ts
export interface WsRcb1Request {
  patNo?: string;
  amount?: number;
}

export interface WsRcb1Response {
  success: boolean;
  message?: string;
}
```

### 5.5 .env.local

```
NEXT_PUBLIC_API_URL=http://localhost:5000
```

### 5.6 遞迴 Screen 元件（ScreenFromAst）

- 從 AST 的 ScreenSection.children 傳入 items；依 `guiType` 渲染 Frame/Label/Entry；`ScreenDescriptionItem` 型別含 `level`、`name`、`guiType`、`guiProperties`、`children`。完整範例見本文件完整版或 Plan 2 原始內容。

---

## 6. 轉換時建議與註解（Advice and comments）

### 6.1 通用

- **單一真相**：C# DTO 與 Next.js 型別與同一份 AST JSON 對齊；手改其一時另一邊與 API 契約要同步。
- **命名**：COBOL 大寫+連字號；C# PascalCase，JSON/TS 建議 camelCase。
- **錯誤**：API 4xx/5xx 時 Next.js 統一處理；C# 用 exception filter 或 middleware 回傳統一格式。

### 6.2 COBOL → C# 特別注意

- PIC 9(n) 的 n 可能很大 → `long` 或 `decimal`；小數依 V/P 對應。
- OCCURS → `List<T>`；COBOL 索引 1-based 與 C# 0-based 轉換處要註解。
- REDEFINES → 多屬性對同一底層或 JsonIgnore/union。
- CALL 語句產出 TODO 後手寫實際 C# 實作。

### 6.3 COBOL → Next.js 特別注意

- 一屏多 Frame → 單頁多 `<section>` 或子元件。
- COL/LINE → CSS Grid/Flex 或相對單位。
- 必填與驗證與後端一致；功能鍵對應 button onClick 呼叫 API。

### 6.4 效能與維護

- 大 AST 可產出 Procedure-only/Data-only 小檔；AST 版本變動時反序列化加預設值或 JsonIgnore；產出檔保留「Generated from COBOL」註解。

---

## 7. 詳細步驟（Detail steps）

### Phase 0：準備與驗證

| 步驟 | 動作 | 檢查方式 |
|------|------|----------|
| 0.1 | 執行 ConvertCobol 產出 AST JSON | 存在 `*_ast.json` 且可開啟 |
| 0.2 | 確認 `overview.programId`、`paragraphCount`、`statementCount` | 必要時 paragraphCount > 0 |
| 0.3 | 確認 `ast.procedure` 存在且 `ast.procedure.children` 為陣列 | 有 procedure 才有 API 產出 |
| 0.4 | 確認 `ast.data.children` 含 WorkingStorageSection 或 LinkageSection | 有 data 才有 DTO 產出 |
| 0.5 | 若有畫面，確認存在 ScreenSection 且 children 有 ScreenDescriptionItem | 有 screen 才有頁面產出 |
| 0.6 | 決定目標程式識別（C#/Next.js 前綴） | 記錄命名如 Rcb1、HRRCB1IF |

### Phase 1：C# Web API

| 步驟 | 動作 | 檢查方式 |
|------|------|----------|
| 1.1 | 新增 ASP.NET Core Web API 專案，.NET 8 | `dotnet new webapi -n HISCore.Api` 可跑 |
| 1.2 | 加入 CORS、Swagger，Program.cs 設定 WithOrigins | 建置成功、Swagger UI 可開 |
| 1.3 | 定義 AST 反序列化 DTO（AstJsonRoot、Procedure、Paragraph、Statement、Data、DataItem 等） | AST JSON 反序列化成功 |
| 1.4 | 實作 COBOL 名稱→C# 命名、PIC→型別對照 | 單元測試或手動驗證 |
| 1.5 | 走訪 ast.data，產出 DTO 類別到 Dtos/ | 產出 .cs 可建置、型別與 PIC 對應正確 |
| 1.6 | 走訪 ast.procedure.children，產出 Controller 與 Service，每段落一方法/端點 | Controller/Service 可建置、端點數對應段落數 |
| 1.7 | Service 方法內依 statements[] 產出 MOVE/PERFORM/CALL 等 | 方法可編譯，邏輯可為骨架 |
| 1.8 | Program.cs 註冊 Service、MapControllers | 啟動 API、Swagger 可呼叫 |
| 1.9 | （選用）依 FileControlEntry 產出 Repository 介面與空實作 | 介面與實作存在 |

### Phase 2：Next.js 前端

| 步驟 | 動作 | 檢查方式 |
|------|------|----------|
| 2.1 | 新增 Next.js 專案（App Router、TypeScript） | `npm run dev` 可跑 |
| 2.2 | lib/types.ts 產出與 C# 對齊的 TS 介面 | 型別一致、無編譯錯誤 |
| 2.3 | lib/api.ts 實作 get/post，BASE_URL 用 NEXT_PUBLIC_API_URL | 可呼叫本地 C# API |
| 2.4 | .env.local 設定 NEXT_PUBLIC_API_URL | 前端可連到 API |
| 2.5 | 定義 ScreenDescriptionItem、實作 ScreenFromAst 遞迴元件 | 傳入 ScreenSection.children 可渲染樹狀 UI |
| 2.6 | 產出 app/<programId>/page.tsx，表單與提交按鈕呼叫 API | 頁面可開、按鈕可觸發 API |
| 2.7 | 根 layout 加入 header/main、導覽 | 多頁可導覽 |

### Phase 3：整合與收尾

| 步驟 | 動作 | 檢查方式 |
|------|------|----------|
| 3.1 | C# CORS 允許 Next.js origin | 請求不被 CORS 擋下 |
| 3.2 | Next.js 處理 API 錯誤並顯示 | 4xx/5xx 時使用者看到提示 |
| 3.3 | C# 統一回傳格式（Exception Filter/Middleware） | 前端可解析錯誤回應 |
| 3.4 | 關鍵流程手動或 E2E 測試 | 至少一條主流程走通 |
| 3.5 | 產出檔註解（Generated from COBOL、段落名、資料名） | 日後可對照 COBOL |
| 3.6 | （選用）Repository 實作 | 端點回傳真實資料 |

### 快速對照

- Phase 0 → Section 1、Section 6
- Phase 1 → Section 2、Section 4
- Phase 2 → Section 3、Section 5
- Phase 3 → Section 6、Section 4.2

---

## 8. 與 Plan 1、Plan 2a 的關係

- **Plan 1**：整體架構（COBOL → AST → C# API + Next.js）、階段與風險。
- **Plan 2a**：確保 `*_ast.json` 含 **PROCEDURE DIVISION**（見 [plan2a_procedure_division_in_ast.md](plan2a_procedure_division_in_ast.md)）。先完成 Plan 2a 再執行 Plan 2 可確保 `paragraphCount` > 0 時有 Controller/Service 可產。
- **Plan 2（本文件）**：以同一份 **含 procedure 的 AST JSON** 為唯一輸入，給出可依之實作的 JSON 路徑、COBOL↔C#/TS 對照、C# / Next.js 範本與詳細步驟，供產生器或手寫對照使用。

---

## 9. 審閱與修正建議（Code review）

本節為對本計畫文件之審閱意見：優點、缺口與建議補強、風險與緩解。實作或產生器開發時可依此補齊或調整。

### 9.1 優點（Strengths）

- **單一輸入**：以「完整 AST JSON」為唯一來源，C# 與 Next.js 產出皆由此推導，規格一致。
- **JSON 路徑具體**：Section 1 表格列出 `ast.procedure.children[]`、`$type`、DataItem/Screen 路徑，便於實作對照。
- **步驟可勾選**：Phase 0～3 的步驟表可逐項執行與驗收，每步皆有「檢查方式」。
- **範本可直接複用**：Program.cs、Controller、Service、DTO、Next.js 頁面與 api.ts 等可作為專案起手式。
- **COBOL 特殊點有提醒**：PIC 對應、OCCURS、REDEFINES、CALL、1-based 索引等在 Section 6 有說明，可減少實作錯誤。
- **與既有程式碼連結**：引用 JsonAstReporter、ProcedureToCSharpEmitter，與 ConvertCobol 專案一致。

### 9.2 缺口與建議補強（Gaps and suggestions）

| 項目 | 說明 | 建議 |
|------|------|------|
| **AST 與實際輸出** | 文件假設 `$type: "Paragraph"`，實際 JSON 可能為 camelCase 或其它 discriminator。 | Phase 0 或 Section 1 加一項：確認實際 `*_ast.json` 中 procedure.children 的 `$type` 值，並與反序列化 DTO 對齊。 |
| **反序列化多型** | `ast.data.children` 為混合型（FileSection、WorkingStorageSection、ScreenSection 等），需多型反序列化。 | Section 2.3 或 Phase 1 步驟 1.3 補充：使用 `[JsonPolymorphic]` / `[JsonDerivedType]` 或 TypeInfoResolver，與 ConvertCobol Models 的 JsonDerivedType 對齊。 |
| **段落名→路由規則** | 僅舉例 Acu-Main-Logic → /api/rcb1/main，未定義通用規則。 | Section 2.4 或 4.3 寫明：段落名先轉 C# 方法名，再映射為 kebab-case 或 snake_case 路徑；數字/特殊字元之替換規則一併定義。 |
| **C# 範本 namespace** | Section 4 程式碼片段未寫 namespace。 | 範本中為 Controller、Service、DTO 各加對應 namespace，或在 4.1 註明預設 namespace 對應子目錄。 |
| **Next.js 根頁** | 列出 layout.tsx、page.tsx 但未說明根路由內容。 | 5.1 或 5.2 加一句：根 `app/page.tsx` 可為程式列表或重導向至預設程式（如 /rcb1）；layout 提供共用 header/導覽。 |
| **ScreenFromAst 程式碼** | 5.6 僅文字描述，無可複製程式碼。 | 補一段精簡版 ScreenFromAst（Frame/Label/Entry 的 switch 與遞迴），或註明完整範例所在位置。 |
| **錯誤回應格式** | Controller 回傳 `{ message, detail }`，前端僅用 err.message，未約定結構。 | Section 6.1 約定 API 錯誤格式（如 `{ message: string, code?: string, detail?: string }`），並註明 Next.js 從該結構取 message/detail 顯示。 |
| **安全性與生產** | 未提及認證、授權、HTTPS、CORS 多 origin。 | Section 6 或 Phase 3 加「生產環境注意」：認證/授權、CORS 僅允許已知 origin、500 不洩漏 stack、HTTPS 與環境變數管理。 |
| **文件版本** | 未標版本或更新日，難以對照 AST 變更。 | frontmatter 或開頭加 `lastUpdated` 或「本計畫以 ConvertCobol 產出之 AST 為準，文法/Reporter 變更時請同步更新」。 |

### 9.3 風險與緩解（Risks）

| 風險 | 說明 | 緩解 |
|------|------|------|
| **procedure 為空** | 若 paragraphCount 為 0（如部分大檔），依本計畫將無 API 可產出。 | Phase 0 明確寫：若 paragraphCount 為 0，需先修 parser 或改用含 procedure 的程式；或本計畫僅產 Data/Screen，Procedure 產出略過。 |
| **AST 結構變更** | ConvertCobol 升級後 JSON 欄位或 $type 可能改變。 | Section 6.4 或 Phase 1 註明：AST 結構變更時需更新反序列化 DTO 與 Section 1 路徑表。 |
| **段落過多** | 單一程式數百個 paragraph 時，一段落一端點會導致 Controller 過大。 | Section 2.4 或 Phase 1 加註：可依業務將多段落群組為少數端點（如一畫面一 POST），或按 section 拆成多個 Controller。 |
| **Screen 與 DTO 對應** | 僅說「表單 name 與 DTO 對齊」，未定義 Screen name 與 DataItem name 的對應。 | Section 3.2 或 5.6 加一句：Screen Entry 的 name 應與 WorkingStorage/Linkage 的 DataItem name 一致（或依同一命名轉換），以利綁定與 API 收發。 |

### 9.4 建議優先修正

1. 實際 AST 的 `$type` 值與反序列化多型設定。
2. 段落名 → URL 的對應規則（含數字/特殊字元）。
3. API 錯誤回應格式與前端顯示方式。
4. procedure 為空時的處理策略（Phase 0 或 6）。
5. Section 5.6 ScreenFromAst 至少一段可複製程式碼或明確引用位置。

---

## 10. 第二輪審閱（Second code review）

本節為第二輪審閱：對照實際 AST、ConvertCobol 程式碼與範例，補強第一輪未涵蓋之項目。

### 10.1 與實際程式碼／AST 的差異

| 項目 | 文件描述 | 實際情況 | 建議 |
|------|----------|----------|------|
| **段落名 → C# 方法名** | Section 2.1：`W-RUNL-CHK` → `WRunlChk`（PascalCase，連字號移除、下一字母大寫）。 | [ProcedureToCSharpEmitter](../CodeGen/ProcedureToCSharpEmitter.cs) 的 `ParagraphNameToCSharpMethod` 為 `Replace("-", "_")`，產出為 `Acu_Main_Logic`（底線、非 PascalCase）。 | 擇一：在 2.1 註明「現行產生器採底線版；若需 PascalCase 可另行實作」；或將產生器改為 PascalCase 並與文件對齊。 |
| **$type 值** | Section 1 寫 `$type: "Paragraph"`。 | [AstNode.cs](../Models/AstNode.cs) 之 `JsonDerivedType` 確為 `"Paragraph"`、`"DataItem"`、`"WorkingStorageSection"` 等短名稱，與文件一致。 | 無需修正；可於 Phase 0 附註「與 Models 之 typeDiscriminator 一致」。 |
| **data.children 混合型** | Section 1 列 WorkingStorageSection / LinkageSection / ScreenSection。 | 實際 JSON 尚有 `FileSection`、`FileDescription`、`DataItem`（[HRRCB1IF_ast.json](../ast/HRRCB1IF_ast.json)）。 | 第一輪已建議多型反序列化；2.3 可註明「篩選時略過 FileSection／FileDescription 若僅需 WS/Linkage/Screen」。 |

### 10.2 範例檔案與文件假設不符

- **HRRCB1IF_ast.json**：文件中以 `ast/HRRCB1IF_ast.json` 為例，但該檔 `overview.paragraphCount === 0`、`statementCount === 0`，即 **無 PROCEDURE 產出**。
- **影響**：依本計畫做 Phase 1（API 產出）時，若僅用此檔驗證，將無 Controller/Service 可產。
- **建議**：在 Section 1 或 Phase 0 註明「範例路徑 `HRRCB1IF_ast.json` 為 data/screen 豐富、procedure 為空之案例；驗證 procedure 產出時請改用 paragraphCount > 0 之 AST，或先以小型 COBOL 產出含段落之 JSON」。

### 10.3 前端錯誤處理與 API 契約

- **lib/api.ts**：`if (!res.ok) throw new Error(await res.text());` 會將整段 response body 當成 message。若後端回傳 `{ "message": "...", "detail": "..." }`，使用者會看到整段 JSON 字串。
- **建議**：Section 5.3 或 6.1 補「錯誤回應為 JSON 時，先 `res.json()` 再取 `message` 或 `detail` 顯示；否則 fallback 為 `res.text()`」。

### 10.4 命名與路由對應一致性

- Controller 範本：方法 `AcuMainLogic`、路由 `[HttpPost("main")]`；Service 介面為 `Acu_Main_LogicAsync`（底線）。
- 文件同時出現 PascalCase 方法名（AcuMainLogic）與底線方法名（Acu_Main_LogicAsync），易混淆。
- **建議**：Section 4.3 / 4.4 統一約定「段落名 → C# 方法名」規則（與 2.1／ProcedureToCSharpEmitter 一致），並給出同一段落名對應的 Controller 方法、路由、Service 方法之名稱對照表（一列即可）。

### 10.5 procedure 為空時之步驟說明

- Phase 0.2、0.3 已要求確認 paragraphCount、ast.procedure；第一輪 9.3 已列「procedure 為空」風險。
- **補強**：在 Phase 1 表前加一句「若 overview.paragraphCount === 0 或 ast.procedure?.children 為空，則步驟 1.6～1.7 可略過，僅產 DTO／Repository；待有 procedure 之 AST 再補產 Controller/Service。」

### 10.6 測試與驗證策略

- 第一輪未涵蓋「測試」。
- **建議**：在 Phase 3 或 Section 6 加一項「建議各 Phase 搭配驗證方式：Phase 1 可對 AST 反序列化、COBOL 名稱→C#、PIC→型別撰寫單元測試；Phase 2 可對 api 錯誤解析、表單提交做手動或 E2E；Phase 3 至少一條主流程 E2E 通過。」

### 10.7 第二輪建議優先處理

1. **2.1 與 ProcedureToCSharpEmitter 命名規則**：二擇一或並存說明（PascalCase vs 底線）。
2. **範例檔 HRRCB1IF 的 paragraphCount 為 0**：文件註明用途與限制。
3. **前端錯誤回應**：約定 JSON 錯誤格式並在 api.ts 中解析後再顯示。
4. **Controller/Service 方法名與路由**：同一段落名之一致對照表。
5. **procedure 為空時**：Phase 1 明確寫可略過步驟。
6. **測試策略**：各 Phase 建議之驗證方式（單元／手動／E2E）。
