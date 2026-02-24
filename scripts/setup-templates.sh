#!/usr/bin/env bash
# setup-templates.sh — Copy integration templates to the user's project
#
# Usage: bash setup-templates.sh <project-root>
#
# No-clobber: existing files are never overwritten.
# The script uses CLAUDE_PLUGIN_ROOT to locate the plugin's template directory.

set -euo pipefail

PROJECT_ROOT="${1:-.}"

# Resolve plugin root — set by Claude Code when running from a plugin context.
# Fall back to the script's own directory structure for manual invocation.
if [ -z "${CLAUDE_PLUGIN_ROOT:-}" ]; then
  SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
  CLAUDE_PLUGIN_ROOT="$(dirname "$SCRIPT_DIR")"
fi

SOURCE_DIR="${CLAUDE_PLUGIN_ROOT}/templates/integration"
TARGET_DIR="${PROJECT_ROOT}/.agent/templates/integration"

if [ ! -d "$SOURCE_DIR" ]; then
  echo "ERROR: Source templates not found at ${SOURCE_DIR}" >&2
  exit 1
fi

# Create target directories
mkdir -p "${TARGET_DIR}/platform-parsers"

copied=0
skipped=0

# Copy each template file (no-clobber)
while IFS= read -r -d '' src_file; do
  rel_path="${src_file#"${SOURCE_DIR}/"}"
  dest_file="${TARGET_DIR}/${rel_path}"

  # Ensure parent directory exists
  mkdir -p "$(dirname "$dest_file")"

  if [ -f "$dest_file" ]; then
    skipped=$((skipped + 1))
  else
    cp "$src_file" "$dest_file"
    echo "  copied: .agent/templates/integration/${rel_path}"
    copied=$((copied + 1))
  fi
done < <(find "$SOURCE_DIR" -type f -print0)

echo ""
echo "Integration suite templates: ${copied} copied, ${skipped} skipped (already exist)"
