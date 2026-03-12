# Multi-stage Dockerfile for Julia application with AIHelpMe

# Build stage
FROM julia:1.9-bullseye as builder

WORKDIR /build

# Copy project files
COPY Project.toml Manifest.toml ./
COPY src ./src
COPY docs ./docs

# Precompile dependencies
RUN julia --project -e "using Pkg; Pkg.instantiate(); Pkg.precompile()"

# Runtime stage
FROM julia:1.9-bullseye as production

WORKDIR /app

# Install runtime dependencies
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Copy application
COPY --from=builder /build/Project.toml ./
COPY --from=builder /build/Manifest.toml ./
COPY --from=builder /build/src ./src
COPY --from=builder /build/docs ./docs
COPY --from=builder /build/config ./config
COPY --from=builder /build/pages ./pages
COPY --from=builder /build/public ./public

# Copy server script
COPY server.jl ./

# Set environment
ENV JULIA_DEPOT_PATH=/root/.julia
ENV APP_ENV=docker

# Create cache directory
RUN mkdir -p /app/logs /root/.julia

# Expose port
EXPOSE 8000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
  CMD curl -f http://localhost:8000/api/ai-help/config || exit 1

# Start server
CMD ["julia", "--project", "server.jl"]
