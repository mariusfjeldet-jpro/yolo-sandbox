# 1. Run the build and start the container in detached mode
Write-Host "Building and starting Podman Compose..." -ForegroundColor Green
podman compose up -d --build

# 2. Drop you straight into the bash shell of the container
Write-Host "Attaching to container..." -ForegroundColor Cyan
podman compose exec yolo-sandbox bash