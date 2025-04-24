# Stage 1: Build the application
FROM node:22.13.1-slim AS builder

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci

COPY . .
RUN npm run build

# Stage 2: Prepare the production image
FROM node:22.13.1-slim AS final

WORKDIR /app

COPY --from=builder /app/build ./build

RUN npm install -g serve

# Change exposed port to 82
EXPOSE 82

# Serve on port 82 instead of 3000
CMD ["serve", "-s", "build", "-l", "82"]


