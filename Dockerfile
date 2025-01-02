# Use Caddy base image
FROM caddy:alpine

# Copy the static HTML file to the default directory for Caddy
COPY src/index.html /usr/share/caddy/

# Expose port 80
EXPOSE 80