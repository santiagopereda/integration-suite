# Project Type Folder Structures

Reference structures for `.agent/` directory by project type.

## Integration Projects

Best for: API integrations, ETL pipelines, data synchronization

```
.agent/
├── README.md
├── injection-history.md
├── sops/              # Repeatable procedures (100% usage for integration projects)
├── system/            # Schemas, APIs, mappings
└── workflows/         # Integration flow documentation
```

## Development Projects

Best for: Web apps, CLI tools, libraries, features

```
.agent/
├── README.md
├── injection-history.md
├── decisions/         # Architecture Decision Records
├── schemas/           # Data models
└── testing/           # Test strategies
```

## Research Projects

Best for: Spikes, POCs, learning projects, investigations

```
.agent/
├── README.md
├── injection-history.md
├── findings/          # What was discovered
├── hypotheses/        # Assumptions to test
└── gaps/              # What's still unknown
```

## Optimization Projects

Best for: Refactoring, performance tuning, migrations

```
.agent/
├── README.md
├── injection-history.md
├── templates/         # Externalized content
├── metrics/           # Baselines and tracking
└── experiments/       # What was tried
```

## Custom Projects

For hybrid or unique projects, user selects from all available folders:

**Integration**: sops/, system/, workflows/
**Development**: decisions/, schemas/, testing/
**Research**: findings/, hypotheses/, gaps/
**Optimization**: templates/, metrics/, experiments/
