#!/usr/bin/env bash
set -e

# ==============================================================================
# SAGO 24/7 HOME SERVER — ROOT 1-CLICK LAUNCHER
# ==============================================================================

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR/02-Build"
chmod +x setup.sh test-stack.sh clean-reset.sh 2>/dev/null || true
./setup.sh
