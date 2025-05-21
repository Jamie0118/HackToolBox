
# HackToolBox v1.0

**Author:** Jamie0118  
**License:** MIT  
**Version:** 1.0  

---

## Disclaimer

**This tool is for educational and ethical testing purposes only.**  
**Unauthorized access to networks is illegal.**  
I am **not responsible** for misuse or any illegal activity caused by this tool.  
**Use at your own risk.**

---

## Features

HackToolBox is a terminal-based toolkit that simplifies the use of popular hacking tools for:

- **WiFi Hacking**
  - Enable monitor mode
  - Scan nearby networks
  - Capture WPA/WPA2 handshakes
  - Crack captured handshakes using wordlists

- **Brute Force Attacks (Hydra)**
  - Attack protocols like SSH, FTP, HTTP
  - Use custom or built-in wordlists

- **Network Scanning (Nmap)**
  - Detect active hosts and open ports
  - Identify services and operating systems

- **MAC Spoofing**
  - Randomize MAC address for anonymity
  - Useful for bypassing filters

- **Simple Port Scanner**
  - Scan common ports on a given IP

- **Custom Command Launcher**
  - Run your own Linux commands within the tool

---

## 🧾 Installation

1. **Clone the Repository**
   ```bash
   git clone https://github.com/yourname/hacktoolbox.git
   cd hacktoolbox
   ```

2. **Make it Executable**
   ```bash
   chmod +x hacktoolbox.sh
   ```

3. **Run the Script**
   ```bash
   ./hacktoolbox.sh
   ```

---

## 🔑 Requirements

Make sure the following tools are installed (pre-installed on Kali Linux):

- `airmon-ng`
- `airodump-ng`
- `aircrack-ng`
- `nmap`
- `hydra`
- `macchanger`

---

## 💬 Commands Inside the Script

Once the script is running, you can type any of the following commands:

| Command     | Description                            |
|-------------|----------------------------------------|
| `wifi`      | Access WiFi hacking tools              |
| `scan`      | Start a network scan with Nmap         |
| `brute`     | Perform brute-force attacks with Hydra |
| `macspoof`  | Spoof MAC address                      |
| `portscan`  | Scan ports using Bash                  |
| `custom`    | Run custom Linux commands              |

---

## 📁 Wordlists

Recommended wordlists:
- `/usr/share/wordlists/rockyou.txt`
- `/usr/share/wordlists/fasttrack.txt`

---

## 📃 License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for more details.

---
