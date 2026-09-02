# 🚀 24/7 Home Server: The Complete 0-to-1 Master Blueprint

> Turn any old/spare laptop or PC into a 24/7 headless private cloud server with **Immich** (Google Photos), **Jellyfin** (Private Netflix + Free Live Cable TV), and **FileBrowser** (Web Drive & Remote Media Uploader).
> Official GitHub: `https://github.com/sagomedia/Setup-server.git`

---

## 📋 Master Table of Contents
1. [Hardware & Power Preparation (The Lid-Close Trick)](#1-hardware--power-preparation)
2. [Headless SSH & Remote Control Setup](#2-headless-ssh--remote-control-setup)
3. [1-Click Installation (Ubuntu & Windows)](#3-1-click-installation)
4. [The Sago Launchpad Dashboard (Port 8000)](#4-the-sago-launchpad-dashboard)
5. [3 Easy Ways to Upload Movies & Files Remotely](#5-3-easy-ways-to-upload-movies--files-remotely)
6. [Smart TV & Free Live Cable TV Setup in Jellyfin](#6-smart-tv--free-live-cable-tv-setup-in-jellyfin)
7. [Immich Photo Gallery & Mobile Auto-Backup Setup](#7-immich-photo-gallery--mobile-auto-backup-setup)
8. [Worldwide 5G Access with Tailscale (Zero Port Forwarding)](#8-worldwide-5g-access-with-tailscale)
9. [Power Cut Recovery & Client Troubleshooting Runbook](#9-power-cut-recovery--client-troubleshooting)

---

## 1. Hardware & Power Preparation

- **The Laptop**: Any laptop with 4GB+ RAM, working WiFi or Ethernet port, and charger plugged in.
- **Why a laptop is better than a desktop**: A laptop already has a built-in battery backup (UPS), built-in WiFi, and uses only ~15W–25W of electricity.

### The "Lid-Close" 24/7 Configuration:
To tuck the laptop into a corner or cupboard with the screen closed:

#### On Windows:
1. Open **Control Panel** → **Power Options**.
2. Click **"Choose what closing the lid does"** on the left.
3. Set **"When I close the lid (Plugged in)"** to **"Do nothing"**.
4. Click **Save changes**.

#### On Ubuntu / Linux:
1. Open terminal and edit the logind config:
   ```bash
   sudo nano /etc/systemd/logind.conf
   ```
2. Set:
   ```ini
   HandleLidSwitch=ignore
   HandleLidSwitchDocked=ignore
   ```
3. Restart the service:
   ```bash
   sudo systemctl restart systemd-logind
   ```

---

## 2. Headless SSH & Remote Control Setup

You never need to plug a monitor or keyboard into the server laptop again.

### Finding Server IP Address:
- **Ubuntu**: `hostname -I` (e.g. `192.168.0.140`)
- **Windows**: `ipconfig`

### Connecting from Your Main PC / Mac:
Open terminal or command prompt:
```bash
ssh <username>@192.168.0.140
```
*(You can also use **VS Code Remote-SSH** to edit files directly on the server).*

---

## 3. 1-Click Installation

### 🐧 On Ubuntu / Debian / Linux:
```bash
git clone https://github.com/sagomedia/Setup-server.git
cd Setup-server/02-Build
chmod +x setup.sh
./setup.sh
```
*Auto-detects and installs Docker if missing, initializes directories, configures database credentials, and launches all 4 services.*

### 🪟 On Windows 10/11:
1. Install [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop/) (ensure WSL2 is enabled).
2. Open the `Setup-server\02-Build` folder.
3. Double-click **`setup.bat`** (or open PowerShell and run `docker compose up -d`).

---

## 4. The Sago Launchpad Dashboard

Open your browser to:
👉 **`http://<laptop-ip>:8000`** *(e.g. `http://192.168.0.140:8000` or `http://localhost:8000`)*

The Launchpad provides 1-click access to all services:
- 📸 **Immich Photos** (`:2283`): Google Photos alternative with AI facial recognition.
- 🎬 **Jellyfin Movies & Live TV** (`:8096`): 4K streaming + Live TV channels + Smart TV app.
- 📁 **FileBrowser Drive** (`:8088`): Web file drive & movie uploader (**Login: `admin` / `admin12345678`**).

---

## 5. 3 Easy Ways to Upload Movies & Files Remotely

How to add movies or documents to the server from another PC, Mac, or phone without opening the server laptop:

### 🌟 Method 1: Web Drag-and-Drop via FileBrowser (Easiest — Works on Any Device)
1. Open FileBrowser: `http://192.168.0.140:8088` in your browser.
2. Log in with `admin` / `admin12345678`.
3. Open the **`media/movies`** folder.
4. Drag and drop any `.mp4` or `.mkv` movie directly into the browser window!
5. In 10 seconds, Jellyfin auto-scans and the movie appears with full poster and cast info!

### 🪟 Method 2: Native Windows / Mac Network Share (SMB)
Turn on Ubuntu's native folder sharing so the server appears as a drive in Windows File Explorer:
1. On the Ubuntu server, right-click the `data/media` folder → **"Local Network Share"** → Enable **"Share this folder"**.
2. On your Windows PC, open File Explorer and type in the address bar:
   `\\192.168.0.140\movies`
3. Enter the server's username and password. Now drag and drop files as if it were an internal hard drive!

### 🔌 Method 3: SFTP / FileZilla / WinSCP
1. Open FileZilla or WinSCP on your computer.
2. Host: `192.168.0.140`, Port: `22`, Protocol: `SFTP`.
3. Enter server username & password.
4. Drag-and-drop huge 50GB 4K movie files over high-speed local WiFi!

---

## 6. Smart TV & Free Live Cable TV Setup in Jellyfin

### Watching 4K Movies on Smart TV:
1. Install **Jellyfin** on Android TV, Google TV, Samsung TV, or FireTV Stick.
2. Open the app — it automatically detects your server on home WiFi without typing any IP address.
3. Play 4K movies with full subtitle and multi-audio language support using your TV remote.

### Adding Free 1000+ Live Cable TV Channels (IPTV):
1. Open Jellyfin web: `http://localhost:8096` → Go to **Dashboard** → **Live TV**.
2. Under **Tuner Devices**, click **`+` (Add)**:
   - Type: **M3U Tuner**
   - URL: `https://iptv-org.github.io/iptv/countries/in.m3u` *(Indian Live Channels)* or `https://iptv-org.github.io/iptv/index.m3u` *(Global Channels)*.
   - Click **Save**.
3. Now a **Live TV** channel guide appears on your Smart TV and phone to watch live broadcasts for ₹0!

---

## 7. Immich Photo Gallery & Mobile Auto-Backup Setup

1. Complete the quick web onboarding at `http://localhost:2283`.
2. Download the **Immich app** on your Android / iPhone.
3. Open the app:
   - Server URL: `http://192.168.0.140:2283`
   - Log in with your Immich email & password.
4. Tap **Backup** → Select your Camera Album → Tap **Start Backup**.
5. All new photos automatically sync to your server over WiFi in original 4K/RAW quality with zero cloud storage limits!

---

## 8. Worldwide 5G Access with Tailscale

Bypass home broadband CGNAT without router port forwarding:

1. **On the Server Laptop**:
   ```bash
   curl -fsSL https://tailscale.com/install.sh | sh
   sudo tailscale up
   ```
   Log in with your Google/GitHub account and note your Tailscale IP (e.g. `100.70.14.22`).

2. **On Your Phone**:
   - Install **Tailscale** and log in with the **same account**.
   - Turn the VPN switch **ON**.

3. **Open Services from Anywhere**:
   - Dashboard: `http://100.70.14.22:8000`
   - Photos: `http://100.70.14.22:2283`
   - Movies & Live TV: `http://100.70.14.22:8096`
   - File Drive: `http://100.70.14.22:8088`

---

## 9. Power Cut Recovery & Client Troubleshooting Runbook

### What happens after a power cut?
- Once power returns and the laptop turns on, Docker starts automatically.
- All 4 services auto-restart within 30 seconds. No manual intervention required!

### Health Check Command:
```bash
./test-stack.sh
```
Look for 4 green checkmarks: `✅ PASS (HTTP 200)`.

### How to restart if anything ever gets stuck:
```bash
docker compose up -d
```

### Changing Default Passwords:
- **FileBrowser**: Click **Settings** on the left menu → **User Management** → Click `admin` → Enter new password.
- **Immich & Jellyfin**: Change in **User Settings** inside each web portal.
