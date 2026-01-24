# OpenTelemetry Telemetry Collector

This directory contains the OpenTelemetry collector setup for capturing Claude Code telemetry following Anthropic best practices.

## Quick Start

### 1. Start the Collector

```bash
cd .agent/telemetry/otel
docker compose up -d
```

### 2. Enable Claude Code Telemetry

Add to your shell config (`~/.bashrc` or `~/.zshrc`):

```bash
export CLAUDE_CODE_ENABLE_TELEMETRY=1
export OTEL_EXPORTER_OTLP_ENDPOINT="http://localhost:4317"
export OTEL_SERVICE_NAME="claude-code-agentic"
```

Or use the project's `.envrc` with direnv.

### 3. Verify Data Collection

```bash
# Watch telemetry data arrive
tail -f data/telemetry.jsonl

# Query today's metrics
./query-telemetry.sh --today
```

## Architecture

```
Claude Code ──OTLP──> OTel Collector ──> telemetry.jsonl
                           │
                           └──> Prometheus endpoint (:8889)
```

## Metrics Captured

Claude Code's built-in OpenTelemetry exports these metrics:

| Metric | Description |
|--------|-------------|
| `claude_code.session.count` | Session count |
| `claude_code.token.usage` | Token consumption (input + output) |
| `claude_code.lines_of_code.count` | Lines modified |
| `claude_code.cost.usage` | Cost in USD |
| `claude_code.tool.count` | Tool invocations |

## Commands

### Start Collector
```bash
docker compose up -d
```

### Stop Collector
```bash
docker compose down
```

### View Logs
```bash
docker compose logs -f otel-collector
```

### Query Telemetry
```bash
./query-telemetry.sh --today    # Today's metrics
./query-telemetry.sh --week     # Last 7 days
./query-telemetry.sh --month    # Last 30 days
```

## Data Retention

The collector automatically manages data retention:

| Data | Retention |
|------|-----------|
| telemetry.jsonl | 90 days |
| Rotated backups | 12 files max |
| Max file size | 100 MB |

Old data is automatically deleted when limits are exceeded.

## Configuration

### otel-config.yaml

Key settings:

- **Receivers**: OTLP on ports 4317 (gRPC) and 4318 (HTTP)
- **Processors**: Batch (10s timeout), attributes (project name)
- **Exporters**: File (JSONL) and debug output

### Customization

To add Prometheus/Grafana visualization:

1. Uncomment Prometheus in exporters (already configured on port 8889)
2. Add Grafana container to docker-compose.yml
3. Create dashboards using the Prometheus endpoint

## Troubleshooting

### No data appearing

1. Verify collector is running: `docker compose ps`
2. Check Claude Code telemetry is enabled: `echo $CLAUDE_CODE_ENABLE_TELEMETRY`
3. Verify endpoint is set: `echo $OTEL_EXPORTER_OTLP_ENDPOINT`
4. Check collector logs: `docker compose logs otel-collector`

### Connection refused

Ensure the collector is started before running Claude Code:
```bash
docker compose up -d
# Wait a few seconds
docker compose ps  # Should show "running"
```

### Data directory permissions

If data isn't being written, check Docker volume permissions:
```bash
ls -la data/
# Should be writable by Docker
```

## Multi-Project Setup

This collector can receive telemetry from multiple projects. Each project should set a unique `OTEL_SERVICE_NAME`:

```bash
# Project 1
export OTEL_SERVICE_NAME="claude-code-project-a"

# Project 2
export OTEL_SERVICE_NAME="claude-code-project-b"
```

The service name appears in telemetry data for filtering.

---

**Version**: 1.0.0
**Created**: 2026-01-24
**Approach**: Anthropic-aligned OpenTelemetry
