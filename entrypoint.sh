#!/bin/sh
set -e

# Start the server in the background so the CLI can talk to it
ollama serve &
SERVER_PID=$!

# Wait a short while for the server to be ready to accept CLI commands
sleep 5

# Pull and create the model (idempotent). If the model already exists this should be quick.
ollama pull nomic-embed-text || true
echo "FROM nomic-embed-text\nPARAMETER num_thread 16" > /root/Modelfile
ollama create custom-nomic -f /root/Modelfile || true

# Stop the background server and start a fresh foreground server process
kill ${SERVER_PID} 2>/dev/null || true

# Exec the final command (so CMD can be overridden)
exec "$@"
