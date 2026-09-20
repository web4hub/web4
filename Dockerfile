COPY requirements.txt .
# --- Stage 1: Builder ---
# This stage installs dependencies and prepares the virtual environment
FROM python:3.12-slim AS builder

# Set environment variables to prevent Python from writing .pyc files to disk
# and to prevent buffering stdout and stderr
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Create a virtual environment to isolate dependencies
RUN python -m venv /opt/venv

# Enable the venv for subsequent commands
ENV PATH="/opt/venv/bin:$PATH"

# Copy requirements file first to leverage Docker layer caching
COPY requirements.txt .

# Install dependencies
# --no-cache-dir reduces image size
# --upgrade ensures pip is up to date
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt


# --- Stage 2: Runner ---
# This stage creates the final, lean production image
FROM python:3.12-slim AS runner

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    # Set the port Flask will listen on
    FLASK_RUN_PORT=5000

WORKDIR /app

# Create a non-root user and group for security
# This avoids running the application as root
RUN groupadd -r appuser && useradd -r -g appuser appuser

# Copy the virtual environment from the builder stage
COPY --from=builder /opt/venv /opt/venv

COPY requirements.txt .
# Add the virtual environment to the PATH
ENV PATH="/opt/venv/bin:$PATH"

# Copy the application source code
# chown ensures the non-root user owns the files
COPY --chown=appuser:appuser . .

# Switch to the non-root user
USER appuser

# Expose the port the app runs on
EXPOSE 8080

# Define the entry point
# We use the list format ["cmd", "arg"] for better signal handling
CMD ["python", "app.py"]
