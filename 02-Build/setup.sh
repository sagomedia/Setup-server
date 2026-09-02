#!/usr/bin/env bash
set -e

# ==============================================================================
# 24/7 HOME SERVER 1-CLICK SETUP (ZERO-DEPENDENCY BOOTSTRAP)
# ==============================================================================

echo "========================================================="
echo " 🚀 24/7 HOME SERVER SETUP"
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

# 4. Clean & Initialize persistent directories via Docker
echo "📁 Initializing storage volumes and setting permissions..."
mkdir -p data config/nginx/html config/nginx
docker run --rm -v "$DIR/data:/data" alpine sh -c "mkdir -p /data/files /data/filebrowser /data/jellyfin/config /data/jellyfin/cache /data/media/movies /data/media/shows /data/immich/photos /data/immich/postgres /data/immich/model-cache && chmod -R 777 /data" 2>/dev/null || chmod -R 777 data 2>/dev/null || true

# 5. Stop running containers before database operations
echo "🛑 Stopping containers for clean initialization..."
$DOCKER_CMD down --remove-orphans 2>/dev/null || true

# 6. Initialize FileBrowser DB & Pre-configure admin / admin12345678
if [ ! -f "$DIR/data/filebrowser/filebrowser.db" ]; then
    echo "🔑 Initializing FileBrowser database and admin credentials..."
    docker run --rm -v "$DIR/data/filebrowser:/database" filebrowser/filebrowser config init -d /database/filebrowser.db 2>/dev/null || true
    docker run --rm -v "$DIR/data/filebrowser:/database" filebrowser/filebrowser users add admin admin12345678 --perm.admin -d /database/filebrowser.db 2>/dev/null || true
else
    echo "🔑 Updating FileBrowser admin password..."
    docker run --rm -v "$DIR/data/filebrowser:/database" filebrowser/filebrowser users update admin --password admin12345678 -d /database/filebrowser.db 2>/dev/null || true
fi

# 7. Launch containers
echo "🐳 Launching Home Server Stack ($DOCKER_CMD up -d)..."
$DOCKER_CMD up -d

# 8. Ensure PostgreSQL has the immich database & proper permissions
echo "🗄️ Verifying Immich database initialization..."
for i in {1..15}; do
    if $DOCKER_CMD exec -T database pg_isready -U postgres &>/dev/null; then
        $DOCKER_CMD exec -T database psql -U postgres -c "CREATE DATABASE immich;" 2>/dev/null || true
        $DOCKER_CMD exec -T database sh -c 'echo "host all all all trust" >> /var/lib/postgresql/data/pg_hba.conf && psql -U postgres -c "SELECT pg_reload_conf();"' 2>/dev/null || true
        break
    fi
    sleep 1
done

# 9. Detect Network IP Addresses
LOCAL_IP=$(ip route get 1.1.1.1 2>/dev/null | awk '{print $7}' || hostname -I 2>/dev/null | awk '{print $1}' || echo "localhost")
TAILSCALE_IP=$(tailscale ip -4 2>/dev/null || echo "")

echo ""
echo "============================================================================"
echo " 🎉 CONGRATULATIONS! YOUR 24/7 PRIVATE HOME SERVER IS LIVE!"
echo "============================================================================"
echo ""
echo " 📱 HOW TO OPEN ON YOUR PHONE & TABLET (Home WiFi):"
echo "    👉 http://${LOCAL_IP}:8000"
echo ""
if [ -n "$TAILSCALE_IP" ]; then
echo " 🌍 HOW TO OPEN ON YOUR PHONE ANYWHERE IN THE WORLD (5G Data):"
echo "    👉 http://${TAILSCALE_IP}:8000"
echo ""
else
echo " 💡 For Worldwide 5G Access: Run 'sudo tailscale up' (see tailscale-guide.md)"
echo ""
fi
echo " 💻 HOW TO OPEN ON THIS COMPUTER:"
echo "    👉 http://localhost:8000"
echo ""
echo " 📺 HOW TO WATCH ON SMART TV (Android TV / FireTV):"
echo "    • Open the Jellyfin app on TV -> Auto-detects this server on your WiFi!"
echo ""
echo " 📁 FILE BROWSER LOGIN CREDENTIALS:"
echo "    • Username : admin"
echo "    • Password : admin12345678"
echo "============================================================================"
echo ""
