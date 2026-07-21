#!/bin/bash

count_files=0

#EcexStart check in units                                                                                  
execstart() {
  echo ""
  echo -e "${YELLOW} [*] Scanning for ExecStart in units...${NC}"
  echo "--------------------------------------------------"

  local found_vuln=0

  while read -r line; do
    cmd_payload=$(echo "$line" | cut -d= -f2-)
    for word in $cmd_payload; do
      if [[ "$word" == /* ]] && [ -f "$word" ]; then
        
        owner=$(stat -L -c "%U" "$word")  
        perms=$(stat -L -c "%a" "$word")
        
        if [ "$owner" != "root" ] || echo "$perms" | grep -q '[2367]$'; then
          echo -e "${RED}    [CRITICAL] Service uses vulnerable file (writable!):${NC}"
          echo -e "\n    --- $word\n"
          echo -e "    owner -> $owner , perms -> $perms"
          found_vuln=1
          ((CRITICAL_COUNT++))
          COEF["exec"]=1
        fi
      fi
    done
  done < <(grep -rh "^ExecStart=" /etc/systemd/system)

  if [ "$found_vuln" -eq 0 ]; then
    echo -e "${GREEN}\n    [OK] No vulnerabilities found.\n${NC}"
  fi
}




