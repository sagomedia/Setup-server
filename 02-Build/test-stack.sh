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
    STATUS=$(curl -s -L -o /dev/null -w "%{http_code}" "$url" --connect-timeout 8 || echo "000")
    
    if [[ "$STATUS" =~ ^($expected)$ ]]; then
        echo "✅ PASS (HTTP $STATUS)"
        PASS=$((PASS + 1))
    else
        echo "❌ FAIL (Got HTTP $STATUS, Expected $expected)"
        FAIL=$((FAIL + 1))
    fi
}

# 1. Port 80 Gateway (or fallback 8000)
GW_URL="http://localhost"
if ! curl -s -o /dev/null --connect-timeout 2 "http://localhost" 2>/dev/null; then
    if curl -s -o /dev/null --connect-timeout 2 "http://localhost:8000" 2>/dev/null; then
        GW_URL="http://localhost:8000"
    fi
fi
check_service "Sago Launchpad ($GW_URL)" "$GW_URL" "200|302|301"

# 2. FileBrowser Drive (Port 8088)
check_service "FileBrowser Drive (Port 8088)" "http://localhost:8088" "200|302|301|401"

# 3. Jellyfin Streaming (Port 8096)
check_service "Jellyfin Streaming (Port 8096)" "http://localhost:8096" "200|302|301"

# 4. Immich Photos (Port 2283)
check_service "Immich Photos (Port 2283)" "http://localhost:2283" "200|302|301|401|404"

echo ""
echo "========================================================="
if [ $FAIL -eq 0 ]; then
    echo " 🎉 ALL $PASS SERVICES ARE HEALTHY & RESPONSIVE!"
else
    echo " ⚠️ $FAIL service(s) did not respond."
    echo ""
    echo " 💡 Diagnostic Tip: Run 'docker compose ps' to see active containers."
fi
echo "========================================================="
