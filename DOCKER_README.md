# NeuroGrade Docker Deployment

This guide explains how to deploy the entire NeuroGrade application using Docker and Docker Compose.

## Prerequisites

- Docker Desktop installed and running
- Docker Compose (usually included with Docker Desktop)
- At least 4GB of available RAM
- Port 3000, 8000, 8001, and 80 available

## Quick Start

### For Windows:
```bash
# Clone the repository (if not already done)
git clone <your-repo-url>
cd NeuroGrade

# Run the deployment script
deploy.bat
```

### For Linux/Mac:
```bash
# Clone the repository (if not already done)
git clone <your-repo-url>
cd NeuroGrade

# Make the script executable
chmod +x deploy.sh

# Run the deployment script
./deploy.sh
```

### Manual Deployment:

1. **Setup Environment Variables:**
   ```bash
   # Copy the example environment file
   cp .env.example .env
   
   # Edit .env with your actual values
   # Make sure to update MONGO_URI and GEMINI_API_KEY
   ```

2. **Build and Start Services:**
   ```bash
   # Build all images
   docker-compose build

   # Start all services
   docker-compose up -d
   ```

3. **Verify Deployment:**
   ```bash
   # Check service status
   docker-compose ps

   # View logs
   docker-compose logs -f
   ```

## Services

The application consists of 4 services:

| Service | Port | Description |
|---------|------|-------------|
| **client** | 3000 | Next.js frontend application |
| **server** | 8001 | Node.js Express API server |
| **fastapi** | 8000 | Python FastAPI service |
| **nginx** | 80 | Reverse proxy (optional) |

## URLs

After deployment, access the application at:

- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:8001
- **FastAPI Docs**: http://localhost:8000/docs
- **Nginx (if enabled)**: http://localhost

## Environment Variables

Key environment variables in `.env`:

```env
# Database
MONGO_URI=your_mongodb_connection_string

# API Keys
GEMINI_API_KEY=your_gemini_api_key

# Application URLs
NEXT_PUBLIC_API_URL=http://localhost:8001
NEXT_PUBLIC_FASTAPI_URL=http://localhost:8000

# Security
SESSION_SECRET=your_session_secret
```

## Management Commands

```bash
# Start services
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs -f [service_name]

# Rebuild a specific service
docker-compose build [service_name]

# Restart a service
docker-compose restart [service_name]

# View service status
docker-compose ps

# Remove all containers and networks
docker-compose down --volumes
```

## Troubleshooting

### Common Issues:

1. **Port already in use:**
   ```bash
   # Check what's using the port
   netstat -tulpn | grep :3000
   
   # Stop the conflicting service or change port in docker-compose.yml
   ```

2. **MongoDB connection issues:**
   - Verify MONGO_URI in .env file
   - Check if your IP is whitelisted in MongoDB Atlas
   - Ensure DNS resolution is working

3. **Service won't start:**
   ```bash
   # Check logs for specific service
   docker-compose logs [service_name]
   
   # Rebuild the image
   docker-compose build --no-cache [service_name]
   ```

4. **Out of memory:**
   ```bash
   # Check Docker resource usage
   docker system df
   
   # Clean up unused images
   docker system prune
   ```

## Development Mode

For development with hot reloading:

```bash
# Use development override
docker-compose -f docker-compose.yml -f docker-compose.dev.yml up
```

## Production Deployment

For production deployment:

1. Update environment variables in `.env`
2. Configure proper SSL certificates in nginx/ssl/
3. Update nginx configuration for your domain
4. Use a process manager like Docker Swarm or Kubernetes

## Security Notes

- Change the default SESSION_SECRET in production
- Use proper SSL certificates
- Keep your API keys secure
- Regularly update Docker images
- Use non-root users in containers (already configured)

## Monitoring

View real-time logs:
```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f client
docker-compose logs -f server
docker-compose logs -f fastapi
```

## Backup

Important files to backup:
- `.env` (but keep it secure)
- `uploads/` directory
- Database backups (MongoDB Atlas handles this)

For questions or issues, please check the logs first and ensure all environment variables are correctly set.
