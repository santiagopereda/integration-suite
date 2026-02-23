# Integration Suite Setup

Re-initialize or reset the integration suite templates in the current project.

## When to Use

- Templates are missing or corrupted
- You want to restore default templates after customizing
- First-time setup didn't run (SessionStart hook was skipped)

## Instructions

Run the setup script to copy integration templates to the project:

```bash
bash "${CLAUDE_PLUGIN_ROOT}/scripts/setup-templates.sh" .
```

This copies templates from the plugin to `.agent/templates/integration/` in the current project. Existing files are **not overwritten** (no-clobber mode).

To force-reset all templates to defaults, remove the directory first:

```bash
rm -rf .agent/templates/integration
bash "${CLAUDE_PLUGIN_ROOT}/scripts/setup-templates.sh" .
```

After setup, verify templates are in place:

```bash
ls .agent/templates/integration/
```

You should see 19 template files including `scoring-rubric.md`, `assessment-questionnaire.md`, and the `platform-parsers/` subdirectory.
