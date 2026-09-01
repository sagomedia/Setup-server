# 🌐 Worldwide Remote Access with Tailscale

> How to access your Home Server from anywhere in the world on 5G / Mobile Data with **Zero Port Forwarding** and **100% End-to-End Encryption**.

---

## 1. Why Tailscale over Router Port Forwarding?
- Indian home broadband (JioFiber, Airtel Xstream, ACT) uses **CGNAT**. Traditional port forwarding is blocked by ISPs or requires expensive static IPs.
- Tailscale bypasses CGNAT completely by creating a secure mesh VPN (WireGuard protocol) between your laptop and your mobile devices.

---

## 2. Step 1: Install Tailscale on the Laptop (Server)

### On Ubuntu / Linux:
```bash
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up
```
- Click the authentication link printed in the terminal and log in with your Google / GitHub account.
- Note your machine's Tailscale IP (e.g. `100.x.y.z`) or hostname (e.g. `sago-laptop`).

### On Windows:
1. Download and install [Tailscale for Windows](https://tailscale.com/download/windows).
2. Log in with the same account.

---

## 3. Step 2: Install Tailscale on Your Mobile Phone / iPad
1. Download the **Tailscale App** from Google Play Store or Apple App Store.
2. Log in using the **exact same account** you used on the laptop.
3. Turn on the VPN switch in the app.

---

## 4. Step 3: Access Your Services from Anywhere!

Once connected to Tailscale, replace `localhost` or `192.168.x.x` with your laptop's **Tailscale IP (100.x.y.z)**:

| Service | Local Home URL | Anywhere in the World (5G URL) |
|---|---|---|
| **Immich (Photos)** | `http://192.168.1.50:2283` | `http://100.x.y.z:2283` |
| **Jellyfin (Movies)** | `http://192.168.1.50:8096` | `http://100.x.y.z:8096` |
| **FileBrowser (Drive)** | `http://192.168.1.50:8080` | `http://100.x.y.z:8080` |

---

## 5. Live Demonstration Tip for Video Shooting
1. Connect laptop to home WiFi.
2. Turn off WiFi on your phone (switch to 5G).
3. Open Tailscale on phone (shows connected to laptop).
4. Open the Immich app on your phone — upload a live photo.
5. Show the photo appearing instantly on the laptop screen!
