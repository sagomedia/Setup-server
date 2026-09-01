# SAGO 24/7 Private Home Server Blueprint

Turn any old PC or laptop into an unlimited, 24/7 private cloud for **₹0 monthly fees**.

## 📦 What's Inside:
1. **Immich** — Google Photos alternative with AI face recognition, map view, and mobile auto-sync.
2. **Jellyfin** — Private Netflix/OTT media server for 4K streaming to TV/Phone/iPad.
3. **FileBrowser** — Web-based Google Drive file manager for documents and project files.
4. **Tailscale** — Encrypted private mesh VPN for worldwide access over 5G without port forwarding.

---

## 🚀 Quick Start (1-Minute Setup)

### 1. Run the Setup Script
```bash
chmod +x setup.sh
./setup.sh
```

### 2. Access the Web Portals:
- 📸 **Google Photos (Immich)**: [http://localhost:2283](http://localhost:2283)
- 🎬 **Movies & Series (Jellyfin)**: [http://localhost:8096](http://localhost:8096)
- 📁 **Files & Documents (FileBrowser)**: [http://localhost:8080](http://localhost:8080)

---

## 🧪 Testing the Stack
Run the automated validation check:
```bash
chmod +x test-stack.sh
./test-stack.sh
```
