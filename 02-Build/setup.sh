#!/usr/bin/env bash
set -e

# ==============================================================================
# SAGO AUTOMATIONS — 1-CLICK 24/7 HOME SERVER (FRESH MACHINE BOOTSTRAP)
# ==============================================================================

echo "========================================================="
echo " 🚀 SAGO AUTOMATIONS — 24/7 HOME SERVER ZERO-DEPENDENCY SETUP"
echo "========================================================="

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

# 1. Check and Auto-Install Docker if missing (Ubuntu/Debian)
if ! command -v docker &> /dev/null; then
    echo "⚠️ Docker is not installed on this machine."
    echo "⚙️ Auto-installing official Docker engine..."
    curl -fsSL https://get.docker.com | sh
    sudo usermod -aG docker "$USER" 2>/dev/null || true
    echo "✅ Docker installed successfully."
else
    echo "✅ Docker is already installed."
fi

# 2. Setup .env configuration
if [ ! -f .env ]; then
    echo "⚙️ Creating .env configuration from .env.example..."
    cp .env.example .env
fi

# 3. Create persistent directories
echo "📁 Pre-creating persistent storage directories..."
mkdir -p data/files
mkdir -p data/filebrowser
mkdir -p data/jellyfin/config data/jellyfin/cache
mkdir -p data/media/movies data/media/shows
mkdir -p data/immich/photos data/immich/postgres data/immich/model-cache
mkdir -p config/nginx/html config/nginx

# 4. Pull and launch containers
echo "🐳 Launching Home Server Stack via Docker Compose..."
docker compose pull
docker compose up -d

# 5. Get Local IP Address
LOCAL_IP=$(hostname -I 2>/dev/null | awk '{print $1}' || echo "localhost")

echo ""
echo "========================================================="
echo " 🎉 CONGRATULATIONS! YOUR HOME SERVER IS LIVE & RUNNING!"
echo "========================================================="
echo ""
echo " 🌐 Sago Launchpad (Dashboard) : http://${LOCAL_IP}"
echo " 📸 Immich Photos              : http://${LOCAL_IP}:2283"
echo " 🎬 Jellyfin Movies (Smart TV) : http://${LOCAL_IP}:8096"
echo " 📁 FileBrowser Drive          : http://${LOCAL_IP}:8080"
echo ""
echo " 💡 Default FileBrowser Login : admin / admin"
echo " 💡 Smart TV: Install Jellyfin app on TV — auto-detects this server!"
echo " 💡 Remote 5G Access: Run 'sudo tailscale up' (see tailscale-guide.md)"
echo "========================================================="
