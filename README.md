# OpenTelemetry Tracing Tool with Elastic APM

A Flask application instrumented with OpenTelemetry that exports traces, metrics, and logs to Elasticsearch APM.

## Architecture

- **Flask App** (app2.py) - Dice rolling API with custom traces and metrics
- **OpenTelemetry Collector** - Receives telemetry data via OTLP
- **Elasticsearch** - Stores telemetry data
- **Kibana** - Visualizes traces, metrics, and logs
- **APM Server** - Elastic APM server for processing telemetry

## Quick Start

### 1. Start the Observability Stack
```bash
make dev-up
```

This starts:
- Elasticsearch (http://localhost:9200)
- Kibana (http://localhost:5601)
- APM Server (http://localhost:8200)
- OpenTelemetry Collector (ports 4317/4318)

### 2. Start the Flask Application
```bash
make setup
```

### 3. Test the Application
```bash
curl http://localhost:8080/rolldice
curl http://localhost:8080/rolldice?player=John
```

### 4. View Telemetry in Kibana
```bash
make kibana
```

Or open manually: http://localhost:5601

Navigate to **Observability → APM** to see traces, metrics, and logs.

## Available Make Commands

| Command | Description |
|---------|-------------|
| `make dev-up` | Start the Elastic APM stack |
| `make dev-down` | Stop the Elastic APM stack |
| `make dev-logs` | Follow logs from all services |
| `make dev-status` | Check status of containers |
| `make setup` | Start Flask app with instrumentation |
| `make kibana` | Open Kibana in browser |
| `make clean` | Stop containers, remove volumes and logs |

## Manual Commands

### Start Elastic APM Stack
```bash
docker-compose up -d
```

### Start Flask App (app2.py)
```bash
export OTEL_PYTHON_LOGGING_AUTO_INSTRUMENTATION_ENABLED=true
opentelemetry-instrument \
  --logs_exporter console,otlp \
  --traces_exporter console,otlp \
  --metrics_exporter console,otlp \
  flask --app app2 run -p 8080
```

### Start Flask App (app.py - alternative)
```bash
export OTEL_PYTHON_LOGGING_AUTO_INSTRUMENTATION_ENABLED=true
opentelemetry-instrument \
  --traces_exporter console,otlp \
  --metrics_exporter console,otlp \
  --logs_exporter console,otlp \
  --service_name dice-server \
  flask run -p 8080
```

## Configuration Files

- **docker-compose.yml** - Defines all services (Elasticsearch, Kibana, APM, OTel Collector)
- **tmp/otel-collector-config.yaml** - OpenTelemetry Collector configuration
- **setup.sh** - Script to start Flask app with instrumentation
- **Makefile** - Convenient commands for development

## Viewing Telemetry

### In Kibana (http://localhost:5601)
1. Go to **Observability → APM**
2. View **Services** - See your Flask application
3. View **Traces** - See individual requests with spans
4. View **Metrics** - See HTTP request duration, dice roll counts

### In Logs
- Flask app logs: `logs/flask_app.log`
- Docker compose logs: `docker-compose logs -f`

## Troubleshooting

### Services not starting
```bash
# Check container status
make dev-status

# View logs
make dev-logs
```

### Flask app not sending data
1. Ensure the stack is running: `make dev-up`
2. Wait 30 seconds for services to be healthy
3. Check OTel Collector is accessible: `curl http://localhost:4318`

### Clean restart
```bash
make clean
make dev-up
# Wait 30 seconds
make setup
```
