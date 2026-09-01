#!/usr/bin/env bash

# Sago Automations — Home Server Health & Validation Test
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

echo "========================================================="
echo " 🧪 RUNNING SAGO HOME SERVER HEALTH CHECK"
echo "========================================================="

PASS=0
FAIL=0

check_service() {
    local name="$1"
    local url="$2"
    local expected="$3"
    
    echo -n "🔍 Testing $name ($url)... "
    # Follow redirects (-L) and capture final HTTP response code
    STATUS=$(curl -s -L -o /dev/null -w "%{http_code}" "$url" --connect-timeout 8 || echo "000")
    
    if [[ "$STATUS" =~ ^($expected)$ ]]; then
        echo "✅ PASS (HTTP $STATUS)"
        PASS=$((PASS + 1))
    else
        echo "❌ FAIL (Got HTTP $STATUS, Expected $expected)"
        FAIL=$((FAIL + 1))
    fi
}

# 1. Port 80 Gateway
check_service "Sago Launchpad (Port 80)" "http://localhost" "200|302|301"

# 2. FileBrowser
check_service "FileBrowser Drive (Port 8080)" "http://localhost:8080" "200|302|301"

# 3. Jellyfin
check_service "Jellyfin Streaming (Port 8096)" "http://localhost:8096" "200|302|301"

# 4. Immich
check_service "Immich Photos (Port 2283)" "http://localhost:2283" "200|302|301|401|404"

echo ""
echo "========================================================="
if [ $FAIL -eq 0 ]; then
    echo " 🎉 ALL $PASS SERVICES ARE HEALTHY & RESPONSIVE!"
else
    echo " ⚠️ $FAIL service(s) did not respond yet."
    echo ""
    echo " 💡 Diagnostic Steps:"
    echo "    1. Check container status: docker compose ps"
    echo "    2. Check Jellyfin logs   : docker compose logs jellyfin --tail 20"
    echo "    3. Check Immich logs     : docker compose logs immich-server --tail 20"
fi
echo "========================================================="
