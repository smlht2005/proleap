# Proleap

COBOL AST converter and listing tools for ACUCOBOL-GT: parse listings and source into JSON AST (procedure division, data division, structured statements). Used for migration and Plan 2 (C# API + Next.js).

## Features

- **ConvertCobol** (.NET 8): ANTLR4-based parser producing `*_ast.json`
  - **PROCEDURE DIVISION**: Paragraphs and statements (MOVE, PERFORM, CALL, IF, DISPLAY, READ, etc.) with two-level expansion (entry paragraph + all routines)
  - **DATA DIVISION**: File section, working storage, linkage, screen section
  - **ENVIRONMENT DIVISION**: INPUT-OUTPUT SECTION, file control entries (FILE-STATUS, record keys)
  - **Statement structuring**: `performTarget`, `moveFrom`/`moveTo`, `ifCondition`/`thenStatements`/`elseStatements`, DISPLAY attributes (e.g. `displayHandle`, `displayUpon`), etc.
  - **Data integrity**: Validation and recovery for missing statements (e.g. DISPLAY after comment lines); optional diagnostic logging
- **Java/Maven**: Listing cleaner (`.lst` → `.cbl`), AST/migration report generators

## Project structure

```
proleap/
├── ConvertCobol/           # .NET 8 AST converter
│   ├── Grammar/            # Cobol85Acu.g4, preprocessor
│   ├── Visitors/           # CobolAstVisitor, ProgramAstVisitor
│   ├── Models/             # ProgramAst, ParagraphNode, StatementNode, ...
│   ├── ast/                # Output: *_ast.json, *_ast_proc.json, *_ast_data.json
│   └── docs/               # Plan 2a, Plan 2, handoff notes
├── list/                   # Input listing files (.lst)
├── cbl/                    # Cleaned COBOL source (.cbl)
├── ast/                    # Additional AST/reports
├── src/main/java/          # Java listing cleaner & migration tools
├── dev_readme.md           # Detailed dev and AST output docs
└── docs/                   # Migration guide, ANTLR plan
```

## Requirements

- **ConvertCobol**: [.NET 8 SDK](https://dotnet.microsoft.com/download/dotnet/8.0)
- **Java tools**: JDK 17+, Maven 3.x

## Build and run (ConvertCobol)

```bash
cd ConvertCobol
dotnet build
dotnet run -- ast list/HRRCB1IF.lst ast/HRRCB1IF_ast.json
```

Output: `ast/HRRCB1IF_ast.json` (full), `ast/HRRCB1IF_ast_proc.json` (procedure), `ast/HRRCB1IF_ast_data.json` (data). See `ConvertCobol/docs/plan2a_procedure_division_in_ast.md` for procedure division and Plan 2a.

## Build and run (Java)

```bash
mvn compile
mvn exec:java -Dexec.mainClass="com.hiscore.cobol.parser.CobolParserApp" -Dexec.args="ast list/HRRCB1IF.lst ast/HRRCB1IF_ast.md"
```

See `dev_readme.md` for listing cleanup, migration guide, and environment variables.

## Documentation

- [Plan 2a: Procedure division in AST](ConvertCobol/docs/plan2a_procedure_division_in_ast.md) — goals, two-level expansion, DISPLAY recovery, data integrity
- [Plan 2: AST to C# and Next.js](ConvertCobol/docs/plan2_ast_json_to_csharp_and_nextjs.md) — downstream codegen
- [dev_readme.md](dev_readme.md) — environment, commands, AST output layout

## License

See repository or project files for license information.
