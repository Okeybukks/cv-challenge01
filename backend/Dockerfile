# Use an official Python runtime as a base image
FROM python:3.11-slim

# Install system dependencies required by Poetry
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl build-essential libssl-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python3 - && \
    ln -s /root/.local/bin/poetry /usr/local/bin/poetry

# Set the working directory
WORKDIR /app

# Copy dependency files first
COPY pyproject.toml poetry.lock ./

# Install dependencies
RUN poetry config virtualenvs.create false && poetry install --no-interaction --no-ansi

# Copy the application code and prestart script
COPY . .

# Set PYTHONPATH for the app directory
ENV PYTHONPATH=/app

# Expose the app port
EXPOSE 8000

ENTRYPOINT ["bash", "/app/entrypoint.sh"]
