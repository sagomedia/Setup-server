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
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$url" --connect-timeout 5 || echo "000")
    
    if [[ "$STATUS" =~ ^($expected)$ ]]; then
        echo "✅ PASS (HTTP $STATUS)"
        PASS=$((PASS + 1))
    else
        echo "❌ FAIL (Got HTTP $STATUS, Expected $expected)"
        FAIL=$((FAIL + 1))
    fi
}

# 1. FileBrowser check
check_service "FileBrowser (Web Drive)" "http://localhost:8080" "200|302|301"

# 2. Jellyfin check
check_service "Jellyfin (Media Server)" "http://localhost:8096/health" "200|302"

# 3. Immich check
check_service "Immich (Photo Server)" "http://localhost:2283/api/server/version" "200|302|404|401"

echo ""
echo "========================================================="
if [ $FAIL -eq 0 ]; then
    echo " 🎉 ALL $PASS SERVICES ARE HEALTHY & RESPONSIVE!"
else
    echo " ⚠️ $FAIL service(s) failed health check. Check logs with: docker compose logs"
fi
echo "========================================================="
