#!/bin/bash
# Agent Telemetry Capture Script v3 (Lightweight)
#
# Purpose: Track agent ID attribution only
# Actual metrics (tokens, costs, lines) are captured by Claude Code's native OTel
#
# This hook is intentionally minimal per Anthropic best practices:
# - Hooks should be fast and deterministic
# - Heavy processing belongs in OTel backends, not hooks
#
# Usage: Called by PostToolUse hook after Edit|Write|NotebookEdit
# Output: Session activity log with agent attribution

set -e

# Configuration
TELEMETRY_DIR="${PROJECT_ROOT:-.}/.agent/telemetry"
ACTIVITY_LOG="${TELEMETRY_DIR}/session-activity.log"
AGENT_MARKER="${TELEMETRY_DIR}/.current-agent"
SESSION_FILE="${TELEMETRY_DIR}/.session"
MAX_LOG_LINES=5000
SESSION_TIMEOUT=300  # 5 minutes

# Ensure directory exists
mkdir -p "${TELEMETRY_DIR}"

# Timestamps
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
CURRENT_TIME=$(date +%s)

# ============================================
# AGENT ID TRACKING
# ============================================
# Agents write their ID to .current-agent marker file
# Format: agent-id|version
AGENT_ID="unknown"
AGENT_VERSION="unknown"

if [ -f "${AGENT_MARKER}" ]; then
    MARKER_CONTENT=$(cat "${AGENT_MARKER}" 2>/dev/null || echo "")
    if [ -n "${MARKER_CONTENT}" ]; then
        AGENT_ID=$(echo "${MARKER_CONTENT}" | cut -d'|' -f1)
        AGENT_VERSION=$(echo "${MARKER_CONTENT}" | cut -d'|' -f2)
    fi
fi

# ============================================
# SESSION TRACKING (lightweight)
# ============================================
# Session format: SESSION_ID|START_TIME|TOOL_COUNT

NEW_SESSION=false
if [ -f "${SESSION_FILE}" ]; then
    SESSION_DATA=$(cat "${SESSION_FILE}" 2>/dev/null || echo "")
    if [ -n "${SESSION_DATA}" ]; then
        SESSION_START=$(echo "${SESSION_DATA}" | cut -d'|' -f2)
        TOOL_COUNT=$(echo "${SESSION_DATA}" | cut -d'|' -f3)

        # Check if session expired
        if [ $((CURRENT_TIME - SESSION_START)) -gt ${SESSION_TIMEOUT} ]; then
            NEW_SESSION=true
            # Clear agent marker on session end
            rm -f "${AGENT_MARKER}" 2>/dev/null || true
        fi
    else
        NEW_SESSION=true
    fi
else
    NEW_SESSION=true
fi

# Create new session if needed
if [ "$NEW_SESSION" = true ]; then
    SESSION_ID=$(uuidgen 2>/dev/null || cat /proc/sys/kernel/random/uuid 2>/dev/null || echo "session-${CURRENT_TIME}")
    SESSION_START=${CURRENT_TIME}
    TOOL_COUNT=0
else
    SESSION_ID=$(echo "${SESSION_DATA}" | cut -d'|' -f1)
fi

# Increment tool count
TOOL_COUNT=$((TOOL_COUNT + 1))
echo "${SESSION_ID}|${SESSION_START}|${TOOL_COUNT}" > "${SESSION_FILE}"

# ============================================
# LOG ACTIVITY (minimal - for agent attribution only)
# ============================================
# Format: timestamp|session_id|agent_id|tool_seq
echo "${TIMESTAMP}|${SESSION_ID}|${AGENT_ID}|${TOOL_COUNT}" >> "${ACTIVITY_LOG}"

# ============================================
# LOG ROTATION (occasional cleanup)
# ============================================
if [ $((RANDOM % 100)) -eq 0 ]; then
    if [ -f "${ACTIVITY_LOG}" ]; then
        LINE_COUNT=$(wc -l < "${ACTIVITY_LOG}" 2>/dev/null || echo "0")
        if [ "${LINE_COUNT}" -gt "${MAX_LOG_LINES}" ]; then
            tail -n $((MAX_LOG_LINES / 2)) "${ACTIVITY_LOG}" > "${ACTIVITY_LOG}.tmp" && \
            mv "${ACTIVITY_LOG}.tmp" "${ACTIVITY_LOG}"
        fi
    fi
fi

exit 0
