#!/bin/bash


#EcexStart check in units                                                                                  
execstart() {
  echo ""
  echo -e "${YELLOW} [*] Scanning for ExecStart in units...${NC}"
  echo "--------------------------------------------------"

  local found_vuln=0

  while read -r line; do
    cmd_payload=$(echo "$line" | cut -d= -f2-)
    for word in $cmd_payload; do
      if [[ "$word" == /* ]] && [ -f "$word" ] && [ -w "$word" ]; then
        echo -e "${RED}    [CRITICAL] Service uses vulnerable file (writable!):${NC}"
        echo -e "\n    --- $word\n"
        found_vuln=1
      fi
    done
  done < <(grep -rh "^ExecStart=" /etc/systemd/system)

  if [ "$found_vuln" -eq 0 ]; then
    echo -e "${GREEN}    [OK] No vulnerabilities found.\n${NC}"
  fi
}


