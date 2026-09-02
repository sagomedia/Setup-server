#!/usr/bin/env bash
set -e

# ==============================================================================
# SAGO HOME SERVER - 1-CLICK CLEAN RESET FOR LINUX
# ==============================================================================

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

echo "============================================================================"
echo "   SAGO HOME SERVER - COMPLETE CLEAN RESET"
echo "============================================================================"
echo ""
echo "   This will stop all containers, clear any corrupted database files,"
echo "   and launch a 100% fresh, working Home Server stack."
echo ""

echo "🛑 [1/3] Stopping all running containers..."
docker compose down -v --remove-orphans 2>/dev/null || true

echo "🧹 [2/3] Removing stale database files..."
docker run --rm -v "$DIR/data:/data" alpine sh -c "rm -rf /data/immich/postgres /data/filebrowser" 2>/dev/null || rm -rf data/immich/postgres data/filebrowser 2>/dev/null || true

echo "🚀 [3/3] Starting fresh Home Server Stack..."
./setup.sh
