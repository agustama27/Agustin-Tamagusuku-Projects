FROM python:3.8.13 AS base

# Set an initial value for PYTHONPATH and append /src/
ENV PYTHONPATH=${PYTHONPATH}:/src/

# Install dependencies
ADD requirements.txt .
RUN pip3 install -r requirements.txt

# Copy application code
COPY ./ /src/

# Set the working directory
WORKDIR /src

# Test stage
FROM base AS test
RUN ["pytest", "-v", "/src/tests"]

# Build stage
FROM base AS build
ENTRYPOINT ["python3", "/src/ml_service.py"]
