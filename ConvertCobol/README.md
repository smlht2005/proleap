# ConvertCobol

COBOL AST converter for ACUCOBOL-GT: parse COBOL source/listing files into structured JSON AST, Markdown reports, and C# procedure code. Built on .NET 8 with ANTLR4.

## Features

- **PROCEDURE DIVISION**: Paragraphs and typed statement nodes (MOVE, PERFORM, CALL, IF, EVALUATE, DISPLAY, READ, etc.)
- **DATA DIVISION**: File section, working storage, linkage, screen section with hierarchical DataItem trees
- **ENVIRONMENT DIVISION**: INPUT-OUTPUT SECTION, file control entries (FILE-STATUS, record keys)
- **Statement subclasses**: 18 typed statement classes (MoveStatement, IfStatement, EvaluateStatement, etc.) with structured properties
- **C# code generation**: PROCEDURE DIVISION to C# with EVALUATE->switch, IF->if-else, condition translation
- **DataItem hierarchy**: Automatic parent-child tree building based on COBOL level numbers (01/05/10/77/88)
- **Multi-encoding**: UTF-8, Big5/MS950 auto-detection
- **Logging**: `--verbose` / `-v` flag for diagnostic output via `ILogger`

## Project Structure

```
ConvertCobol/
├── Program.cs                  # CLI entry point (~30 lines)
├── Grammar/                    # Cobol85Acu.g4 ANTLR grammar
├── Visitors/
│   ├── CobolAstVisitor.cs      # Main ANTLR visitor (~1500 lines)
│   ├── ScreenSectionVisitor.cs # SCREEN SECTION visitor (~1100 lines)
│   └── DataItemHierarchyBuilder.cs  # Level-based tree builder
├── Models/
│   ├── AstNode.cs              # Base class with JSON polymorphism
│   ├── ProgramAst.cs           # Root AST model
│   ├── DataItemNode.cs         # Data item with Children hierarchy
│   └── Statements/             # 18 typed statement subclasses
│       ├── MoveStatement.cs
│       ├── IfStatement.cs
│       ├── EvaluateStatement.cs
│       ├── PerformStatement.cs
│       ├── CallStatement.cs
│       ├── DisplayStatement.cs
│       └── ... (12 more)
├── CodeGen/
│   ├── ProcedureToCSharpEmitter.cs      # PROCEDURE -> C# code gen
│   ├── ProcedureToPseudoCodeEmitter.cs  # PROCEDURE -> pseudo code
│   └── ProcedureToMermaidEmitter.cs     # PROCEDURE -> Mermaid flowchart
├── Preprocessing/
│   ├── CommentNormalizer.cs    # Traditional comment conversion
│   └── EncodingHelper.cs      # Multi-encoding detection
├── Parsing/
│   ├── LexerErrorListener.cs   # ANTLR lexer error handling
│   └── ParserErrorListener.cs  # ANTLR parser error handling
├── Reporters/
│   ├── JsonAstReporter.cs      # JSON output
│   └── MarkdownAstReporter.cs  # Markdown report output
├── Loaders/
│   └── AstJsonLoader.cs        # JSON -> ProgramAst loader
├── Converters/
│   └── StatementNodeJsonConverter.cs  # JSON serialization
├── ConvertCobol.Tests/         # xUnit test project (86 tests)
│   ├── BaselineTests.cs
│   ├── CommentNormalizerTests.cs
│   ├── EncodingHelperTests.cs
│   ├── EmitterTests.cs
│   └── DataItemHierarchyTests.cs
└── docs/                       # Design documents
```

## Requirements

- [.NET 8 SDK](https://dotnet.microsoft.com/download/dotnet/8.0)

## Build and Run

```bash
# Build
dotnet build ConvertCobol.sln

# Run tests
dotnet test ConvertCobol.Tests

# Parse COBOL to JSON AST
dotnet run -- ast input.cbl output_ast.json

# Parse COBOL to Markdown report
dotnet run -- ast input.cbl output_ast.md

# Parse with verbose logging
dotnet run -- ast input.cbl output_ast.json --verbose

# Parse and generate C# procedure code
dotnet run -- ast input.cbl output_ast.json big5 output_procedure.cs

# Read existing JSON AST
dotnet run -- read output_ast.json
```

## CLI Usage

```
ConvertCobol ast <input.lst|input.cbl> [output.md|output.json] [charset] [procedure.cs] [--verbose]
ConvertCobol read <input.json>
ConvertCobol emit <input_proc.json> [output] [--format pseudo|mermaid|both]
```

- `ast` - Parse COBOL and produce AST report (JSON or Markdown based on extension)
- `read` - Load JSON AST and display summary
- `emit` - Convert procedure JSON to pseudo code and/or Mermaid flowchart
  - `--format pseudo` - Output structured pseudo code only
  - `--format mermaid` - Output Mermaid flowchart only
  - `--format both` (default) - Output both pseudo code and Mermaid flowchart
- `--verbose` / `-v` - Enable diagnostic logging (trace-level)
- Default charset: `big5`
- Environment variables: `CONVERTCOBOL_AST_INPUT`, `CONVERTCOBOL_AST_OUTPUT`, `CONVERTCOBOL_AST_CHARSET`

## JSON Output

The JSON AST uses `$type` discriminators for polymorphic node types:

```json
{
  "$type": "ProgramAst",
  "programId": "SAMPLE",
  "procedure": {
    "$type": "DivisionNode",
    "children": [
      {
        "$type": "ParagraphNode",
        "name": "MAIN-LOGIC",
        "statements": [
          {
            "$type": "MoveStatement",
            "moveFrom": "ZEROS",
            "moveTo": "WS-COUNT"
          },
          {
            "$type": "IfStatement",
            "ifCondition": "WS-STATUS EQUAL 0",
            "thenStatements": [...]
          }
        ]
      }
    ]
  }
}
```

Statement `$type` values: `MoveStatement`, `PerformStatement`, `CallStatement`, `IfStatement`, `EvaluateStatement`, `DisplayStatement`, `AcceptStatement`, `OpenStatement`, `CloseStatement`, `ReadStatement`, `WriteStatement`, `RewriteStatement`, `StartStatement`, `InitializeStatement`, `StringStatement`, `InspectStatement`, `ComputeStatement`, `SimpleStatement`.

## Documentation

- [Plan 2a: Procedure division in AST](docs/plan2a_procedure_division_in_ast.md)
- [Plan 2: AST to C# and Next.js](docs/plan2_ast_json_to_csharp_and_nextjs.md)
