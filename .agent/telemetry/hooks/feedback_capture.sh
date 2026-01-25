#!/bin/bash
# Feedback Capture Hook for Agent Invocations
# Records user feedback to local telemetry file
#
# Usage: ./feedback_capture.sh <agent_id> <rating> [comment]
# Rating: 1-5 (1=poor, 5=excellent)
#
# Called manually after agent invocation or via /feedback command

TELEMETRY_DIR="$(dirname "$0")/.."
DATA_FILE="${TELEMETRY_DIR}/data/feedback.jsonl"
SESSION_ID=$(cat "${TELEMETRY_DIR}/.session" 2>/dev/null | cut -d'|' -f1 || echo "session-$$")

AGENT_ID="${1:-unknown}"
RATING="${2:-0}"
COMMENT="${3:-}"
TIMESTAMP=$(date -Iseconds)

# Validate rating
if [[ ! "$RATING" =~ ^[1-5]$ ]]; then
    echo "Error: Rating must be 1-5"
    exit 1
fi

# Ensure data directory exists
mkdir -p "$(dirname "$DATA_FILE")"

# Append feedback entry
cat >> "$DATA_FILE" << EOF
{"timestamp":"${TIMESTAMP}","session_id":"${SESSION_ID}","agent_id":"${AGENT_ID}","rating":${RATING},"comment":"${COMMENT}","type":"feedback"}
EOF

echo "Feedback recorded: ${AGENT_ID} = ${RATING}/5"
exit 0
