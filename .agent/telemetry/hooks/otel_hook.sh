#!/bin/bash
# OTEL Telemetry Hook for Claude Code
# Sends tool usage data to OpenTelemetry Collector
#
# Argument: Tool name passed as $1 from hook config
# Output: Sends OTLP trace to collector

# Use HTTP endpoint (4318), not gRPC (4317)
OTEL_ENDPOINT="http://localhost:4318"
SERVICE_NAME="${OTEL_SERVICE_NAME:-claude-code}"

# Get tool info from argument or environment
TOOL_NAME="${1:-${CLAUDE_TOOL_NAME:-unknown}}"
SESSION_ID=$(cat "$(dirname "$0")/../.session" 2>/dev/null | cut -d'|' -f1 || echo "session-$$")

# Generate IDs
TRACE_ID=$(printf '%032x' $((RANDOM * RANDOM * RANDOM * RANDOM)))
SPAN_ID=$(printf '%016x' $((RANDOM * RANDOM)))
START_TIME=$(($(date +%s) * 1000000000))
END_TIME=$((START_TIME + 1000000))  # 1ms duration placeholder

# Build OTLP JSON payload
read -r -d '' PAYLOAD << EOF || true
{
  "resourceSpans": [{
    "resource": {
      "attributes": [
        {"key": "service.name", "value": {"stringValue": "${SERVICE_NAME}"}},
        {"key": "session.id", "value": {"stringValue": "${SESSION_ID}"}}
      ]
    },
    "scopeSpans": [{
      "scope": {"name": "claude-code-hooks"},
      "spans": [{
        "traceId": "${TRACE_ID}",
        "spanId": "${SPAN_ID}",
        "name": "tool.${TOOL_NAME}",
        "kind": 1,
        "startTimeUnixNano": "${START_TIME}",
        "endTimeUnixNano": "${END_TIME}",
        "attributes": [
          {"key": "tool.name", "value": {"stringValue": "${TOOL_NAME}"}},
          {"key": "project.name", "value": {"stringValue": "agentic-hub"}},
          {"key": "hook.type", "value": {"stringValue": "PostToolUse"}}
        ],
        "status": {"code": 1}
      }]
    }]
  }]
}
EOF

# Send to OTEL collector (async, don't block)
curl -s -X POST "${OTEL_ENDPOINT}/v1/traces" \
  -H "Content-Type: application/json" \
  -d "${PAYLOAD}" \
  --max-time 1 \
  >/dev/null 2>&1 &

exit 0
