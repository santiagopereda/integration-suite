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

# --- Skills: copy SKILL.md and companion files from hub skills directories ---
SKILLS=(
  integration-pipeline
)

echo "=== Skills ==="
for skill in "${SKILLS[@]}"; do
  src_dir="${HUB_ROOT}/.claude/skills/${skill}"
  dest_dir="${PLUGIN_DIR}/skills/${skill}"
  mkdir -p "$dest_dir"

  # Copy SKILL.md
  if [ -f "$src_dir/SKILL.md" ]; then
    cp "$src_dir/SKILL.md" "$dest_dir/SKILL.md"
    echo "  synced: ${skill}/SKILL.md"
  else
    echo "  SKIP:   ${src_dir}/SKILL.md not found"
  fi

  # Copy companion scripts (*.sh)
  for sh_file in "$src_dir"/*.sh; do
    [ -f "$sh_file" ] || continue
    cp "$sh_file" "$dest_dir/"
    chmod +x "$dest_dir/$(basename "$sh_file")"
    echo "  synced: ${skill}/$(basename "$sh_file")"
  done
done

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
