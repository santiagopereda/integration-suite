#!/bin/bash
# Memory Hook for Agent Invocations
# Records agent invocation context to memory system
#
# Argument: Hook type (pre|post) and agent name
# Output: Updates memory files
#
# Usage: ./memory_hook.sh <pre|post> <agent-id>

MEMORY_DIR="$(dirname "$0")/../"
SESSION_FILE="${MEMORY_DIR}/session-summaries/current-session.md"
AGENT_MEMORY_DIR="${MEMORY_DIR}/agents"
HOOK_TYPE="${1:-post}"
AGENT_ID="${2:-unknown}"
TIMESTAMP=$(date -Iseconds)
SESSION_ID=$(cat "$(dirname "$0")/../../telemetry/.session" 2>/dev/null | cut -d'|' -f1 || echo "session-$$")

# Ensure directories exist
mkdir -p "${MEMORY_DIR}/session-summaries"
mkdir -p "${AGENT_MEMORY_DIR}"

# Session tracking
case "$HOOK_TYPE" in
  pre)
    # Log agent invocation start
    echo "| ${TIMESTAMP} | ${AGENT_ID} | Started | - |" >> "${SESSION_FILE}"
    ;;
  post)
    # Log agent invocation completion
    # Note: Exit status passed as $3 if available
    STATUS="${3:-completed}"
    echo "| ${TIMESTAMP} | ${AGENT_ID} | ${STATUS} | - |" >> "${SESSION_FILE}"

    # Update agent-specific memory
    AGENT_FILE="${AGENT_MEMORY_DIR}/${AGENT_ID}-memory.md"
    if [ ! -f "$AGENT_FILE" ]; then
      # Create agent memory file
      cat > "$AGENT_FILE" << EOF
# Agent Memory: ${AGENT_ID}

## Invocation History

| Timestamp | Session | Outcome |
|-----------|---------|---------|
| ${TIMESTAMP} | ${SESSION_ID} | ${STATUS} |

## Learnings

(No learnings recorded yet)

## Context for Next Session

(No context saved yet)
EOF
    else
      # Append to existing history (simple append to table)
      # This is a basic implementation - could be enhanced with sed/awk
      echo "| ${TIMESTAMP} | ${SESSION_ID} | ${STATUS} |" >> "${AGENT_FILE}.tmp"
    fi
    ;;
esac

exit 0
