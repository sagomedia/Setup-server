#!/usr/bin/env bash
set -e

# Sago Automations — 1-Click Home Server Setup
echo "========================================================="
echo " 🚀 SAGO AUTOMATIONS — 24/7 HOME SERVER 1-CLICK SETUP"
echo "========================================================="

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

# 1. Check Docker & Compose
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Install Docker first:"
    echo "   curl -fsSL https://get.docker.com | sh"
    exit 1
fi

echo "✅ Docker & Compose detected."

# 2. Setup .env file
if [ ! -f .env ]; then
    echo "⚙️ Creating .env configuration from template..."
    cp .env.example .env
fi

# 3. Create required data directories
echo "📁 Creating persistent storage directories..."
mkdir -p data/files
mkdir -p data/filebrowser
mkdir -p data/jellyfin/config data/jellyfin/cache
mkdir -p data/media/movies data/media/shows
mkdir -p data/immich/photos data/immich/postgres data/immich/model-cache

# 4. Pull and launch containers
echo "🐳 Launching Home Server Stack via Docker Compose..."
docker compose pull
docker compose up -d

# 5. Get Local IP Address
LOCAL_IP=$(hostname -I 2>/dev/null | awk '{print $1}' || echo "localhost")

echo ""
echo "========================================================="
echo " 🎉 ALL SERVICES ARE NOW LIVE & RUNNING 24/7!"
echo "========================================================="
echo ""
echo " 📸 Immich (Google Photos)   : http://${LOCAL_IP}:2283"
echo " 🎬 Jellyfin (Private OTT)   : http://${LOCAL_IP}:8096"
echo " 📁 FileBrowser (Web Drive)  : http://${LOCAL_IP}:8080"
echo ""
echo " 💡 Default FileBrowser login : admin / admin (Change immediately)"
echo " 💡 For remote access outside home, install Tailscale (see tailscale-guide.md)"
echo "========================================================="
