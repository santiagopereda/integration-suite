# OpenTelemetry Telemetry Collector

This directory contains the OpenTelemetry collector setup for capturing Claude Code telemetry following Anthropic best practices.

## What This Does

The Docker Compose setup runs an **OpenTelemetry Collector** - a vendor-agnostic telemetry pipeline that:

1. **Receives** metrics from Claude Code via OTLP (OpenTelemetry Protocol)
2. **Processes** data in batches with project identification
3. **Exports** to a JSONL file for analysis (with automatic rotation)

### Why OpenTelemetry?

- **Anthropic-recommended** - Claude Code has built-in OTel support
- **Industry standard** - Same tooling used by major observability platforms
- **Zero custom code** - No bash scripts for aggregation, the collector handles everything
- **Automatic retention** - File rotation, size limits, and cleanup built-in

### Data Flow

```
┌─────────────────────────────────────────────────────────────────────────┐
│  Claude Code (your IDE)                                                 │
│  CLAUDE_CODE_ENABLE_TELEMETRY=1                                         │
│  Built-in OpenTelemetry instrumentation                                 │
└─────────────────────────────────────────────────────────────────────────┘
                              │
                              │ OTLP gRPC (port 4317)
                              │ or OTLP HTTP (port 4318)
                              ▼
┌─────────────────────────────────────────────────────────────────────────┐
│  OTel Collector (Docker container: claude-telemetry-collector)          │
│                                                                         │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────────────────────┐ │
│  │  Receivers  │ -> │ Processors  │ -> │        Exporters            │ │
│  │  - OTLP     │    │ - Batch     │    │ - File (telemetry.jsonl)    │ │
│  │    :4317    │    │ - Attributes│    │ - Debug (console logs)      │ │
│  │    :4318    │    │   (project) │    │ - Prometheus (:8889)        │ │
│  └─────────────┘    └─────────────┘    └─────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────────────┐
│  data/telemetry.jsonl                                                   │
│  - Token usage, costs, session counts, lines modified                   │
│  - Auto-rotated: 100MB max, 90 days retention, 12 backups              │
└─────────────────────────────────────────────────────────────────────────┘
```

---

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

## Command Reference

### Docker Compose Commands

| Command | Description |
|---------|-------------|
| `docker compose up -d` | Start collector in background (detached mode) |
| `docker compose down` | Stop and remove collector container |
| `docker compose ps` | Show collector status (running/stopped) |
| `docker compose logs -f` | Follow collector logs in real-time |
| `docker compose restart` | Restart collector (useful after config changes) |
| `docker compose pull` | Update to latest collector image |

### Detailed Command Explanations

#### Start the Collector
```bash
docker compose up -d
```
- `-d` runs in detached mode (background)
- Container name: `claude-telemetry-collector`
- Automatically restarts on failure (`restart: unless-stopped`)
- First run will download the ~65MB collector image

#### Stop the Collector
```bash
docker compose down
```
- Stops the container gracefully
- Removes the container (data in `./data/` is preserved)
- Does NOT delete the telemetry data files

#### Check Status
```bash
docker compose ps
```
Expected output when running:
```
NAME                        STATUS          PORTS
claude-telemetry-collector  Up 2 hours      0.0.0.0:4317-4318->4317-4318/tcp, 0.0.0.0:8889->8889/tcp
```

#### View Logs
```bash
docker compose logs -f otel-collector
```
- `-f` follows logs in real-time (Ctrl+C to exit)
- Shows incoming metrics, errors, and debug info
- Useful for troubleshooting connection issues

#### Restart After Config Changes
```bash
docker compose restart
```
- Use after modifying `otel-config.yaml`
- Preserves data, just restarts the process

### Query Commands

| Command | Description |
|---------|-------------|
| `./query-telemetry.sh --today` | Show today's metrics summary |
| `./query-telemetry.sh --week` | Show last 7 days metrics |
| `./query-telemetry.sh --month` | Show last 30 days metrics |
| `./query-telemetry.sh --all` | Show overall data file summary |
| `./query-telemetry.sh --help` | Show available options |

### Data Inspection Commands

```bash
# Watch telemetry arrive in real-time
tail -f data/telemetry.jsonl

# Count total records
wc -l data/telemetry.jsonl

# View last 5 records (formatted)
tail -5 data/telemetry.jsonl | jq .

# Search for specific metric
grep "claude_code.token.usage" data/telemetry.jsonl | jq .

# Check data file size
du -h data/telemetry.jsonl
```

### Prometheus Endpoint

The collector exposes a Prometheus metrics endpoint:

```bash
# View raw Prometheus metrics
curl http://localhost:8889/metrics

# Check if endpoint is responding
curl -s http://localhost:8889/metrics | head -20
```

This endpoint can be scraped by:
- Prometheus server
- Grafana Cloud
- Any Prometheus-compatible monitoring tool

## Data Retention

The collector automatically manages data retention:

| Data | Retention |
|------|-----------|
| telemetry.jsonl | 90 days |
| Rotated backups | 12 files max |
| Max file size | 100 MB |

Old data is automatically deleted when limits are exceeded.

## Configuration

### docker-compose.yml Explained

```yaml
services:
  otel-collector:
    image: otel/opentelemetry-collector-contrib:0.96.0  # Stable version with all exporters
    container_name: claude-telemetry-collector           # Fixed name for easy reference
    restart: unless-stopped                              # Auto-restart on failure
    ports:
      - "4317:4317"   # OTLP gRPC - Claude Code sends here
      - "4318:4318"   # OTLP HTTP - Alternative protocol
      - "8889:8889"   # Prometheus metrics endpoint
    volumes:
      - ./otel-config.yaml:/etc/otelcol-contrib/config.yaml  # Config file
      - ./data:/data                                          # Telemetry output
```

### otel-config.yaml Explained

The collector configuration has three main sections:

#### Receivers (How data comes in)
```yaml
receivers:
  otlp:
    protocols:
      grpc:
        endpoint: 0.0.0.0:4317  # Claude Code connects here
      http:
        endpoint: 0.0.0.0:4318  # Alternative HTTP endpoint
```

#### Processors (How data is transformed)
```yaml
processors:
  batch:
    timeout: 10s              # Batch data for 10 seconds before export
    send_batch_size: 1000     # Or when 1000 records accumulate

  attributes:
    actions:
      - key: project.name     # Add project identifier to all data
        value: "agentic-hub"
        action: upsert
```

#### Exporters (Where data goes)
```yaml
exporters:
  file:
    path: /data/telemetry.jsonl  # Output file (inside container)
    rotation:
      max_megabytes: 100         # Rotate at 100MB
      max_days: 90               # Keep for 90 days
      max_backups: 12            # Keep 12 rotated files

  debug:
    verbosity: basic             # Console logging (useful for troubleshooting)
```

### Customization

#### Change Project Name
Edit `otel-config.yaml`:
```yaml
attributes:
  actions:
    - key: project.name
      value: "your-project-name"  # Change this
```

#### Disable Debug Logging
Remove `debug` from the exporters in the service pipeline:
```yaml
service:
  pipelines:
    metrics:
      exporters: [file]  # Remove 'debug'
```

#### Add Grafana Visualization
Add to `docker-compose.yml`:
```yaml
services:
  grafana:
    image: grafana/grafana:latest
    ports:
      - "3000:3000"
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin
```
Then add Prometheus data source pointing to `http://otel-collector:8889`

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

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `CLAUDE_CODE_ENABLE_TELEMETRY` | Enable Claude Code telemetry | `0` (disabled) |
| `OTEL_EXPORTER_OTLP_ENDPOINT` | Collector endpoint URL | None |
| `OTEL_SERVICE_NAME` | Service name in telemetry | `claude-code` |

These are set in the project's `.envrc` file for automatic loading with direnv.

---

## File Structure

```
otel/
├── docker-compose.yml    # Container definition
├── otel-config.yaml      # Collector configuration
├── query-telemetry.sh    # Query utility script
├── README.md             # This documentation
└── data/
    ├── .gitkeep          # Ensures directory exists in git
    └── telemetry.jsonl   # Collected metrics (auto-generated)
```

---

**Version**: 1.1.0
**Created**: 2026-01-24
**Updated**: 2026-01-25
**Approach**: Anthropic-aligned OpenTelemetry
