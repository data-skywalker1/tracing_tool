#!/bin/bash

# Create logs directory if it doesn't exist
mkdir -p logs

# Copy OpenTelemetry collector config to /tmp (if needed for standalone mode)
cp tmp/otel-collector-config.yaml /tmp/otel-collector-config.yaml

# Start Flask app with OpenTelemetry instrumentation
# Note: Make sure to run 'make dev-up' first to start the Elastic APM stack
opentelemetry-instrument \
  --logs_exporter console,otlp \
  --traces_exporter console,otlp \
  --metrics_exporter console,otlp \
  flask --app app2 run -p 8080 > logs/flask_app.log 2>&1 &

echo "Flask app started with OpenTelemetry instrumentation"
echo "Check logs at: logs/flask_app.log"
echo "Access app at: http://localhost:8080/rolldice"