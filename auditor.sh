#!/bin/bash

# Colors ANSI codes
NC="\033[0m"
YELLOW="\x1b[33m"
RED="\x1b[31m"
GREEN="\033[32m"

# Search SUID files
echo -e "${YELLOW} [*] Scanning for dangerous SUID binaries...${NC}"
search-suid() {
  find / -type f -perm -4000 2> /dev/null | grep -v "/proc"
}
search_res=$(search-suid)

# World-writable_files
echo -e "${YELLOW} [*] Scanning for world-writable files...${NC}"
world-writable() {
  find / -type f -perm -0002 2> /dev/null | grep -v "/proc"
}
world_writable_res=$(world-writable)

# Check for empty password
echo -e "${YELLOW} [*] Checing /etc/shadow for empty password...${NC}"
empty-password() {
  awk -F: '$2 == "" { print $1 }' /etc/shadow
}
empty_password_res=$(empty-password)

# Sudoers configuration
sudoers() {
  sudo grep -r "NOPASSWD" /etc/sudoers /etc/sudoers.d/ 2> /dev/null | grep -v "^#"
}
sudoers_res=$(sudoers)

# Check root
check-root() {
    if [ "$EUID" -ne 0 ]; then
        echo -e "${RED}[-] Error: This script must be run as root!${NC}"
        exit 1
    fi
}
check_root_res=$(check-root)


