# HRRCB1IF_ast.json — statementType = "OTHER" 清單

> 來源：`HRRCB1IF_ast.json`（目前 82 筆）。  
> 說明：EXIT 語句已於 Visitor 改為產出 `statementType: "EXIT"`，重新產生 AST 後 EXIT 會從此清單消失，僅剩其餘 OTHER 供後續擴充語句類型用。

| # | text（摘要） |
|---|--------------|
| 1 | INSPECT Acu-Msg-1 TALLYING |
| 2 | SET Exit-Pushed TO TRUE |
| 3 | SET Exit-Pushed TO TRUE |
| 4 | GO TO Acu-S-RCB1-Mn-1-Exit |
| 5 | GO TO Acu-S-RCB1-Mn-1-EXIT |
| 6 | CONTINUE |
| 7 | SET EVENT-ACTION TO EVENT-ACTION-FAIL |
| 8 | SET EVENT-ACTION TO EVENT-ACTION-FAIL |
| 9 | SET EVENT-ACTION TO EVENT-ACTION-FAIL |
| 10 | EXIT |
| 11 | EXIT |
| 12 | SUBTRACT 1 FROM W-GRID-Y |
| 13 | SET EVENT-ACTION  TO Event-Action-Complete |
| 14 | ADD 1 TO W-GRID-Y |
| 15 | SET EVENT-ACTION  TO Event-Action-Complete |
| 16 | SET EVENT-ACTION TO EVENT-ACTION-FAIL |
| 17 | SET EVENT-ACTION TO EVENT-ACTION-FAIL |
| 18 | EXIT |
| 19 | GO TO F-READN-RTN |
| 20 | EXIT |
| 21 | INSPECT A4GL-WHERE-CONSTRAINT REPLACING TRAILING SPACES BY LOW-VALUES |
| 22 | ADD 1 TO W-NO |
| 23 | CONTINUE |
| 24 | DIVIDE W-OUT-SON BY W-OUT-MOTHER GIVING W-GG REMAINDER W-RR |
| 25 | ADD 1 TO W-PAGE |
| 26 | SUBTRACT 1 FROM W-PAGE |
| 27 | CANCEL "HTRPTICF" |
| 28 | GO TO F-HT-DELETE-EXIT |
| 29 | GO TO F-HT-DELETE-EXIT |
| 30 | GO TO F-HT-DELETE-EXIT |
| 31 | EXIT |
| 32 | GO TO |
| 33 | EXIT |
| 34 | ADD 1 TO W-ODRW-CNT |
| 35 | ADD 1 TO W-ODRW-CNT |
| 36 | ADD 1 TO W-ODRW-CNT |
| 37 | ADD 1 TO W-LX-SCH-COUNT |
| 38 | CANCEL "HXGSCHKF" |
| 39 | DELETE FNS-MST |
| 40 | ADD 1 TO W-HRDTA-COUNT |
| 41 | CONTINUE |
| 42 | GO TO F-READ-RNUJ-RTN |
| 43 | ADD 1 TO RNU-J-NO |
| 44 | EXIT |
| 45 | EXIT |
| 46 | EXIT |
| 47 | EXIT |
| 48 | EXIT |
| 49 | EXIT |
| 50 | EXIT |
| 51 | EXIT |
| 52 | EXIT |
| 53 | CONTINUE |
| 54 | EXIT |
| 55 | EXIT |
| 56 | EXIT |
| 57 | EXIT |
| 58 | EXIT |
| 59 | ADD 1 TO W-NO |
| 60 | EXIT |
| 61 | CONTINUE |
| 62 | CONTINUE |
| 63 | ADD 1 TO W-LOG2-CON |
| 64 | EXIT |
| 65 | EXIT |
| 66 | EXIT |
| 67 | EXIT |
| 68 | EXIT |
| 69 | EXIT |
| 70 | EXIT |
| 71 | EXIT |
| 72 | EXIT |
| 73 | EXIT |
| 74 | EXIT |
| 75 | ADD 1 TO W-MT |
| 76 | EXIT |
| 77 | SEARCH W-DEP-TAB1 VARYING ... END-SEARCH |
| 78 | SEARCH W-DR-TAB1 VARYING ... END-SEARCH |
| 79 | SET ENVIRONMENT "CURSOR-MODE" TO |
| 80 | SET ENVIRONMENT "CURSOR-MODE" TO |
| 81 | ADD 1 TO W-PERCENT |
| 82 | ADD W-PERCENT-ADD TO W-PERCENT |

**說明**：上表為依 JSON 出現順序整理之「statementType = OTHER」語句；共 **82 筆**（與 `grep "statementType\": \"OTHER\""` 次數一致）。重新產生 AST 後，所有 `EXIT` 語句會改為 `statementType: "EXIT"`，此清單可再依新 AST 重新產出以檢查剩餘 OTHER。
