#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

# Banner
echo -e "${CYAN}"
echo "##############################################################################################";
echo "#██╗  ██╗ █████╗  ██████╗██╗  ██╗████████╗ ██████╗  ██████╗ ██╗     ██████╗  ██████╗ ██╗  ██╗#";
echo "#██║  ██║██╔══██╗██╔════╝██║ ██╔╝╚══██╔══╝██╔═══██╗██╔═══██╗██║     ██╔══██╗██╔═══██╗╚██╗██╔╝#";
echo "#███████║███████║██║     █████╔╝    ██║   ██║   ██║██║   ██║██║     ██████╔╝██║   ██║ ╚███╔╝ #";
echo "#██╔══██║██╔══██║██║     ██╔═██╗    ██║   ██║   ██║██║   ██║██║     ██╔══██╗██║   ██║ ██╔██╗ #";
echo "#██║  ██║██║  ██║╚██████╗██║  ██╗   ██║   ╚██████╔╝╚██████╔╝███████╗██████╔╝╚██████╔╝██╔╝ ██╗#";
echo "#╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝╚═════╝  ╚═════╝ ╚═╝  ╚═╝#";
echo "#                                                                                            #";
echo "#██████╗ ██╗   ██╗         ██╗ █████╗ ███╗   ███╗██╗███████╗ ██████╗  ██╗ ██╗ █████╗         #";
echo "#██╔══██╗╚██╗ ██╔╝         ██║██╔══██╗████╗ ████║██║██╔════╝██╔═████╗███║███║██╔══██╗        #";
echo "#██████╔╝ ╚████╔╝          ██║███████║██╔████╔██║██║█████╗  ██║██╔██║╚██║╚██║╚█████╔╝        #";
echo "#██╔══██╗  ╚██╔╝      ██   ██║██╔══██║██║╚██╔╝██║██║██╔══╝  ████╔╝██║ ██║ ██║██╔══██╗        #";
echo "#██████╔╝   ██║       ╚█████╔╝██║  ██║██║ ╚═╝ ██║██║███████╗╚██████╔╝ ██║ ██║╚█████╔╝        #";
echo "#╚═════╝    ╚═╝        ╚════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚══════╝ ╚═════╝  ╚═╝ ╚═╝ ╚════╝         #";
echo "##############################################################################################";
echo -e "${NC}"
echo -e "${GREEN}Made by: Jamie0118"
echo "Welcome to HackToolBox v1.0 – Type 'help' to begin"
echo -e "${RED}=============================================="
echo -e "${RED} DISCLAIMER"
echo -e "${RED}=============================================="
echo -e "${RED}This script is intended for educational and ethical testing purposes only."
echo -e "${RED}Unauthorized access to networks is illegal and punishable by law."
echo -e "${RED}We are NOT responsible for any misuse, damage, or illegal activity"
echo -e "${RED}resulting from the use of this script. Use it at your own risk."
echo -e "${RED}=============================================="
echo "Loading..."
sleep 3
echo ""

while true; do
    echo -n -e "${GREEN}hacktoolbox> ${NC}"
    read cmd

    case $cmd in
        wifi)
            echo -e "${CYAN}[WiFi Hacking Menu]${NC}"
            echo "1. Setup monitor mode"
            echo "2. Scan networks"
            echo "3. Capture handshake"
            echo "4. Crack handshake"
            read -p "Select option (1-4): " choice

            case $choice in
                1)
                    echo -e "${GREEN}[Step 1] Detecting WiFi adapters...${NC}"
                    iwconfig 2>/dev/null | grep "IEEE 802.11" | awk '{print $1}' > interfaces.txt
                    mapfile -t adapters < interfaces.txt
                    rm interfaces.txt

                    if [ ${#adapters[@]} -eq 0 ]; then
                        echo -e "${RED}No wireless adapters found.${NC}"
                        break
                    fi

                    echo "Available adapters:"
                    for i in "${!adapters[@]}"; do
                        echo "  [$i] ${adapters[$i]}"
                    done

                    read -p "Choose adapter number: " adapter_index
                    adapter="${adapters[$adapter_index]}"

                    echo -e "${GREEN}Enabling monitor mode on $adapter...${NC}"
                    sudo airmon-ng start $adapter
                    mon_adapter="${adapter}mon"
                    echo -e "${GREEN}Monitor mode: $mon_adapter${NC}"
                    ;;

                2)
                    if [ -z "$mon_adapter" ]; then
                        echo -e "${RED}Please enable monitor mode first (Option 1).${NC}"
                    else
                        echo -e "${CYAN}Scanning networks... Press CTRL+C when target is found.${NC}"
                        sudo airodump-ng $mon_adapter
                    fi
                    ;;

                3)
                    if [ -z "$mon_adapter" ]; then
                        echo -e "${RED}Please enable monitor mode first (Option 1).${NC}"
                    else
                        read -p "Enter target BSSID: " bssid
                        read -p "Enter channel: " channel
                        read -p "Capture filename needs to be can't be same name as existing file (e.g., handshake): " capfile
                        sudo airodump-ng --bssid $bssid -c $channel -w $capfile $mon_adapter
                    fi
                    ;;

                4)
                    echo -e "${CYAN}Choose wordlist:${NC}"
                    wordlists=(
                        "/usr/share/wordlists/rockyou.txt"
                        "/usr/share/wordlists/fasttrack.txt"
                    )
                    for i in "${!wordlists[@]}"; do
                        echo "  [$i] ${wordlists[$i]}"
                    done

                    read -p "Select wordlist number: " windex
                    wordlist="${wordlists[$windex]}"

                    read -p "Enter capture file (e.g., handshake-01.cap): " capname
                    read -p "Enter BSSID of network: " bssid
                    sudo aircrack-ng -w "$wordlist" -b "$bssid" "$capname"
                    ;;
                *)
                    echo -e "${RED}Invalid option.${NC}"
                    ;;
            esac
            ;;

        scan)
            echo -e "${CYAN}[Network Scanning with Nmap]${NC}"
            echo "1. What does this do? (explanation)"
            echo "2. Start a scan"
            read -p "Choose an option (1-2): " scan_choice

            case $scan_choice in
                1)
                    echo -e "${GREEN}[Nmap Explanation]${NC}"
                    echo ""
                    echo "What is Nmap?"
                    echo "Nmap (Network Mapper) is a tool that scans networks to find live hosts,"
                    echo "open ports, and running services. This is useful to detect vulnerable systems."
                    echo ""
                    echo "Basic Syntax:"
                    echo "  nmap [options] [target]"
                    echo ""
                    echo "Common Options Used:"
                    echo "  -sV   → Detect service versions (e.g., which version of SSH, HTTP, etc.)"
                    echo "  -O    → Attempt to detect the operating system"
                    echo ""
                    echo "Example Command:"
                    echo "  nmap -sV -O 192.168.1.0/24"
                    echo ""
                    echo "Explanation of the Example:"
                    echo "  - 'nmap' is the tool"
                    echo "  - '-sV' asks Nmap to probe services and get their version"
                    echo "  - '-O' tries to guess the operating system"
                    echo "  - '192.168.1.0/24' tells it to scan all devices on your local network (254 hosts)"
                    echo ""
                    echo "💡 Tip: Use 'ip a' in terminal to find your local IP and subnet"
                    ;;
                2)
                    echo -n "Enter IP range (e.g., 192.168.1.0/24): "
                    read iprange
                    echo -e "${GREEN}Scanning network...${NC}"
                    nmap -sV -O $iprange
                    ;;
                *)
                    echo -e "${RED}Invalid selection.${NC}"
                    ;;
            esac
            ;;


        brute)
            echo -e "${CYAN}[Brute Force Attack with Hydra]${NC}"
            echo "1. What does this do? (explanation)"
            echo "2. Start brute force attack"
            read -p "Choose an option (1-2): " brute_choice

            case $brute_choice in
                1)
                    echo -e "${GREEN}[Hydra Explanation]${NC}"
                    echo ""
                    echo "What is Hydra?"
                    echo "Hydra is a popular tool used to perform brute force attacks on login services."
                    echo "It tries many password combinations to find the correct one for a given user."
                    echo ""
                    echo "Supported Protocols:"
                    echo "Common ones include: ssh, ftp, http, smb, telnet, rdp, and more."
                    echo ""
                    echo "Basic Syntax:"
                    echo "  hydra -l [username] -P [wordlist.txt] [target] [protocol]"
                    echo ""
                    echo "Example:"
                    echo "  hydra -l admin -P /usr/share/wordlists/rockyou.txt 192.168.1.10 ssh"
                    echo ""
                    echo "Explanation of the Example:"
                    echo "  - '-l admin' sets the username to try"
                    echo "  - '-P rockyou.txt' gives the password list"
                    echo "  - '192.168.1.10' is the target IP"
                    echo "  - 'ssh' tells Hydra to try SSH login"
                    echo ""
                    echo "Tip: Use good wordlists like rockyou.txt (found in Kali at /usr/share/wordlists/)"
                    ;;
                2)
                    echo -n "Target IP: "
                    read target
                    echo -n "Protocol (ssh/ftp/http): "
                    read proto
                    echo -n "Username: "
                    read user
                    echo -n "Path to password list (e.g., /usr/share/wordlists/rockyou.txt): "
                    read passlist

                    echo -e "${GREEN}Launching Hydra...${NC}"
                    hydra -l $user -P $passlist $target $proto
                    ;;
                *)
                    echo -e "${RED}Invalid selection.${NC}"
                    ;;
            esac
            ;;


        macspoof)
            echo -e "${CYAN}[MAC Address Spoofing]${NC}"

            echo "Available Network Interfaces:"
            interfaces=($(ip link show | awk -F: '$0 !~ "lo|vir|docker|^[^0-9]"{print $2}' | tr -d ' '))
            for i in "${!interfaces[@]}"; do
                echo "$((i+1)). ${interfaces[$i]}"
            done

            read -p "Select interface by number: " iface_num
            iface=${interfaces[$((iface_num-1))]}

            if [ -z "$iface" ]; then
                echo -e "${RED}Invalid selection. Try again.${NC}"
                break
            fi

            echo ""
            echo "1. What is MAC spoofing? (explanation)"
            echo "2. Spoof the MAC address now"
            read -p "Choose an option (1-2): " mac_choice

            case $mac_choice in
                1)
                    echo -e "${GREEN}[MAC Spoofing Explanation]${NC}"
                    echo ""
                    echo "What is MAC spoofing?"
                    echo "Each network card has a unique MAC address. Spoofing changes this address temporarily."
                    echo "This is useful for:"
                    echo " - Avoiding MAC-based filtering"
                    echo " - Staying anonymous on public networks"
                    echo " - Bypassing certain network restrictions"
                    echo ""
                    echo "Command Used:"
                    echo "  sudo macchanger -r [interface]"
                    echo "  This sets a random new MAC address on the selected interface."
                    ;;
                2)
                    echo -e "${GREEN}Changing MAC address of $iface...${NC}"
                    sudo ifconfig $iface down
                    sudo macchanger -r $iface
                    sudo ifconfig $iface up
                    echo -e "${CYAN}Done. Use 'ip link show $iface' to verify.${NC}"
                    ;;
                *)
                    echo -e "${RED}Invalid selection.${NC}"
                    ;;
            esac
            ;;

        portscan)
            echo -e "${CYAN}[Simple Port Scanner]${NC}"
            echo "1. What is a port scan? (explanation)"
            echo "2. Start scanning common ports"
            read -p "Choose an option (1-2): " port_choice

            case $port_choice in
                1)
                    echo -e "${GREEN}[Port Scanning Explanation]${NC}"
                    echo ""
                    echo "What is a Port Scan?"
                    echo "A port scan checks which ports on a target system are open or closed."
                    echo "Ports are like doors to services running on a machine (e.g., web server, FTP, SSH)."
                    echo ""
                    echo " Common Ports:"
                    echo "  21  = FTP"
                    echo "  22  = SSH"
                    echo "  23  = Telnet"
                    echo "  25  = SMTP"
                    echo "  53  = DNS"
                    echo "  80  = HTTP (web)"
                    echo "  110 = POP3"
                    echo "  139 = NetBIOS"
                    echo "  143 = IMAP"
                    echo "  443 = HTTPS (secure web)"
                    echo "  445 = SMB"
                    echo "  3389 = RDP (remote desktop)"
                    echo ""
                    echo "Simple scan with Bash:"
                    echo '  (echo > /dev/tcp/IP/PORT) && echo "Open" || echo "Closed"'
                    echo ""
                    echo "Example:"
                    echo "  To scan port 22 on 192.168.1.1:"
                    echo "    (echo > /dev/tcp/192.168.1.1/22) && echo 'Open' || echo 'Closed'"
                    ;;
                2)
                    echo -n "Enter target IP: "
                    read ip
                    echo "Scanning common ports on $ip..."
                    for port in 21 22 23 25 53 80 110 139 143 443 445 3389; do
                        (echo > /dev/tcp/$ip/$port) >/dev/null 2>&1 && \
                        echo -e "${GREEN}Port $port is open${NC}" || \
                        echo -e "${RED}Port $port is closed${NC}"
                    done
                    ;;
                *)
                    echo -e "${RED}Invalid selection.${NC}"
                    ;;
            esac
            ;;

        custom)
            echo -e "${CYAN}[Custom Command Launcher]${NC}"
            echo "1. What is this? (Explanation)"
            echo "2. Run a custom Linux command"
            read -p "Choose an option (1-2): " custom_choice

            case $custom_choice in
                1)
                    echo -e "${GREEN}[Explanation – Custom Commands]${NC}"
                    echo ""
                    echo "What is this tool?"
                    echo "This allows you to run **any Linux command** directly from this hacking toolbox."
                    echo ""
                    echo "Be careful with what you type. This uses the 'eval' command,"
                    echo "which means any input will be directly interpreted by the system."
                    echo ""
                    echo "Useful Example Commands:"
                    echo ""
                    echo "File and Directory Management:"
                    echo "  ls -la                 # List all files with details"
                    echo "  cd /path/to/folder     # Change directory"
                    echo "  mkdir new_folder       # Create a new folder"
                    echo "  rm file.txt            # Remove a file"
                    echo ""
                    echo "Network Information:"
                    echo "  ip a                   # Show network interfaces and IP addresses"
                    echo "  ifconfig               # Show network interfaces (older)"
                    echo "  ping -c 4 8.8.8.8      # Ping Google DNS 4 times"
                    echo "  netstat -tuln          # List open ports and listening services"
                    echo "  ss -tuln               # Newer alternative for netstat"
                    echo ""
                    echo "System Information & Monitoring:"
                    echo "  top                    # Real-time process monitor"
                    echo "  htop                   # Interactive process viewer (if installed)"
                    echo "  df -h                  # Show disk usage in human readable form"
                    echo "  free -h                # Show memory usage"
                    echo ""
                    echo "Security & Network Scanning:"
                    echo "  nmap 192.168.1.0/24    # Scan local network with Nmap"
                    echo "  tcpdump -i wlan0       # Capture packets on wlan0 (requires sudo)"
                    echo "  iwconfig               # Show wireless interface info"
                    echo ""
                    echo "Dangerous commands to AVOID:"
                    echo "  rm -rf /               # Deletes all files on root filesystem!"
                    echo "  :(){ :|:& };:          # Fork bomb that crashes the system"
                    echo "  dd if=/dev/zero of=/dev/sda # Overwrites your hard drive"
                    echo ""
                    echo " Always double-check your input before confirming."
                    ;;

                2)
                    echo -n "Enter any Linux command: "
                    read usercmd
                    echo -e "${CYAN}Running: $usercmd${NC}"
                    eval $usercmd
                    ;;
                *)
                    echo -e "${RED}Invalid selection.${NC}"
                    ;;
            esac
            ;;


sniff)
    echo -e "${CYAN}[Packet Sniffing with tcpdump]${NC}"
    echo "1. What does this do? (explanation)"
    echo "2. Start packet sniffing"
    read -p "Choose an option (1-2): " sniff_choice

    case $sniff_choice in
        1)
            echo -e "${GREEN}[tcpdump Explanation]${NC}"
            echo ""
            echo "What is tcpdump?"
            echo "tcpdump is a command-line tool that captures and displays"
            echo "network traffic on a selected interface."
            echo "It's essential for analyzing network communication, troubleshooting,"
            echo "and security monitoring."
            echo ""
            echo "Command Used:"
            echo " sudo tcpdump -i [interface]" [10]
            echo " This starts capturing packets on the specified interface."
            echo " Press CTRL+C to stop."
            echo ""
            echo "Tip: Use 'ip a' or 'ifconfig' to see your network interfaces."
            echo " Capturing often requires root privileges, so 'sudo' is needed."
            ;;
        2)
            echo -e "${CYAN}Available Network Interfaces:${NC}"
            interfaces=($(ip link show | awk -F: '$0 !~ "lo|vir|docker|^[^0-9]"{print $2}' | tr -d ' '))
            if [ ${#interfaces[@]} -eq 0 ]; then
                echo -e "${RED}No active network interfaces found.${NC}"
                break
            fi

            for i in "${!interfaces[@]}"; do
                echo "$((i+1)). ${interfaces[$i]}"
            done

            read -p "Select interface by number: " iface_num
            iface=${interfaces[$((iface_num-1))]}

            if [ -z "$iface" ]; then
                echo -e "${RED}Invalid selection. Try again.${NC}"
                break
            fi

            echo -e "${GREEN}Starting tcpdump on $iface... Press CTRL+C to stop.${NC}"
            sudo tcpdump -i "$iface"
            echo -e "${CYAN}tcpdump stopped.${NC}"
            ;;
        *)
            echo -e "${RED}Invalid selection.${NC}" [5-8, 11, 12]
            ;;
    esac
    ;;


netinfo)
    echo -e "${CYAN}[Network Information (Connections & Listeners)]${NC}"
    echo "1. What does this do? (explanation)"
    echo "2. List listening ports (netstat -tuln or ss -tuln)"
    echo "3. List all connections (netstat -a or ss -a)"
    read -p "Choose an option (1-3): " netinfo_choice

    case $netinfo_choice in
        1)
            echo -e "${GREEN}[netstat / ss Explanation]${NC}"
            echo ""
            echo "What are netstat and ss?"
            echo "These tools display network connections, routing tables,"
            echo "interface statistics, and more."
            echo "They are useful for seeing what services are running on your system"
            echo "and which connections are active or listening for traffic."
            echo ""
            echo "'netstat' is an older tool, while 'ss' is newer and often faster."
            echo ""
            echo "Common Options Used (as examples in 'custom'):"
            echo " netstat -tuln # List TCP/UDP ports that are LISTENing, numeric form"
            echo " ss -tuln # Same for ss"
            echo " netstat -a # List ALL connections and listening ports"
            echo " ss -a # Same for ss"
            ;;
        2)
            echo -e "${GREEN}Listing listening ports (TCP/UDP)...${NC}"
            if command -v ss &>/dev/null; then
                ss -tuln
            else
                netstat -tuln
            fi
            ;;
        3)
             echo -e "${GREEN}Listing all connections and listening ports...${NC}"
             if command -v ss &>/dev/null; then
                 ss -a
             else
                 netstat -a
             fi
            ;;
        *)
            echo -e "${RED}Invalid selection.${NC}" [1-3]
            ;;
    esac
    ;;



help)
    echo "Available commands:"
    echo " wifi - WiFi hacking interactive menu"
    echo " scan - Scan networks with Nmap"
    echo " brute - Brute force with Hydra"
    echo " macspoof - Change your MAC address"
    echo " portscan - Quick TCP port scan"
    echo " custom - Run a custom command"
    echo " sniff - Basic packet sniffer (tcpdump)"
    echo " netinfo - View network connections and listening ports (netstat/ss)"
    echo " exit - Exit the toolbox"
    ;;

        exit)
            echo "Exiting..."
            exit 0
            ;;

        *)
            echo -e "${RED}Unknown command. Type 'help' for options.${NC}"
            ;;
    esac
done
