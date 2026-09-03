# 🚀 24/7 Private Home Server

Turn any old PC, laptop, or spare computer into an unlimited, 24/7 private cloud server for **₹0 monthly fees**.

[![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?logo=docker&logoColor=white)](#)
[![Immich](https://img.shields.io/badge/Google_Photos-Immich-4285F4?logo=google-photos&logoColor=white)](#)
[![Jellyfin](https://img.shields.io/badge/Private_OTT-Jellyfin-00A4DC?logo=jellyfin&logoColor=white)](#)
[![Tailscale](https://img.shields.io/badge/5G_Mesh-Tailscale-24292E?logo=tailscale&logoColor=white)](#)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](#)

---

## 📦 What's Inside?

1. **🌐 Sago Launchpad Dashboard (Port 8000)** — Unified dark-theme portal with 1-click access to all services.
2. **📸 Immich Photos (Port 2283)** — Self-hosted Google Photos alternative with AI face recognition, search, and mobile auto-sync.
3. **🎬 Jellyfin OTT & Live TV (Port 8096)** — Private Netflix streaming in 4K + Free 1000+ Live Cable TV channels (IPTV) + Smart TV auto-connect.
4. **📁 FileBrowser Web Drive (Port 8088)** — Web Google Drive explorer & remote movie uploader (**Login: `admin` / `admin12345678`**).
5. **🌍 Tailscale (Worldwide 5G)** — Access all your services anywhere on earth over cellular data with zero router port forwarding.

---

## ⚡ 1-Line Setup (Runs Everything in 60 Seconds)

### 🐧 On Linux / Ubuntu:
Open your terminal and paste this single command:
```bash
git clone https://github.com/sagomedia/Setup-server.git && cd Setup-server && chmod +x setup.sh && ./setup.sh
```

### 🪟 On Windows 10/11:
1. Install [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop/) (ensure WSL 2 is enabled).
2. Open PowerShell or Command Prompt:
   ```cmd
   git clone https://github.com/sagomedia/Setup-server.git
   cd Setup-server
   setup.bat
   ```
*(Or simply open the cloned `Setup-server` folder and double-click **`setup.bat`**!)*

---

## 🌐 How to Access Your Home Cloud

Open your web browser and navigate to:
👉 **`http://localhost:8000`** *(or `http://<laptop-ip>:8000` from any phone or tablet on home WiFi)*

| Service | Local Address | Default Credentials | Purpose |
|---|---|---|---|
| 🌐 **Launchpad Portal** | `http://<laptop-ip>:8000` | — | Single 1-click home dashboard |
| 📸 **Immich Photos** | `http://<laptop-ip>:2283` | *(Custom user created on first open)* | AI Facial Search, map timeline, photo auto-sync |
| 🎬 **Jellyfin Movies & TV** | `http://<laptop-ip>:8096` | *(Custom user created on first open)* | 4K private streaming + Smart TV app |
| 📁 **FileBrowser Drive** | `http://<laptop-ip>:8088` | **`admin`** / **`admin12345678`** | Web file explorer & drag-and-drop movie uploader |

---

## 🎬 How to Add Movies to Jellyfin (Remote Drag-and-Drop)
1. Open **FileBrowser** (`http://<laptop-ip>:8088`) on any computer or phone.
2. Log in with `admin` / `admin12345678`.
3. Open `media/movies/` and **drag-and-drop your `.mp4` or `.mkv` files** directly into the browser.
4. Jellyfin will auto-detect the file, download official movie posters, cast details, and subtitles within 10 seconds!

---

## 📺 Free 1000+ Live Cable TV in Jellyfin (IPTV)
1. Open Jellyfin (`http://localhost:8096`) → **Dashboard** → **Live TV** → **Tuner Devices (+)**.
2. Choose **M3U Tuner** and paste:
   - 🇮🇳 **Indian Live Channels**: `https://iptv-org.github.io/iptv/countries/in.m3u`
   - 🌐 **Global Channels (News, Sports, Entertainment)**: `https://iptv-org.github.io/iptv/index.m3u`
3. Click **Save** to stream live television channels with full TV guides on your Smart TV, phone, or laptop for ₹0!

---

## 🌍 Worldwide 5G Access via Tailscale

Bypass home broadband CGNAT without router port forwarding:

1. **On the Server Laptop**:
   ```bash
   sudo tailscale up
   ```
   Follow the printed login URL to authenticate with Google or GitHub.
2. **On Your Phone**:
   - Install the **Tailscale app** from Google Play Store or Apple App Store.
   - Log in with the **same account** and turn the VPN toggle **ON**.
3. **Open Your Server on 5G**:
   Type `http://<Tailscale-IP>:8000` in your phone browser to access your entire cloud from anywhere in the world!

---

## 🧹 1-Click Clean Reset

If you ever need to reset or wipe the server to start fresh:
- **On Windows**: Double-click `02-Build\clean-reset.bat`
- **On Linux**: Run `./02-Build/clean-reset.sh`
