# -------- Stage 1: Build --------
FROM node:20-alpine AS builder

WORKDIR /app

# Copy package files first
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy source code
COPY . .

# -------- Stage 2: Run --------
FROM node:20-alpine

WORKDIR /app

# Copy built app from builder
COPY --from=builder /app /app

# Expose port
EXPOSE 3000

# Start Node.js app
CMD ["node", "index.js"]
