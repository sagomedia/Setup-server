#!/usr/bin/env bash
set -e

# ==============================================================================
# SAGO AUTOMATIONS — 1-CLICK 24/7 HOME SERVER (ZERO-DEPENDENCY SETUP)
# ==============================================================================

echo "========================================================="
echo " 🚀 SAGO AUTOMATIONS — 24/7 HOME SERVER SETUP"
echo "========================================================="

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

# 1. Check and Auto-Install Docker if missing
if ! command -v docker &> /dev/null; then
    echo "⚙️ Docker not found. Auto-installing official Docker engine..."
    curl -fsSL https://get.docker.com | sh
    sudo usermod -aG docker "$USER" 2>/dev/null || true
    echo "✅ Docker installed."
else
    echo "✅ Docker is already installed."
fi

# 2. Fix Docker Socket Permissions
if ! docker ps &>/dev/null; then
    echo "🔑 Fixing Docker socket permissions for user $USER..."
    sudo chmod 666 /var/run/docker.sock 2>/dev/null || true
fi

DOCKER_CMD="docker compose"
if ! docker compose ps &>/dev/null; then
    if sudo docker compose ps &>/dev/null; then
        DOCKER_CMD="sudo docker compose"
    fi
fi

# 3. Setup .env configuration
if [ ! -f .env ]; then
    echo "⚙️ Creating .env configuration from .env.example..."
    cp .env.example .env
fi

# 4. Clean & Initialize persistent directories via Docker (bypasses sudo password prompts)
echo "📁 Initializing storage volumes and setting full permissions..."
mkdir -p data config/nginx/html config/nginx
docker run --rm -v "$DIR/data:/data" alpine sh -c "mkdir -p /data/files /data/filebrowser /data/jellyfin/config /data/jellyfin/cache /data/media/movies /data/media/shows /data/immich/photos /data/immich/postgres /data/immich/model-cache && chmod -R 777 /data" 2>/dev/null || chmod -R 777 data 2>/dev/null || true

# 5. Stop stale containers and launch
echo "🐳 Launching Home Server Stack ($DOCKER_CMD up -d)..."
$DOCKER_CMD down --remove-orphans 2>/dev/null || true
$DOCKER_CMD up -d

# 6. Get Local IP Address
LOCAL_IP=$(hostname -I 2>/dev/null | awk '{print $1}' || echo "localhost")

echo ""
echo "========================================================="
echo " 🎉 ALL SERVICES ARE NOW LIVE & RUNNING 24/7!"
echo "========================================================="
echo ""
echo " 🌐 Sago Launchpad (Dashboard) : http://${LOCAL_IP}"
echo " 📸 Immich Photos              : http://${LOCAL_IP}:2283"
echo " 🎬 Jellyfin Movies (Smart TV) : http://${LOCAL_IP}:8096"
echo " 📁 FileBrowser Drive          : http://${LOCAL_IP}:8082"
echo ""
echo " 💡 FileBrowser Default Login:"
echo "    • Username : admin"
echo "    • Password : admin"
echo ""
echo " 💡 Smart TV: Install Jellyfin app on TV — auto-detects this server!"
echo " 💡 Remote 5G Access: Run 'sudo tailscale up' (see tailscale-guide.md)"
echo "========================================================="
