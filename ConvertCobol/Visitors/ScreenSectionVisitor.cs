/*
 * 更新時間：2026-03-03
 * 作者：AI Assistant
 * 摘要：從 CobolAstVisitor 提取 SCREEN SECTION 相關方法至獨立類別，負責解析 ScreenDescriptionItemNode 層級結構
 */

using System.Text;
using Antlr4.Runtime.Tree;
using ConvertCobol.Generated;
using ConvertCobol.Models;
using Microsoft.Extensions.Logging;

namespace ConvertCobol.Visitors;

/// <summary>Handles SCREEN SECTION parsing, extracting ScreenDescriptionItemNode hierarchy from COBOL source.</summary>
public class ScreenSectionVisitor
{
    private readonly ILogger _logger;
    private readonly string? _cobolSource;
    private readonly Func<IRuleNode, object?> _visitChildren;
    private Stack<ScreenDescriptionItemNode> _screenItemStack = new();
    private Dictionary<ScreenDescriptionItemNode, int> _screenItemLineNumbers = new();
    private Dictionary<ScreenDescriptionItemNode, string> _screenItemRawText = new();
    private List<AstNode>? _dataItemTarget;

    public ScreenSectionVisitor(ILogger logger, string? cobolSource, Func<IRuleNode, object?> visitChildren)
    {
        _logger = logger;
        _cobolSource = cobolSource;
        _visitChildren = visitChildren;
    }

    private static string? GetText(IParseTree? node) => node?.GetText()?.Trim();

    public object? VisitScreenSection(Cobol85AcuParser.ScreenSectionContext context, ProgramAst ast, DivisionNode? currentDataDivision)
    {
        _logger.LogDebug("[SCREEN] VisitScreenSection: 開始解析 SCREEN SECTION");
        _screenItemStack.Clear();
        var section = new ScreenSectionNode { SectionName = "SCREEN" };
        _dataItemTarget = section.Children;
        _visitChildren(context);
        _dataItemTarget = null;
        if (currentDataDivision != null)
            currentDataDivision.Children.Add(section);

        // 後處理：填充 guiProperties（從原始文字提取 continuation lines）
        FillScreenItemPropertiesFromSource(section);

        ast.ScreenSectionItemCount = CountScreenItemsRecursive(section.Children);
        _logger.LogDebug($"[SCREEN] VisitScreenSection: 完成，共 {section.Children.Count} 個 entries，{ast.ScreenSectionItemCount} 個 screen items");
        return null;
    }

    /// <summary>遞迴統計 SCREEN SECTION 中所有 ScreenDescriptionItemNode 數量。</summary>
    private static int CountScreenItemsRecursive(List<AstNode> nodes)
    {
        var count = 0;
        foreach (var node in nodes)
        {
            if (node is ScreenDescriptionItemNode item)
            {
                count += 1 + CountScreenItemsRecursive(item.Children.Cast<AstNode>().ToList());
            }
        }
        return count;
    }

    public object? VisitScreenDescriptionEntry(Cobol85AcuParser.ScreenDescriptionEntryContext context)
    {
        var item = new ScreenDescriptionItemNode();
        var levelTok = context.INTEGERLITERAL();
        if (levelTok != null)
            item.Level = levelTok.GetText() ?? "";
        var sn = context.screenName();
        if (sn != null)
            item.Name = GetText(sn) ?? "";
        else if (context.FILLER() != null)
            item.Name = "FILLER";

        var lineClauses = context.screenDescriptionLineClause();
        if (lineClauses.Length > 0) item.LineClause = GetText(lineClauses[0]);
        var colClauses = context.screenDescriptionColumnClause();
        if (colClauses.Length > 0) item.ColumnClause = GetText(colClauses[0]);
        var sizeClauses = context.screenDescriptionSizeClause();
        if (sizeClauses.Length > 0) item.SizeClause = GetText(sizeClauses[0]);
        var valClauses = context.screenDescriptionValueClause();
        if (valClauses.Length > 0) item.ValueClause = GetText(valClauses[0]);
        var picClauses = context.screenDescriptionPictureClause();
        if (picClauses.Length > 0) item.PictureClause = GetText(picClauses[0]);
        var fgClauses = context.screenDescriptionForegroundColorClause();
        if (fgClauses.Length > 0) item.ForegroundColorClause = GetText(fgClauses[0]);
        var bgClauses = context.screenDescriptionBackgroundColorClause();
        if (bgClauses.Length > 0) item.BackgroundColorClause = GetText(bgClauses[0]);

        _logger.LogDebug($"[SCREEN] VisitScreenDescriptionEntry: level={item.Level}, name={item.Name}");
        _logger.LogDebug($"[SCREEN] VisitScreenDescriptionEntry: 子句數量 - Line:{lineClauses.Length}, Col:{colClauses.Length}, Size:{sizeClauses.Length}, Value:{valClauses.Length}, Pic:{picClauses.Length}");

        // 記錄行號和原始文字
        var lineNumber = context.Start != null ? context.Start.Line : 0;
        var rawText = context.GetText();
        if (lineNumber > 0)
        {
            _screenItemLineNumbers[item] = lineNumber;
            _screenItemRawText[item] = rawText;
            _logger.LogDebug($"[SCREEN] VisitScreenDescriptionEntry: 記錄行號 {lineNumber}, 原始文字長度={rawText.Length}");
        }

        // 建立父子關係
        if (_screenItemStack.Count > 0)
        {
            var parent = _screenItemStack.Peek();
            // 如果當前 item 的 level > parent 的 level，則為 child
            if (CompareLevels(item.Level, parent.Level) > 0)
            {
                parent.Children.Add(item);
                _logger.LogDebug($"[SCREEN] VisitScreenDescriptionEntry: 加入 parent (level={parent.Level}, name={parent.Name}) 的 Children");
            }
            else
            {
                // level <= parent level，需要回溯 stack 找到正確的 parent
                while (_screenItemStack.Count > 0 && CompareLevels(_screenItemStack.Peek().Level, item.Level) >= 0)
                {
                    _screenItemStack.Pop();
                }
                if (_screenItemStack.Count > 0)
                {
                    _screenItemStack.Peek().Children.Add(item);
                    _logger.LogDebug($"[SCREEN] VisitScreenDescriptionEntry: 回溯後加入 parent (level={_screenItemStack.Peek().Level}, name={_screenItemStack.Peek().Name}) 的 Children");
                }
                else
                {
                    _dataItemTarget?.Add(item);
                    _logger.LogDebug($"[SCREEN] VisitScreenDescriptionEntry: 無 parent，加入 section.Children");
                }
            }
        }
        else
        {
            _dataItemTarget?.Add(item);
            _logger.LogDebug($"[SCREEN] VisitScreenDescriptionEntry: stack 為空，加入 section.Children");
        }

        // 將當前 item 推入 stack
        _screenItemStack.Push(item);

        var result = _visitChildren(context);
        _logger.LogDebug($"[SCREEN] VisitScreenDescriptionEntry: 完成，guiProperties.Count={item.GuiProperties.Count}, guiType={item.GuiType ?? "null"}, children.Count={item.Children.Count}");
        return result;
    }

    public object? VisitAcuScreenContinuation(Cobol85AcuParser.AcuScreenContinuationContext context)
    {
        var text = context?.GetText()?.Trim();
        _logger.LogDebug($"[SCREEN] VisitAcuScreenContinuation: text=\"{text}\"");
        if (string.IsNullOrEmpty(text))
        {
            _logger.LogDebug("[SCREEN] VisitAcuScreenContinuation: text 為空，跳過");
            return _visitChildren(context);
        }

        // 檢測是否為新 entry（以數字開頭，如 "03 S-RCB1-Fr-1"）
        if (char.IsDigit(text[0]))
        {
            // 解析新 entry
            var entry = ParseScreenEntryFromContinuation(text);
            if (entry != null)
            {
                // 記錄行號和原始文字
                var lineNumber = context.Start?.Line ?? 0;
                var rawText = context.GetText() ?? "";
                if (lineNumber > 0)
                {
                    _screenItemLineNumbers[entry] = lineNumber;
                    _screenItemRawText[entry] = rawText;
                    _logger.LogDebug($"[SCREEN] VisitAcuScreenContinuation: 記錄新 entry 行號 {lineNumber}, 原始文字長度={rawText.Length}");
                }

                // 加入 parent 的 Children
                if (_screenItemStack.Count > 0)
                {
                    var parent = _screenItemStack.Peek();
                    // 如果 entry 的 level > parent 的 level，則為 child
                    if (CompareLevels(entry.Level, parent.Level) > 0)
                    {
                        parent.Children.Add(entry);
                        _screenItemStack.Push(entry);
                        _logger.LogDebug($"[SCREEN] VisitAcuScreenContinuation: 新 entry 加入 parent (level={parent.Level}, name={parent.Name}) 的 Children");
                    }
                    else
                    {
                        // level <= parent level，需要回溯 stack 找到正確的 parent
                        while (_screenItemStack.Count > 0 && CompareLevels(_screenItemStack.Peek().Level, entry.Level) >= 0)
                        {
                            _screenItemStack.Pop();
                        }
                        if (_screenItemStack.Count > 0)
                        {
                            _screenItemStack.Peek().Children.Add(entry);
                            _screenItemStack.Push(entry);
                            _logger.LogDebug($"[SCREEN] VisitAcuScreenContinuation: 回溯後加入 parent (level={_screenItemStack.Peek().Level}, name={_screenItemStack.Peek().Name}) 的 Children");
                        }
                        else
                        {
                            // 無 parent，加入 section.Children
                            _dataItemTarget?.Add(entry);
                            _screenItemStack.Push(entry);
                            _logger.LogDebug("[SCREEN] VisitAcuScreenContinuation: 無 parent，加入 section.Children");
                        }
                    }
                }
                else
                {
                    // 無 parent，加入 section.Children
                    _dataItemTarget?.Add(entry);
                    _screenItemStack.Push(entry);
                    _logger.LogDebug("[SCREEN] VisitAcuScreenContinuation: stack 為空，加入 section.Children");
                }
            }
            return _visitChildren(context);
        }

        // 取得當前最後一個 ScreenDescriptionItemNode（從 stack）
        if (_screenItemStack.Count == 0)
        {
            _logger.LogWarning("[SCREEN] VisitAcuScreenContinuation: 警告 - stack 為空，無法找到 ScreenDescriptionItemNode");
            return _visitChildren(context);
        }

        var last = _screenItemStack.Peek();
        var beforeCount = last.GuiProperties.Count;

        // 解析 continuation 文字為 key-value pairs
        var parsedProperties = ParseGuiProperties(text);
        foreach (var kvp in parsedProperties)
        {
            last.GuiProperties[kvp.Key] = kvp.Value;
        }

        // 識別 GuiType（Frame、Label、Grid 等）
        var firstWord = text.Split(new[] { ' ', ',', '\t' }, StringSplitOptions.RemoveEmptyEntries).FirstOrDefault();
        if (!string.IsNullOrEmpty(firstWord))
        {
            if (string.Equals(firstWord, "Frame", StringComparison.OrdinalIgnoreCase))
                last.GuiType ??= "Frame";
            else if (string.Equals(firstWord, "Label", StringComparison.OrdinalIgnoreCase))
                last.GuiType ??= "Label";
            else if (string.Equals(firstWord, "Grid", StringComparison.OrdinalIgnoreCase))
                last.GuiType ??= "Grid";
        }

        _logger.LogDebug($"[SCREEN] VisitAcuScreenContinuation: 成功解析，guiProperties.Count={beforeCount}→{last.GuiProperties.Count}, guiType={last.GuiType ?? "null"}");
        return _visitChildren(context);
    }

    /// <summary>從 continuation 文字解析 ScreenDescriptionEntry（當 grammar 將 entry 解析為 continuation 時）。</summary>
    private ScreenDescriptionItemNode? ParseScreenEntryFromContinuation(string text)
    {
        // 解析 "03 S-RCB1-Fr-1, Frame," 或 "03S-RCB1-Fr-1Frame," 格式（parser 可能會移除空格）
        // 1. 提取 level（開頭的數字，如 "03"）
        // 2. 提取 name（level 後的 identifier，如 "S-RCB1-Fr-1"）
        // 3. 提取 GuiType（Frame, Label, Grid 等）

        var item = new ScreenDescriptionItemNode();
        var trimmed = text.Trim();

        // 提取 level（開頭的數字）
        var levelEnd = 0;
        while (levelEnd < trimmed.Length && char.IsDigit(trimmed[levelEnd]))
        {
            levelEnd++;
        }
        if (levelEnd == 0) return null; // 不是以數字開頭

        var levelStr = trimmed.Substring(0, levelEnd);
        item.Level = levelStr;

        // 跳過空格和逗號
        var nameStart = levelEnd;
        while (nameStart < trimmed.Length && (trimmed[nameStart] == ' ' || trimmed[nameStart] == ','))
        {
            nameStart++;
        }

        // 提取 name（直到遇到逗號或關鍵字）
        var nameEnd = nameStart;
        var guiTypeKeywords = new[] { "Frame", "Label", "Grid" };
        var foundGuiType = false;

        // 尋找 GuiType 關鍵字的位置
        var upperText = trimmed.ToUpperInvariant();
        foreach (var keyword in guiTypeKeywords)
        {
            var keywordUpper = keyword.ToUpperInvariant();
            var keywordIndex = upperText.IndexOf(keywordUpper, nameStart, StringComparison.Ordinal);
            if (keywordIndex >= nameStart)
            {
                // 找到關鍵字，name 結束於關鍵字前
                nameEnd = keywordIndex;
                item.GuiType = keyword;
                foundGuiType = true;
                break;
            }
        }

        // 如果沒找到關鍵字，name 結束於第一個逗號
        if (!foundGuiType)
        {
            var commaIndex = trimmed.IndexOf(',', nameStart);
            if (commaIndex > nameStart)
            {
                nameEnd = commaIndex;
            }
            else
            {
                nameEnd = trimmed.Length;
            }
        }

        // 提取 name
        if (nameEnd > nameStart)
        {
            item.Name = trimmed.Substring(nameStart, nameEnd - nameStart).Trim();
        }

        // 如果還沒找到 GuiType，再次嘗試（可能在 name 之後）
        if (!foundGuiType)
        {
            var remaining = trimmed.Substring(nameEnd).ToUpperInvariant();
            foreach (var keyword in guiTypeKeywords)
            {
                if (remaining.Contains(keyword.ToUpperInvariant()))
                {
                    item.GuiType = keyword;
                    break;
                }
            }
        }

        _logger.LogDebug($"[SCREEN] ParseScreenEntryFromContinuation: level={item.Level}, name={item.Name}, guiType={item.GuiType ?? "null"}");
        return item;
    }

    /// <summary>解析 continuation 文字為 key-value pairs。</summary>
    private static Dictionary<string, string> ParseGuiProperties(string text)
    {
        var properties = new Dictionary<string, string>();

        // 智能分割：考慮括號和引號，只在外層分割逗號
        var parts = SplitRespectingParentheses(text);

        foreach (var part in parts)
        {
            var trimmed = part.Trim();
            if (string.IsNullOrEmpty(trimmed)) continue;

            // 特殊處理：EXCEPTION PROCEDURE（parser 可能會移除空格，變成 EXCEPTIONPROCEDURE 或 EXCEPTIONPROCEDURES）
            var upperTrimmed = trimmed.ToUpperInvariant();
            if (upperTrimmed.StartsWith("EXCEPTIONPROCEDURE", StringComparison.OrdinalIgnoreCase)
                || upperTrimmed.StartsWith("EXCEPTION PROCEDURE", StringComparison.OrdinalIgnoreCase))
            {
                // 找到 "PROCEDURE" 的位置
                var procedureIndex = upperTrimmed.IndexOf("PROCEDURE", StringComparison.OrdinalIgnoreCase);
                if (procedureIndex >= 0)
                {
                    var value = trimmed.Substring(procedureIndex + "PROCEDURE".Length).Trim();
                    // 移除句點
                    if (value.EndsWith(".")) value = value.Substring(0, value.Length - 1).Trim();
                    // 如果 value 以 S- 開頭（identifier），提取它
                    if (value.StartsWith("S-", StringComparison.OrdinalIgnoreCase) || value.StartsWith("S", StringComparison.OrdinalIgnoreCase))
                    {
                        // value 已經是正確的 identifier
                    }
                    properties["EXCEPTION PROCEDURE"] = value;
                    continue;
                }
            }

            // 檢測是否為新 entry（以兩位數字開頭，如 "03 S-RCB1-Fr-1"）
            // 注意：屬性名稱也可能以數字開頭（如 "3-D"），需要區分
            if (trimmed.Length >= 2 && char.IsDigit(trimmed[0]) && char.IsDigit(trimmed[1]))
            {
                // 檢查是否為 level number（如 "03"）後面跟著空格和 identifier
                // 格式：兩位數字 + 空格/逗號 + identifier（如 "S-RCB1-Fr-1"）
                var afterLevel = trimmed.Substring(2).TrimStart(',', ' ');
                if (afterLevel.Length > 0 && (char.IsLetter(afterLevel[0]) || afterLevel[0] == 'S' || afterLevel[0] == 's'))
                {
                    // 這是新 entry，不處理（會在 VisitScreenDescriptionEntry 中處理）
                    continue;
                }
            }

            // 嘗試拆分為 key-value（以第一個空格為分隔）
            var spaceIndex = trimmed.IndexOf(' ');
            if (spaceIndex > 0)
            {
                var key = trimmed.Substring(0, spaceIndex).Trim();
                var value = trimmed.Substring(spaceIndex + 1).Trim();

                // 移除 value 開頭的 "IS "（如果有的話）
                if (value.StartsWith("IS ", StringComparison.OrdinalIgnoreCase))
                {
                    value = value.Substring(3).Trim();
                }

                // 移除句點（如果有的話）
                if (value.EndsWith(".")) value = value.Substring(0, value.Length - 1).Trim();

                // Key 中包含空格時用底線替換（但 EXCEPTION PROCEDURE 已特殊處理）
                if (key.Contains(' '))
                {
                    key = key.Replace(' ', '_');
                }

                properties[key] = value;
            }
            else
            {
                // 無法拆分，作為 key，value 為 "True"
                var key = trimmed.TrimEnd('.');
                properties[key] = "True";
            }
        }

        return properties;
    }

    /// <summary>智能分割文字，考慮括號和引號，只在外層分割逗號。</summary>
    private static List<string> SplitRespectingParentheses(string text)
    {
        var parts = new List<string>();
        var currentPart = new StringBuilder();
        int openParens = 0;
        bool inQuotes = false;
        char quoteChar = '\0';

        foreach (var ch in text)
        {
            if (!inQuotes)
            {
                if (ch == '(')
                {
                    openParens++;
                    currentPart.Append(ch);
                }
                else if (ch == ')')
                {
                    openParens--;
                    currentPart.Append(ch);
                }
                else if (ch == '"' || ch == '\'')
                {
                    inQuotes = true;
                    quoteChar = ch;
                    currentPart.Append(ch);
                }
                else if (ch == ',' && openParens == 0)
                {
                    // 外層逗號，分割
                    var part = currentPart.ToString().Trim();
                    if (!string.IsNullOrEmpty(part))
                    {
                        parts.Add(part);
                    }
                    currentPart.Clear();
                }
                else
                {
                    currentPart.Append(ch);
                }
            }
            else
            {
                currentPart.Append(ch);
                if (ch == quoteChar)
                {
                    inQuotes = false;
                    quoteChar = '\0';
                }
            }
        }

        // 添加最後一部分
        var lastPart = currentPart.ToString().Trim();
        if (!string.IsNullOrEmpty(lastPart))
        {
            parts.Add(lastPart);
        }

        return parts;
    }

    /// <summary>從原始 COBOL 文字填充 ScreenDescriptionItemNode 的 guiProperties（後處理 continuation lines）。</summary>
    private void FillScreenItemPropertiesFromSource(ScreenSectionNode section)
    {
        if (string.IsNullOrEmpty(_cobolSource)) return;

        var lines = _cobolSource.Split(new[] { '\r', '\n' }, StringSplitOptions.None);

        // 找到 SCREEN SECTION 的起始行
        var screenSectionStartLine = FindScreenSectionStartLine(lines);
        if (screenSectionStartLine < 0) return;

        _logger.LogDebug($"[SCREEN] FillScreenItemPropertiesFromSource: SCREEN SECTION 起始行 {screenSectionStartLine}");

        // 遍歷所有 ScreenDescriptionItemNode（遞迴處理 children）
        FillScreenItemPropertiesRecursive(section.Children, lines, screenSectionStartLine, section);
    }

    private int FindScreenSectionStartLine(string[] lines)
    {
        for (int i = 0; i < lines.Length; i++)
        {
            var line = lines[i].Trim();
            // 跳過註解行
            if (line.StartsWith("*") || line.StartsWith("*>"))
                continue;

            // 尋找 SCREEN SECTION（不是註解）
            if (line.Contains("SCREEN", StringComparison.OrdinalIgnoreCase)
                && line.Contains("SECTION", StringComparison.OrdinalIgnoreCase))
            {
                return i + 1; // 行號從 1 開始
            }
        }
        return -1;
    }

    private void FillScreenItemPropertiesRecursive(List<AstNode> items, string[] lines, int startLine, ScreenSectionNode section)
    {
        if (items == null)
        {
            _logger.LogDebug("[SCREEN] FillScreenItemPropertiesRecursive: items 為 null");
            return;
        }

        _logger.LogDebug($"[SCREEN] FillScreenItemPropertiesRecursive: 處理 {items.Count} 個 items");

        // 創建深層副本以避免在遍歷時修改集合導致的錯誤
        // 使用索引遍歷而不是 foreach，以避免集合修改問題
        var itemsToProcess = new List<ScreenDescriptionItemNode>();
        for (int i = 0; i < items.Count; i++)
        {
            if (items[i] is ScreenDescriptionItemNode screenItem)
            {
                itemsToProcess.Add(screenItem);
            }
        }

        // 現在遍歷副本，即使原始集合被修改也不會有問題
        foreach (var screenItem in itemsToProcess)
        {
            // 找到該 item 在原始文字中的行號
            var itemLine = _screenItemLineNumbers.ContainsKey(screenItem)
                ? _screenItemLineNumbers[screenItem]
                : FindItemLineInSource(screenItem, lines, startLine);

            _logger.LogDebug($"[SCREEN] FillScreenItemPropertiesRecursive: item level={screenItem.Level}, name={screenItem.Name}, 記錄的行號={(_screenItemLineNumbers.ContainsKey(screenItem) ? _screenItemLineNumbers[screenItem].ToString() : "無")}, 找到的行號={itemLine}");

            if (itemLine > 0)
            {
                _logger.LogDebug($"[SCREEN] FillScreenItemPropertiesRecursive: 處理 item level={screenItem.Level}, name={screenItem.Name}, line={itemLine}");
                // 提取 continuation lines 並解析，同時創建新發現的 entries
                FillSingleScreenItemProperties(screenItem, lines, itemLine, section);
            }
            else
            {
                _logger.LogWarning($"[SCREEN] FillScreenItemPropertiesRecursive: 警告 - 無法找到 item level={screenItem.Level}, name={screenItem.Name} 的行號");
            }

            // 遞迴處理 children（創建副本以避免集合修改問題）
            var childrenCopy = new List<AstNode>(screenItem.Children.Cast<AstNode>());
            FillScreenItemPropertiesRecursive(childrenCopy, lines, startLine, section);
        }
    }

    private int FindItemLineInSource(ScreenDescriptionItemNode item, string[] lines, int startLine)
    {
        // 從 SCREEN SECTION 開始尋找包含 item level 和 name 的行
        // 優先使用記錄的行號
        if (_screenItemLineNumbers.ContainsKey(item))
        {
            var recordedLine = _screenItemLineNumbers[item];
            // 驗證該行是否包含 item name
            if (recordedLine > 0 && recordedLine <= lines.Length)
            {
                var line = lines[recordedLine - 1].Trim();
                if (line.Contains(item.Name))
                {
                    return recordedLine;
                }
            }
        }

        // 如果記錄的行號無效，則搜尋
        for (int i = startLine - 1; i < lines.Length; i++)
        {
            var line = lines[i].Trim();
            if (string.IsNullOrEmpty(line) || line.StartsWith("*") || line.StartsWith("*>"))
                continue;

            // 檢測是否為 section 結束
            if (line.Contains("PROCEDURE", StringComparison.OrdinalIgnoreCase)
                && line.Contains("DIVISION", StringComparison.OrdinalIgnoreCase))
                break;

            // 檢查是否包含 level 和 name
            // level 可能是 "3" 或 "03"，需要匹配兩種格式
            var levelStr = item.Level;
            var levelStrPadded = int.TryParse(item.Level, out var levelNum) ? levelNum.ToString("00") : item.Level.PadLeft(2, '0');
            if ((line.StartsWith(levelStr + " ") || line.StartsWith(levelStr + ",") ||
                 line.StartsWith(levelStrPadded + " ") || line.StartsWith(levelStrPadded + ","))
                && line.Contains(item.Name))
            {
                return i + 1; // 行號從 1 開始
            }
        }
        return -1;
    }

    private void FillSingleScreenItemProperties(ScreenDescriptionItemNode item, string[] lines, int itemLine, ScreenSectionNode section)
    {
        // 讀取從 itemLine 開始的 continuation lines
        // 直到下一個 entry（以數字開頭的行）或 section 結束
        var continuationLines = new List<string>();

        // 先找到包含 item name 的行（不依賴行號，因為行號可能不一致）
        int actualItemLineIndex = -1;
        var levelStr = int.TryParse(item.Level, out var levelNum) ? levelNum.ToString("00") : item.Level.PadLeft(2, '0'); // "03"
        for (int i = 0; i < lines.Length; i++)
        {
            var line = lines[i].Trim();
            if (string.IsNullOrEmpty(line) || line.StartsWith("*") || line.StartsWith("*>"))
                continue;

            // 檢查是否包含 level 和 name
            if ((line.StartsWith(levelStr + " ") || line.StartsWith(levelStr + ","))
                && line.Contains(item.Name))
            {
                actualItemLineIndex = i;
                _logger.LogDebug($"[SCREEN] FillSingleScreenItemProperties: 找到 item 行 {i + 1}: {line.Substring(0, Math.Min(80, line.Length))}");
                break;
            }
        }

        if (actualItemLineIndex < 0)
        {
            _logger.LogWarning($"[SCREEN] FillSingleScreenItemProperties: 警告 - 無法找到 item level={item.Level}, name={item.Name} 的行");
            return;
        }

        // 從 entry 定義行的下一行開始收集 continuation lines
        // 因為 entry 定義行本身已經在 VisitAcuScreenContinuation 中處理過了
        for (int i = actualItemLineIndex + 1; i < lines.Length; i++)
        {
            var line = lines[i].Trim();
            if (string.IsNullOrEmpty(line) || line.StartsWith("*") || line.StartsWith("*>"))
            {
                _logger.LogDebug($"[SCREEN] FillSingleScreenItemProperties: 行 {i + 1} 為空或註解，跳過");
                continue;
            }

            // 檢測是否為新 entry（以 level 數字開頭，如 "01", "03" 等，且不是當前 item）
            var trimmed = line.TrimStart();
            int? detectedLevel = null;
            bool isNewEntry = false;

            // 檢查是否以 level 數字開頭（1-2 位數字，後跟空格或逗號）
            if (trimmed.Length >= 2 && char.IsDigit(trimmed[0]) && char.IsDigit(trimmed[1]))
            {
                // 可能是 level 01-99，檢查是否為新 entry
                var twoDigitLevelStr = trimmed.Substring(0, 2);
                if (int.TryParse(twoDigitLevelStr, out var level) && level >= 1 && level <= 99)
                {
                    // 檢查後續是否為空格或逗號（表示這是 level）
                    if (trimmed.Length > 2 && (trimmed[2] == ' ' || trimmed[2] == ','))
                    {
                        // 檢查是否為當前 item 的 continuation（可能在同一行）
                        if (!line.Contains(item.Name))
                        {
                            isNewEntry = true;
                            detectedLevel = level;
                            _logger.LogDebug($"[SCREEN] FillSingleScreenItemProperties: 行 {i + 1} 為新 entry (level={level})，創建新 item。內容: {line.Substring(0, Math.Min(50, line.Length))}");
                        }
                    }
                }
            }
            else if (trimmed.Length >= 1 && char.IsDigit(trimmed[0]))
            {
                // 單個數字開頭，可能是 level 1-9，但需要檢查後續字符
                var singleLevelStr = trimmed.Substring(0, 1);
                if (int.TryParse(singleLevelStr, out var level) && level >= 1 && level <= 9)
                {
                    // 檢查後續是否為空格或逗號（表示這是 level）
                    if (trimmed.Length > 1 && (trimmed[1] == ' ' || trimmed[1] == ','))
                    {
                        if (!line.Contains(item.Name))
                        {
                            isNewEntry = true;
                            detectedLevel = level;
                            _logger.LogDebug($"[SCREEN] FillSingleScreenItemProperties: 行 {i + 1} 為新 entry (level={level})，創建新 item。內容: {line.Substring(0, Math.Min(50, line.Length))}");
                        }
                    }
                }
            }

            if (isNewEntry && detectedLevel.HasValue)
            {
                // 檢查是否已經存在這個 item（避免重複創建）
                // 遞迴檢查整個 AST 樹
                bool ItemExists(ScreenDescriptionItemNode checkItem, ScreenDescriptionItemNode? rootItem, ScreenSectionNode section)
                {
                    // 檢查 section 的直接 children
                    foreach (var astItem in section.Children)
                    {
                        if (astItem is ScreenDescriptionItemNode screenItem)
                        {
                            if (screenItem.Level == checkItem.Level && screenItem.Name == checkItem.Name)
                                return true;
                            // 遞迴檢查子樹
                            if (ItemExistsInSubtree(checkItem, screenItem))
                                return true;
                        }
                    }
                    return false;
                }

                bool ItemExistsInSubtree(ScreenDescriptionItemNode checkItem, ScreenDescriptionItemNode parent)
                {
                    foreach (var child in parent.Children)
                    {
                        if (child.Level == checkItem.Level && child.Name == checkItem.Name)
                            return true;
                        if (ItemExistsInSubtree(checkItem, child))
                            return true;
                    }
                    return false;
                }

                // 創建新 entry
                var newItem = CreateScreenItemFromLine(line, i + 1, detectedLevel.Value);
                if (newItem != null && !string.IsNullOrEmpty(newItem.Name))
                {
                    // 檢查是否已存在（檢查整個 AST 樹）
                    if (ItemExists(newItem, item, section))
                    {
                        _logger.LogDebug($"[SCREEN] FillSingleScreenItemProperties: item level={newItem.Level}, name={newItem.Name} 已存在，跳過創建");
                    }
                    else
                    {
                        // 解析 entry 定義行本身可能包含的屬性（在 name 和 guiType 之後）
                        var entryLineTrimmed = line.Trim();
                        var nameAndGuiTypeEnd = entryLineTrimmed.IndexOf(newItem.Name, StringComparison.OrdinalIgnoreCase);
                        if (nameAndGuiTypeEnd >= 0)
                        {
                            nameAndGuiTypeEnd += newItem.Name.Length;
                            // 跳過 guiType（如果有的話）
                            if (!string.IsNullOrEmpty(newItem.GuiType))
                            {
                                var guiTypeIndex = entryLineTrimmed.IndexOf(newItem.GuiType, nameAndGuiTypeEnd, StringComparison.OrdinalIgnoreCase);
                                if (guiTypeIndex >= nameAndGuiTypeEnd)
                                {
                                    nameAndGuiTypeEnd = guiTypeIndex + newItem.GuiType.Length;
                                }
                            }
                            // 跳過逗號和空格
                            while (nameAndGuiTypeEnd < entryLineTrimmed.Length && (entryLineTrimmed[nameAndGuiTypeEnd] == ',' || entryLineTrimmed[nameAndGuiTypeEnd] == ' '))
                                nameAndGuiTypeEnd++;

                            // 如果還有內容，解析為屬性
                            if (nameAndGuiTypeEnd < entryLineTrimmed.Length)
                            {
                                var remainingProperties = entryLineTrimmed.Substring(nameAndGuiTypeEnd);
                                var parsedProperties = ParseGuiProperties(remainingProperties);
                                foreach (var kvp in parsedProperties)
                                {
                                    if (!newItem.GuiProperties.ContainsKey(kvp.Key))
                                    {
                                        newItem.GuiProperties[kvp.Key] = kvp.Value;
                                        _logger.LogDebug($"[SCREEN] FillSingleScreenItemProperties: 從 entry 定義行解析屬性 {kvp.Key}={kvp.Value}");
                                    }
                                }
                            }
                        }

                        // 找到正確的 parent
                        var parent = FindParentForScreenItem(newItem, item, section);
                        if (parent != null)
                        {
                            parent.Children.Add(newItem);
                            _logger.LogDebug($"[SCREEN] FillSingleScreenItemProperties: 新 item level={newItem.Level}, name={newItem.Name} 已加入 parent level={parent.Level}, name={parent.Name}");

                            // 遞迴處理新 item 的 continuation lines
                            FillSingleScreenItemProperties(newItem, lines, i + 1, section);
                        }
                        else
                        {
                            // 無 parent，加入 section
                            section.Children.Add(newItem);
                            _logger.LogDebug($"[SCREEN] FillSingleScreenItemProperties: 新 item level={newItem.Level}, name={newItem.Name} 已加入 section");

                            // 遞迴處理新 item 的 continuation lines
                            FillSingleScreenItemProperties(newItem, lines, i + 1, section);
                        }
                    }
                }
                // 繼續處理當前 item 的 continuation lines（新 entry 已經被處理）
                break;
            }

            // 檢測是否為 section 結束
            if (line.Contains("PROCEDURE", StringComparison.OrdinalIgnoreCase)
                && line.Contains("DIVISION", StringComparison.OrdinalIgnoreCase))
            {
                _logger.LogDebug($"[SCREEN] FillSingleScreenItemProperties: 行 {i + 1} 為 section 結束，停止收集");
                break;
            }

            continuationLines.Add(line);
            _logger.LogDebug($"[SCREEN] FillSingleScreenItemProperties: 收集行 {i + 1}: {line.Substring(0, Math.Min(50, line.Length))}");
        }

        _logger.LogDebug($"[SCREEN] FillSingleScreenItemProperties: 共收集 {continuationLines.Count} 行 continuation lines");

        // 合併包含未閉合括號的行
        var mergedLines = MergeContinuationLinesWithParentheses(continuationLines);

        // 解析 continuation lines 為 key-value pairs
        foreach (var line in mergedLines)
        {
            // 跳過 entry 定義行（已在 VisitAcuScreenContinuation 中處理）
            var trimmed2 = line.TrimStart();
            if (trimmed2.StartsWith(item.Level) && trimmed2.Contains(item.Name))
            {
                // 這是 entry 定義行，可能包含 GuiType（Frame, Label 等）
                // 但 properties 應該在後續行
                _logger.LogDebug($"[SCREEN] FillSingleScreenItemProperties: 跳過 entry 定義行: {line.Substring(0, Math.Min(50, line.Length))}");
                continue;
            }

            // 解析 continuation line
            _logger.LogDebug($"[SCREEN] FillSingleScreenItemProperties: 解析行: {line.Substring(0, Math.Min(80, line.Length))}");
            var parsedProperties = ParseGuiProperties(line);
            _logger.LogDebug($"[SCREEN] FillSingleScreenItemProperties: 解析出 {parsedProperties.Count} 個屬性");
            foreach (var kvp in parsedProperties)
            {
                // 如果 key 已存在，跳過（避免覆蓋）
                if (!item.GuiProperties.ContainsKey(kvp.Key))
                {
                    item.GuiProperties[kvp.Key] = kvp.Value;
                    _logger.LogDebug($"[SCREEN] FillSingleScreenItemProperties: 添加屬性 {kvp.Key}={kvp.Value}");
                }
                else
                {
                    _logger.LogDebug($"[SCREEN] FillSingleScreenItemProperties: 屬性 {kvp.Key} 已存在，跳過");
                }
            }
        }

        _logger.LogDebug($"[SCREEN] FillSingleScreenItemProperties: 完成，item level={item.Level}, name={item.Name}, guiProperties.Count={item.GuiProperties.Count}");
    }

    /// <summary>合併包含未閉合括號的 continuation lines。</summary>
    private static List<string> MergeContinuationLinesWithParentheses(List<string> lines)
    {
        var merged = new List<string>();
        var currentLine = new StringBuilder();
        int openParens = 0;
        bool inQuotes = false;
        char quoteChar = '\0';

        for (int i = 0; i < lines.Count; i++)
        {
            var line = lines[i];
            var trimmed = line.Trim();
            if (string.IsNullOrEmpty(trimmed))
            {
                if (currentLine.Length > 0)
                {
                    currentLine.Append(" ");
                }
                continue;
            }

            // 追蹤括號和引號
            foreach (var ch in trimmed)
            {
                if (!inQuotes)
                {
                    if (ch == '(')
                        openParens++;
                    else if (ch == ')')
                        openParens--;
                    else if (ch == '"' || ch == '\'')
                    {
                        inQuotes = true;
                        quoteChar = ch;
                    }
                }
                else
                {
                    if (ch == quoteChar)
                    {
                        inQuotes = false;
                        quoteChar = '\0';
                    }
                }
            }

            if (currentLine.Length > 0)
                currentLine.Append(" ");
            currentLine.Append(trimmed);

            // 如果所有括號和引號都已閉合，則完成當前行
            if (openParens == 0 && !inQuotes)
            {
                // 如果行以逗號或句點結尾，或者是最後一行，則完成
                bool shouldComplete = trimmed.EndsWith(",") || trimmed.EndsWith(".") || (i == lines.Count - 1);

                // 或者檢查下一行是否以字母開頭（可能是新屬性）
                if (!shouldComplete && i < lines.Count - 1)
                {
                    var nextLine = lines[i + 1].Trim();
                    if (!string.IsNullOrEmpty(nextLine) && char.IsLetter(nextLine[0]))
                    {
                        // 下一行以字母開頭，可能是新屬性，完成當前行
                        shouldComplete = true;
                    }
                }

                if (shouldComplete)
                {
                    merged.Add(currentLine.ToString());
                    currentLine.Clear();
                    openParens = 0;
                    inQuotes = false;
                    quoteChar = '\0';
                }
            }
        }

        // 添加剩餘的行（如果有的話）
        if (currentLine.Length > 0)
        {
            merged.Add(currentLine.ToString());
        }

        return merged;
    }

    /// <summary>從原始文字行創建 ScreenDescriptionItemNode。
    /// 更新時間：2026-02-09 16:22
    /// 作者：AI Assistant
    /// 摘要：修改為從原始字符串提取 level，保留前導零（如 "03" 而不是 "3"）
    /// </summary>
    private ScreenDescriptionItemNode? CreateScreenItemFromLine(string line, int lineNumber, int detectedLevel)
    {
        var trimmed = line.Trim();
        if (string.IsNullOrEmpty(trimmed))
            return null;

        // 使用 ParseScreenEntryFromContinuation 的邏輯來解析
        var item = ParseScreenEntryFromContinuation(trimmed);
        if (item == null)
        {
            // 如果 ParseScreenEntryFromContinuation 失敗，嘗試手動解析
            // 從原始字符串提取 level，保留前導零（如 "03"）
            var levelStr2 = "";
            var nameStart = 0;
            while (nameStart < trimmed.Length && char.IsDigit(trimmed[nameStart]))
            {
                levelStr2 += trimmed[nameStart];
                nameStart++;
            }

            // 如果沒有提取到 level，使用 detectedLevel（但格式化為兩位數）
            if (string.IsNullOrEmpty(levelStr2))
            {
                levelStr2 = detectedLevel.ToString("00");
            }

            item = new ScreenDescriptionItemNode { Level = levelStr2 };
            while (nameStart < trimmed.Length && (trimmed[nameStart] == ' ' || trimmed[nameStart] == ','))
                nameStart++;

            // 提取 name（直到遇到逗號或關鍵字）
            var nameEnd = nameStart;
            var guiTypeKeywords = new[] { "Frame", "Label", "Grid" };
            var foundGuiType = false;
            var upperText = trimmed.ToUpperInvariant();

            foreach (var keyword in guiTypeKeywords)
            {
                var keywordUpper = keyword.ToUpperInvariant();
                var keywordIndex = upperText.IndexOf(keywordUpper, nameStart, StringComparison.Ordinal);
                if (keywordIndex >= nameStart)
                {
                    nameEnd = keywordIndex;
                    item.GuiType = keyword;
                    foundGuiType = true;
                    break;
                }
            }

            if (!foundGuiType)
            {
                var commaIndex = trimmed.IndexOf(',', nameStart);
                if (commaIndex > nameStart)
                    nameEnd = commaIndex;
                else
                    nameEnd = trimmed.Length;
            }

            if (nameEnd > nameStart)
            {
                item.Name = trimmed.Substring(nameStart, nameEnd - nameStart).Trim();
            }

            // 如果還沒找到 GuiType，再次嘗試
            if (!foundGuiType)
            {
                var remaining = trimmed.Substring(nameEnd).ToUpperInvariant();
                foreach (var keyword in guiTypeKeywords)
                {
                    if (remaining.Contains(keyword.ToUpperInvariant()))
                    {
                        item.GuiType = keyword;
                        break;
                    }
                }
            }
        }

        if (item != null && !string.IsNullOrEmpty(item.Name))
        {
            // 記錄行號和原始文字
            _screenItemLineNumbers[item] = lineNumber;
            _screenItemRawText[item] = line;
            _logger.LogDebug($"[SCREEN] CreateScreenItemFromLine: 創建 item level={item.Level}, name={item.Name}, guiType={item.GuiType ?? "null"}, line={lineNumber}");
        }

        return item;
    }

    /// <summary>比較兩個 level 字符串（"01", "03", "05" 等）。</summary>
    private static int CompareLevels(string level1, string level2)
    {
        if (int.TryParse(level1, out var l1) && int.TryParse(level2, out var l2))
        {
            return l1.CompareTo(l2);
        }
        return string.Compare(level1, level2, StringComparison.Ordinal);
    }

    /// <summary>根據 level 找到正確的 parent。</summary>
    private ScreenDescriptionItemNode? FindParentForScreenItem(ScreenDescriptionItemNode newItem, ScreenDescriptionItemNode currentItem, ScreenSectionNode section)
    {
        // 如果新 item 的 level > 當前 item 的 level，則當前 item 為 parent
        if (CompareLevels(newItem.Level, currentItem.Level) > 0)
        {
            _logger.LogDebug($"[SCREEN] FindParentForScreenItem: 新 item level={newItem.Level} > 當前 item level={currentItem.Level}，parent 為當前 item");
            return currentItem;
        }

        // 如果新 item 的 level <= 當前 item 的 level，需要向上找到正確的 parent
        // 從 section 開始，遞迴搜尋包含 currentItem 的路徑，建立路徑列表
        List<ScreenDescriptionItemNode>? path = null;

        bool FindPath(List<AstNode> items, ScreenDescriptionItemNode target, List<ScreenDescriptionItemNode> currentPath)
        {
            foreach (var item in items)
            {
                if (item is ScreenDescriptionItemNode screenItem)
                {
                    var newPath = new List<ScreenDescriptionItemNode>(currentPath) { screenItem };

                    if (screenItem == target)
                    {
                        path = newPath;
                        return true;
                    }

                    if (FindPath(screenItem.Children.Cast<AstNode>().ToList(), target, newPath))
                    {
                        return true;
                    }
                }
            }
            return false;
        }

        if (FindPath(section.Children, currentItem, new List<ScreenDescriptionItemNode>()))
        {
            // 從路徑的末尾向前搜尋，找到第一個 level < newItem.Level 的 item
            if (path != null)
            {
                for (int i = path.Count - 1; i >= 0; i--)
                {
                    if (CompareLevels(path[i].Level, newItem.Level) < 0)
                    {
                        _logger.LogDebug($"[SCREEN] FindParentForScreenItem: 找到 parent level={path[i].Level}, name={path[i].Name}");
                        return path[i];
                    }
                }
            }
        }

        // 如果找不到合適的 parent，返回 null（將加入 section）
        _logger.LogDebug($"[SCREEN] FindParentForScreenItem: 未找到合適的 parent，將加入 section");
        return null;
    }
}
