# Use a minimal Python base image
FROM python:3.12-slim-bookworm

# Set the working directory inside the container
WORKDIR /app

# Install system dependencies including Node.js and npm (for Prettier)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl ca-certificates nodejs npm \
    && rm -rf /var/lib/apt/lists/*

# Install Prettier globally (so we don’t need npx)
RUN npm install --global prettier@3.4.2

# Copy only the frequently changing application files (main.py and funtion_tasks.py) first
COPY main.py /app/main.py
COPY funtion_tasks.py /app/funtion_tasks.py

# Copy the requirements.txt for better caching of dependencies
COPY requirements.txt /app/requirements.txt

# Create a virtual environment
RUN python -m venv /venv
ENV PATH="/venv/bin:$PATH"

# Install Python dependencies
# RUN pip install --no-cache-dir -r requirements.txt
RUN pip install -r requirements.txt


# Copy everything else (like static files, templates, etc.)
COPY . /app

# Expose FastAPI port
EXPOSE 8000

# Run FastAPI with Uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
