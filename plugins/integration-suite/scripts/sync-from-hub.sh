#!/usr/bin/env bash
# sync-from-hub.sh — Sync integration suite files from the Agentic hub to this plugin
#
# Usage: bash sync-from-hub.sh [hub-root]
#
# Run from the plugin directory or pass the hub root explicitly.
# This is a maintainer tool, not for end users.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLUGIN_DIR="$(dirname "$SCRIPT_DIR")"

HUB_ROOT="${1:-$(dirname "$(dirname "$PLUGIN_DIR")")}"

echo "Syncing from hub: ${HUB_ROOT}"
echo "Plugin target:    ${PLUGIN_DIR}"
echo ""

# --- Agents: copy and strip 'model: sonnet' line ---
AGENTS=(
  agent-integration-analyzer
  agent-integration-assessor
  agent-integration-scorer
  agent-integration-designer
  agent-integration-reviewer
)

echo "=== Agents ==="
for agent in "${AGENTS[@]}"; do
  src="${HUB_ROOT}/.claude/agents/${agent}.md"
  dest="${PLUGIN_DIR}/agents/${agent}.md"
  if [ -f "$src" ]; then
    # Remove the 'model: sonnet' line from frontmatter
    sed '/^model: sonnet$/d' "$src" > "$dest"
    echo "  synced: ${agent}.md (model line stripped)"
  else
    echo "  SKIP:   ${src} not found"
  fi
done

# --- Commands: copy all except summarize-integration (manually maintained) ---
COMMANDS=(
  analyze-integration
  assess-integration
  score-integration
  review-integration
)

echo ""
echo "=== Commands ==="
for cmd in "${COMMANDS[@]}"; do
  src="${HUB_ROOT}/.claude/commands/${cmd}.md"
  dest="${PLUGIN_DIR}/commands/${cmd}.md"
  if [ -f "$src" ]; then
    cp "$src" "$dest"
    echo "  synced: ${cmd}.md"
  else
    echo "  SKIP:   ${src} not found"
  fi
done
echo "  SKIP:   summarize-integration.md (manually maintained in plugin)"

# --- Templates: rsync entire directory ---
echo ""
echo "=== Templates ==="
SRC_TEMPLATES="${HUB_ROOT}/.agent/templates/integration/"
DEST_TEMPLATES="${PLUGIN_DIR}/templates/integration/"

if [ -d "$SRC_TEMPLATES" ]; then
  rsync -av --delete "$SRC_TEMPLATES" "$DEST_TEMPLATES"
  echo "  templates synced"
else
  echo "  SKIP: ${SRC_TEMPLATES} not found"
fi

echo ""
echo "Sync complete. Review changes with: git diff plugins/integration-suite/"
