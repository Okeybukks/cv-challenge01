#!/usr/bin/env bash

set -e  # Exit on any error

# Run prestart script
if [ -f prestart.sh ]; then
    bash prestart.sh
else
    echo "No prestart script found. Skipping..."
fi

# Start the FastAPI application
exec poetry run uvicorn app.main:app --host 0.0.0.0 --port 8000
