#!/bin/bash

#ACL check
acl_check() {
  echo ""                                                                                  
  echo -e "${YELLOW} [*] Scanning for Extended ACLs...${NC}"                        
  echo "--------------------------------------------------"

  local tmpfile=$(mktemp)

  getfacl -Rsp / 2>/dev/null > "$tmpfile" &
  spinner $!

  if [ -s "$tmpfile" ]; then
    echo -e "${GREEN} [OK] No vulnerabilities found. ${NC}" 
  else
    echo -e "${RED} [CRITICAL] Extended ACLs found.${NC}"
    acl_info=$(grep "^# file:" "$tmpfile" | sed 's/# file: //')
    echo "$acl_info"
  fi

  rm -f "$tmpfile"
  echo "--------------------------------------------------" 

}

