# Stage 1: Build the React application
FROM node:22.13.1-slim AS builder

# Set working directory
WORKDIR /app

# Copy only the app directory into the build stage
COPY app/package*.json ./
RUN --mount=type=cache,target=/root/.npm npm ci

COPY app/ .

RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine AS final

COPY --from=builder /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

