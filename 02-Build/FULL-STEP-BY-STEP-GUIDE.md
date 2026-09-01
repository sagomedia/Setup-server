# 🚀 Sago 24/7 Home Server: The Complete 0-to-1 Blueprint

> Turn any old laptop or PC into a 24/7 headless private cloud server with **Immich** (Google Photos), **Jellyfin** (Private Netflix), and **FileBrowser** (Google Drive).
> Works across two tiers: **Tier 1 (Local 1Gbps Home WiFi)** and **Tier 2 (Worldwide 5G via Tailscale)**.

---

## 📋 Table of Contents
1. [Hardware & Power Preparation](#1-hardware--power-preparation)
2. [Lid Close Configuration (Keep Running 24/7)](#2-lid-close-configuration)
3. [Headless SSH Setup (Control from Your Main PC)](#3-headless-ssh-setup)
4. [Docker Installation (Windows & Ubuntu)](#4-docker-installation)
5. [1-Click Sago Stack Launch](#5-1-click-sago-stack-launch)
6. [Tier 1: Local 1Gbps WiFi Setup (Zero Internet Data)](#6-tier-1-local-1gbps-wifi-setup)
7. [Tier 2: Worldwide 5G Access via Tailscale](#7-tier-2-worldwide-5g-access-via-tailscale)
8. [Next Steps: AI Agents & Custom Hosting](#8-next-steps-ai-agents--custom-hosting)

---

## 1. Hardware & Power Preparation

- **Laptop**: Any old laptop (Windows 10/11 or Ubuntu 20.04+, 4GB+ RAM recommended).
- **Power**: Keep charger plugged in 24/7.
- **Network**: Connect to your home WiFi router (or plug in an Ethernet cable for max 1Gbps stability).

---

## 2. Lid Close Configuration

To keep the server running silently in a corner with the screen closed:

### On Windows:
1. Open **Control Panel** → **Power Options**.
2. Click **"Choose what closing the lid does"** on the left panel.
3. Set **"When I close the lid"** (Plugged in) to **"Do nothing"**.
4. Click **Save changes**.

### On Ubuntu / Linux:
1. Edit the system login manager config:
   ```bash
   sudo nano /etc/systemd/logind.conf
   ```
2. Find and set:
   ```ini
   HandleLidSwitch=ignore
   HandleLidSwitchDocked=ignore
   ```
3. Restart the service:
   ```bash
   sudo systemctl restart systemd-logind
   ```

---

## 3. Headless SSH Setup

Control the server laptop remotely from your primary laptop/desktop without needing an extra monitor or keyboard.

### On Ubuntu Server / Desktop:
1. Install and enable OpenSSH:
   ```bash
   sudo apt update && sudo apt install -y openssh-server
   sudo systemctl enable --now ssh
   ```
2. Find the laptop's local IP address:
   ```bash
   hostname -I
   # Example output: 192.168.1.50
   ```

### On Windows (Server Laptop):
1. Go to **Settings** → **System** → **Optional features**.
2. Ensure **"OpenSSH Server"** is installed.
3. Start the SSH service in PowerShell (Run as Admin):
   ```powershell
   Start-Service sshd
   Set-Service -Name sshd -StartupType 'Automatic'
   ```
4. Find IP address via `ipconfig`.

### Connecting from your Main Computer:
Open terminal/cmd on your main machine:
```bash
ssh <username>@192.168.1.50
```
*(Tip: You can also use **VS Code Remote - SSH** extension to open and edit files directly on the server).*

---

## 4. Docker Installation

### On Ubuntu / Debian:
Run the official automated install:
```bash
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker $USER
```
*(Log out and log back in for group changes to take effect).*

### On Windows:
1. Download [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop/).
2. During install, ensure **"Use WSL 2 instead of Hyper-V"** is checked.
3. Start Docker Desktop from the Start Menu.

---

## 5. 1-Click Sago Stack Launch

Once inside the server terminal:

```bash
# Clone or navigate to the directory
cd "/home/gokul/Business man/01-Experiments/2026-09-sago-home-server/02-Build"

# Launch all 3 services
./setup.sh
```

### Active Port Mappings:
| Service | Purpose | Local Port |
|---|---|---|
| **Immich** | Google Photos alternative (AI face recognition) | `http://<laptop-ip>:2283` |
| **Jellyfin** | Private Netflix / OTT 4K streaming | `http://<laptop-ip>:8096` |
| **FileBrowser** | Web-based Google Drive file manager | `http://<laptop-ip>:8080` |

---

## 6. Tier 1: Local 1Gbps WiFi Setup

When you are at home on the same WiFi network:
- Access using the local IP: `http://192.168.1.50:2283`
- **Why this is unbeatable:**
  1. **1Gbps Transfer Speeds**: 4K movies seek and play instantly with zero buffering.
  2. **Zero Internet Consumption**: Data travels directly between your phone and laptop over the local router — no broadband GB quota is used.
  3. **Multi-device Streaming**: Multiple family members can stream simultaneously without bandwidth choking.

---

## 7. Tier 2: Worldwide 5G Access via Tailscale

To access your server while outside your home (bypassing ISP CGNAT without router port forwarding):

### 1. On the Server Laptop:
```bash
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up
```
Log in using your Google or GitHub account. Note your Tailscale IP (e.g. `100.80.20.10`).

### 2. On Your Phone / Tablet:
1. Install **Tailscale** from the App Store / Play Store.
2. Sign in with the **same account**.
3. Toggle the VPN switch to **Connected**.

### 3. Open Services via Tailscale IP:
- Photos on 5G: `http://100.80.20.10:2283`
- Movies on 5G: `http://100.80.20.10:8096`
- Files on 5G: `http://100.80.20.10:8080`

---

## 8. Next Steps: AI Agents & Custom Hosting

Your 24/7 server is now a launchpad for advanced automation:
- **Autonomous Coding Agents**: Run background agents (Hermes, Codex) for overnight research and tasks.
- **WhatsApp Client Bots**: Host business customer care and automated booking bots.
- **Personal Websites**: Expose your portfolio on a custom domain with Cloudflare Tunnels.
