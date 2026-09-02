# 🚀 SAGO 24/7 Home Server

Turn any old/fresh PC or laptop into an unlimited, 24/7 private cloud for **₹0 monthly fees**.

## 📦 What's Included
1. **Sago Launchpad Dashboard (Port 8000)** — Unified landing page with 1-click access.
2. **Immich (Port 2283)** — Google Photos alternative with AI face recognition & mobile auto-sync.
3. **Jellyfin (Port 8096)** — Private Netflix/OTT media server + Free Live Cable TV (IPTV) + Smart TV app.
4. **FileBrowser (Port 8088)** — Web-based Google Drive file manager.
5. **Tailscale (5G Mesh)** — Access from anywhere in the world without port forwarding.

---

## ⚡ 1-Line Setup on Any Fresh Computer

### 🐧 On Linux / Ubuntu:
```bash
git clone https://github.com/sagomedia/Setup-server.git
cd Setup-server/02-Build
chmod +x setup.sh
./setup.sh
```

### 🪟 On Windows:
1. Install [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop/) (WSL2 backend).
2. Open the cloned folder and double-click **`setup.bat`** (or run `docker compose up -d`).

---

## 🌐 Accessing Your Services

Open your browser and navigate to:
- 👉 **`http://localhost:8000`** (or your laptop's local IP like `http://192.168.0.140:8000`)

| Service | Address | Login Details | Purpose |
|---|---|---|---|
| 🌐 **Launchpad Dashboard** | `http://<laptop-ip>:8000` | — | Unified portal |
| 📸 **Immich Photos** | `http://<laptop-ip>:2283` | Your email & password | AI Face recognition, photo sync |
| 🎬 **Jellyfin Movies & Live TV** | `http://<laptop-ip>:8096` | Your Jellyfin user | 4K Streaming + Live TV channels |
| 📁 **FileBrowser Drive** | `http://<laptop-ip>:8088` | **admin** / **admin12345678** | Web file drive |

---

## 📺 Free Live Cable TV in Jellyfin (IPTV)
1. Go to **Dashboard** → **Live TV** → **Tuner Devices (+)**.
2. Select **M3U Tuner** and paste: `https://iptv-org.github.io/iptv/countries/in.m3u` (Indian Live Channels) or `https://iptv-org.github.io/iptv/index.m3u` (Global Channels).
3. Save to watch live broadcast TV channels on your Smart TV, phone, and PC!

---

## 🌐 Worldwide 5G Access (Tailscale)
```bash
sudo tailscale up
```
Install the Tailscale app on your phone to access all your services over 5G data from anywhere in the world.
