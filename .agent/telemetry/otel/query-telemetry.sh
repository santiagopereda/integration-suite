#!/bin/bash
# Query telemetry data from OTel file exporter
# Usage: ./query-telemetry.sh [--today|--week|--month|--all]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DATA_FILE="${SCRIPT_DIR}/data/telemetry.jsonl"

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "Error: jq is required but not installed."
    echo "Install with: sudo apt-get install jq (Ubuntu) or brew install jq (macOS)"
    exit 1
fi

# Check if data file exists
if [ ! -f "$DATA_FILE" ]; then
    echo "No telemetry data found at: $DATA_FILE"
    echo "Ensure the OTel collector is running and Claude Code telemetry is enabled."
    exit 1
fi

# Date calculations
TODAY=$(date +%Y-%m-%d)
WEEK_AGO=$(date -d "7 days ago" +%Y-%m-%d 2>/dev/null || date -v-7d +%Y-%m-%d)
MONTH_AGO=$(date -d "30 days ago" +%Y-%m-%d 2>/dev/null || date -v-30d +%Y-%m-%d)

query_period() {
    local start_date="$1"
    local end_date="$2"
    local label="$3"

    echo "=== $label ==="
    echo "Period: $start_date to $end_date"
    echo ""

    # Count lines in period (basic metrics)
    local line_count=$(grep -E "\"$start_date|$end_date" "$DATA_FILE" 2>/dev/null | wc -l || echo "0")

    if [ "$line_count" -eq 0 ]; then
        echo "No data found for this period."
        return
    fi

    # Parse and aggregate metrics
    grep -E "$start_date" "$DATA_FILE" 2>/dev/null | jq -s '
    {
        "records": length,
        "metrics_summary": (
            [.[].resourceMetrics[]?.scopeMetrics[]?.metrics[]? |
             select(.name != null)] |
            group_by(.name) |
            map({
                name: .[0].name,
                count: length
            })
        ),
        "services": (
            [.[].resourceMetrics[]?.resource?.attributes[]? |
             select(.key == "service.name") |
             .value.stringValue] |
            unique
        )
    }' 2>/dev/null || echo "Unable to parse telemetry data"
}

show_summary() {
    echo "=== Telemetry Summary ==="
    echo ""
    echo "Data file: $DATA_FILE"
    echo "File size: $(du -h "$DATA_FILE" | cut -f1)"
    echo "Total records: $(wc -l < "$DATA_FILE")"
    echo ""

    # Show date range
    local first_date=$(head -1 "$DATA_FILE" | jq -r '.resourceMetrics[0].resource.attributes[] | select(.key == "telemetry.sdk.version") | .value.stringValue' 2>/dev/null || echo "unknown")
    local last_date=$(tail -1 "$DATA_FILE" | jq -r '.resourceMetrics[0].resource.attributes[] | select(.key == "telemetry.sdk.version") | .value.stringValue' 2>/dev/null || echo "unknown")

    echo "First record: $(head -1 "$DATA_FILE" | jq -r '.resourceMetrics[0].scopeMetrics[0].metrics[0].name // "N/A"' 2>/dev/null)"
    echo "Last record: $(tail -1 "$DATA_FILE" | jq -r '.resourceMetrics[0].scopeMetrics[0].metrics[0].name // "N/A"' 2>/dev/null)"
}

case "${1:---today}" in
    --today|-t)
        query_period "$TODAY" "$TODAY" "Today's Telemetry"
        ;;
    --week|-w)
        query_period "$WEEK_AGO" "$TODAY" "Last 7 Days Telemetry"
        ;;
    --month|-m)
        query_period "$MONTH_AGO" "$TODAY" "Last 30 Days Telemetry"
        ;;
    --all|-a)
        show_summary
        ;;
    --help|-h)
        echo "Usage: $0 [option]"
        echo ""
        echo "Options:"
        echo "  --today, -t    Show today's telemetry (default)"
        echo "  --week, -w     Show last 7 days telemetry"
        echo "  --month, -m    Show last 30 days telemetry"
        echo "  --all, -a      Show overall summary"
        echo "  --help, -h     Show this help"
        ;;
    *)
        echo "Unknown option: $1"
        echo "Use --help for usage information."
        exit 1
        ;;
esac
