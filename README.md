# CTF-Forge v1.0 🏴‍☠️

CTF-Forge is an automated reconnaissance and enumeration tool designed to help CTF players and penetration testers save time during the early stages of a challenge.

It combines common CTF commands into a single, structured, and easy-to-use Bash tool.

## ⚠️ Disclaimer

**This tool is intended for educational purposes and authorized CTF environments only.**

## 👤 Author & Credits

This project is based on common CTF enumeration techniques and publicly available security tools.

Implementation, integration, and customization by **Jihad Tichti**  
Cybersecurity & CTF Enthusiast

*"This project does not claim ownership of the underlying tools used (nmap, gobuster, etc.)."*

## ✨ Features
- Fast full port scanning
- Service and version detection
- Web directory enumeration
- SMB enumeration
- Linux privilege escalation checks
- Flag discovery automation
- Organized output per target

## 🛠️ Tools Used
- nmap
- gobuster
- dirsearch
- enum4linux
- find
- Kali Linux system wordlists

## 📂 Project Structure

```
CTF-Forge/
├── ctf-forge.sh
├── Core/
│   ├── config.sh
│   ├── banner.sh
│   ├── utils.sh
│   └── check_deps.sh
├── Modules/
│   ├── recon.sh
│   ├── web_enum.sh
│   ├── smb_enum.sh
│   ├── privesc.sh
│   └── flag_finder.sh
├── Output/
└── README.md
```


## 🚀 Usage

**1. Clone the repository:**

       git clone https://github.com/jihadtc/CTF-Forge.git

**2. Go into the folder:**

       cd CTF-Forge

**3. Make the script executable:**

       chmod +x ctf-forge.sh

**4. Run the tool:**

       ./ctf-forge.sh

## 🏁 Status

*CTF-Forge v1.0 — stable and ready for CTF use*
---

