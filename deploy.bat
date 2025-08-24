@echo off
REM NeuroGrade Deployment Script for Windows

echo 🚀 Starting NeuroGrade deployment...

REM Check if Docker is running
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Docker is not running. Please start Docker first.
    exit /b 1
)

REM Check if .env file exists
if not exist .env (
    echo ⚠️  .env file not found. Creating from template...
    copy .env.example .env
    echo 📝 Please edit .env file with your actual values before running again.
    exit /b 1
)

REM Build and start services
echo 🔨 Building Docker images...
docker-compose build --no-cache

echo 🚀 Starting services...
docker-compose up -d

REM Wait for services to be ready
echo ⏳ Waiting for services to start...
timeout /t 30 /nobreak

REM Check service health
echo 🔍 Checking service status...
docker-compose ps

echo ✅ NeuroGrade deployment completed!
echo.
echo 🌐 Application URLs:
echo    Frontend: http://localhost:3000
echo    Backend API: http://localhost:8001
echo    FastAPI: http://localhost:8000
echo    Nginx (if enabled): http://localhost
echo.
echo 📊 To view logs: docker-compose logs -f
echo 🛑 To stop: docker-compose down

pause
