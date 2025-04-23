# Stage 1: Build the React application
FROM node:22.13.1-slim AS builder

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY --link package.json package-lock.json ./
RUN --mount=type=cache,target=/root/.npm npm ci

# Copy the application source code
COPY --link . .

# Build the application
RUN npm run build

# Stage 2: Serve the application with a simple static server
FROM nginx:alpine AS final

# Copy the built React app to Nginx's html directory
COPY --from=builder /app/build /usr/share/nginx/html

# Copy a default Nginx config (optional)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose the port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
