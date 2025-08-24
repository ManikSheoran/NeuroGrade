# Use Node.js 20 LTS
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy source code
COPY . .

# Create a non-root user
RUN addgroup -g 1001 -S nodejs
RUN adduser -S appuser -u 1001
RUN chown -R appuser:nodejs /app
USER appuser

# Expose port
EXPOSE 8001

# Command to run the application
CMD ["npm", "start"]
