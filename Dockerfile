FROM node:18-alpine

# Lightweight static file server using http-server
WORKDIR /app

# Install a small static server globally
RUN npm install -g http-server@14

# Copy site sources
COPY src/ /app

# Expose default HTTP port
EXPOSE 80

# Simple healthcheck using curl (optional at runtime/platform)
HEALTHCHECK --interval=30s --timeout=3s --start-period=20s --retries=3 \
    CMD curl -f http://localhost:80/index.html || exit 1

# Serve static files from /app on port 80
CMD ["http-server", "-p", "80", "-a", "0.0.0.0"]
