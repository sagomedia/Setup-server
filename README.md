# 🚀 SAGO 24/7 Home Server

Turn any old/fresh PC or laptop into an unlimited, 24/7 private cloud for **₹0 monthly fees**.

## 📦 What's Included
1. **Sago Launchpad Dashboard (Port 80 & 8000)** — Unified zero-port landing page with dynamic routing.
2. **Immich (Port 2283)** — Google Photos alternative with AI face recognition & mobile auto-sync.
3. **Jellyfin (Port 8096)** — Private Netflix/OTT media server with Smart TV auto-discovery (DLNA).
4. **FileBrowser (Port 8088)** — Web-based Google Drive file manager.
5. **Tailscale (5G Mesh)** — Access from anywhere in the world without port forwarding.

---

## ⚡ 1-Line Setup on Any Fresh Computer

Clone the repo and run the bootstrap script:

```bash
git clone https://github.com/sagomedia/Setup-server.git
cd Setup-server/02-Build
chmod +x setup.sh
./setup.sh
```

---

## 🪟 Windows 10/11 Setup

1. Install [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop/) (WSL2 backend enabled).
2. Open PowerShell or Command Prompt:
   ```powershell
   git clone https://github.com/sagomedia/Setup-server.git
   cd Setup-server\02-Build
   docker compose up -d
   ```

---

## 🌐 Accessing Your Services

Open your browser and navigate to:
- 👉 **`http://localhost`** (or your laptop's local IP like `http://192.168.1.50`)

| Service | Address | Purpose |
|---|---|---|
| 🌐 **Sago Launchpad** | `http://<laptop-ip>` | Unified home portal (No port numbers needed) |
| 📸 **Immich Photos** | `http://<laptop-ip>:2283` | AI Face recognition, map timeline, photo sync |
| 🎬 **Jellyfin Movies** | `http://<laptop-ip>:8096` | 4K Private streaming + Smart TV auto-connect |
| 📁 **FileBrowser Drive** | `http://<laptop-ip>:8088` | Web file drive (Default: `admin` / `admin`) |

---

## 📺 Smart TV Living Room Connect
Install the official **Jellyfin app** from the Google Play Store / FireTV Store on your TV. It will automatically detect this server on your home WiFi without typing any IP addresses.

---

## 🌐 Worldwide 5G Access (Tailscale)
```bash
sudo tailscale up
```
Install the Tailscale app on your phone to access all your services over 5G data from anywhere in the world.
