#!/bin/bash


#safe vars
count_files=0
coef=0

#world-writable-without sticky bit 
wwwsticky() {
  echo ""
  echo -e "${YELLOW} [*] Scanning for world-writable dirs without sticky bit...${NC}"
  echo "--------------------------------------------------" 
  
  local tmpfile=$(mktemp)
  find / -type d -perm -0002 ! -perm -1000 2>/dev/null > "$tmpfile" &
  spinner $!
  www_var=$(cat "$tmpfile")
  rm -f "$tmpfile"

  if [ -z "$www_var" ]; then
    echo -e "${GREEN}    [OK] No vulnerabilities found. ${NC}" 
  else
    echo -e "${RED}    [CRITICAL] world-writable dirs without sticky bit found. ${NC}"
    echo "$www_var"
    ((WARNING_COUNT++))
    count_files=$(wc -l <<< "$www_var")
    coef=$(awk "BEGIN {print the_min = ($count_files/20 < 1) ? $count_files/20 : 1}")
    COEF["wwwsticky"]=$coef
  fi
} 
