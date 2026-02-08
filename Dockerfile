# ============== Stage 1: Builder ==============
FROM python:3.11-alpine AS builder

WORKDIR /build

# Upgrade pip and install dependencies
COPY ./webapp/requirements.txt .
RUN pip3 install --no-cache-dir --upgrade pip==26.0 && \
    pip3 install --no-cache-dir --prefix=/install -r requirements.txt && \
    pip3 install --no-cache-dir --prefix=/install --upgrade --force-reinstall \
    wheel==0.46.2 \
    "jaraco.context==6.1.0"


# ============== Stage 2: Production ==============
FROM python:3.11-alpine AS production

LABEL maintainer="lagazakevin@gmail.com" \
      description="Flask Web Application"

# Copy installed packages from builder
COPY --from=builder /install /usr/local

# Add our code
COPY ./webapp /opt/webapp/
WORKDIR /opt/webapp

# Create non-root user
RUN adduser -D myuser && \
    chown -R myuser:myuser /opt/webapp
USER myuser

ENV PORT=""

# Run the app
CMD ["sh", "-c", "gunicorn --bind 0.0.0.0:$PORT wsgi"]