# 🚀 SAGO 24/7 Home Server Experiment

Turn any old/fresh PC or laptop into an unlimited, 24/7 private cloud for **₹0 monthly fees**.

## 📦 What's Included
1. **Sago Launchpad Dashboard (Port 80)** — Unified zero-port landing page.
2. **Immich (Port 2283)** — Google Photos alternative with AI face recognition & mobile auto-sync.
3. **Jellyfin (Port 8096)** — Private Netflix/OTT media server with Smart TV auto-discovery (DLNA).
4. **FileBrowser (Port 8080)** — Web-based Google Drive file manager.
5. **Tailscale (5G Mesh)** — Access from anywhere in the world without port forwarding.

---

## ⚡ How to Run on a Completely Fresh Computer (Scratch Install)

If you are running this on a brand-new or freshly formatted machine with **zero dependencies installed**:

### Option A: Linux / Ubuntu (Fresh Machine)

1. **Copy this folder** to the fresh computer (via USB drive, SCP, or Git clone).
2. **Open Terminal** inside `02-Build/`:
   ```bash
   cd 02-Build
   chmod +x setup.sh
   ./setup.sh
   ```
   *(The script automatically detects if Docker is missing, installs official Docker, creates storage folders, and launches everything in 1 click).*

---

### Option B: Windows 10/11 (Fresh Machine)

1. Download and install [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop/) (ensure WSL2 backend is selected).
2. Open **PowerShell** or **Command Prompt** inside `02-Build/`:
   ```powershell
   docker compose up -d
   ```
3. Open `http://localhost` in your browser.

---

## 🌐 Accessing the Dashboards

| Service | Local Address |
|---|---|
| 🌐 **Unified Sago Launchpad** | `http://<laptop-ip>` (e.g. `http://192.168.1.50`) |
| 📸 **Immich Photos** | `http://<laptop-ip>:2283` |
| 🎬 **Jellyfin Movies** | `http://<laptop-ip>:8096` |
| 📁 **FileBrowser Drive** | `http://<laptop-ip>:8080` *(Default: `admin` / `admin`)* |

---

## 📺 Smart TV Connect
Install the official **Jellyfin app** from the Google Play Store / FireTV Store on your TV. It will automatically detect this server on your home WiFi without needing to type any IP addresses.
