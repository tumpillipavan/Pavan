
# Stage 1: Build the application
FROM node:22.13.1-slim AS builder

# Set the working directory
WORKDIR /app/public

# Copy package files and install dependencies
COPY --link package.json package-lock.json ./
RUN --mount=type=cache,target=/root/.npm npm ci

# Copy the application source code
COPY --link . .

# Build the application
RUN npm run build

# Stage 2: Prepare the production image
FROM node:22.13.1-slim AS final

# Set the working directory
WORKDIR /app

# Copy the built application and necessary files from the builder stage
COPY --from=builder /app/build ./build
COPY --from=builder /app/package.json ./
COPY --from=builder /app/node_modules ./node_modules

# Set environment variables     
ENV NODE_ENV=production

# Expose the application port
EXPOSE 3000

# Define the command to run the application
CMD ["npm", "start"]


