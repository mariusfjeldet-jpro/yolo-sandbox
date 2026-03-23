# 1. Ensure the projects directory exists (the only one Podman can't auto-create)
if (!(Test-Path ./ai-sandbox)) { New-Item -ItemType Directory -Path ./ai-sandbox }

# 2. Run the build and start
podman compose up -d --build

# 3. Drop you straight into the container
podman exec -it yolo-sandbox-yolo-sandbox-1 bash