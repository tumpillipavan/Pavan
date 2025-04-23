# Stage 1: Build the application
FROM node:22.13.1-slim AS builder

# Set the working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package.json package-lock.json ./
RUN npm ci

# Copy the application source code
COPY . .

# Build the application
RUN npm run build

# Stage 2: Prepare the production image
FROM node:22.13.1-slim AS final

# Set the working directory
WORKDIR /app

# Copy only the built application and necessary files
COPY --from=builder /app/build ./build

# Install 'serve' to serve static files
RUN npm install -g serve

# Expose the application port
EXPOSE 3000

# Serve the built application
CMD ["serve", "-s", "build", "-l", "3000"]
