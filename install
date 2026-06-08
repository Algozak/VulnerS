#!/bin/bash

spiner() {
  local pid=$1
  local spin='-\|/'
  local i=0

  while kill -0 "$pid" 2>/dev/null; do
    i=$(( (i+1) % 4 ))
    printf "\r[%c] Scanning system, please wait..." "${spin:$i:1}"
    sleep 0.1
  done

}



if [ "$1" == "--uninstall" ]; then
  if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}[-] Error: Please run with sudo${NC}"
    exit 1
  fi
  echo -e "${YELLOW}[*] Removing VulnerS from the system...${NC}"
  sleep 1
  rm -f /usr/local/bin/vulners
  echo -e "${GREEN}[+] VulnerS has been successfully removed.${NC}"
  exit 0
fi



GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}[*] Preparing to install VulnerS auditor...${NC}"
sleep 1


if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}[-] Error: Please run install.sh with sudo (sudo ./install.sh)${NC}"
  exit 1
fi

if [ ! -f "vulners" ]; then
  echo -e "${RED}[-] Error: Source file 'vulners' not found in the current directory.${NC}"
  echo -e "${YELLOW}[*] Make sure you run this script from the repository root.${NC}"
  exit 1
fi

echo -e "${YELLOW}[*] Copying 'vulners' to /usr/local/bin/...${NC}"

cp vulners /usr/local/bin/vulners &
sleep 2



echo "------------------------------------------------"
echo -e "${GREEN}[+] VulnerS successfully installed!${NC}"
sleep 1
echo -e "${GREEN}[+] Now you can run it from anywhere using:${NC} sudo vulners"
echo "------------------------------------------------"



