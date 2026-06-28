#!/bin/bash


#EcexStart check in units                                                                                  
execstart() {                                                                               
  echo ""                                                                                   
  echo -e "${YELLOW} [*] Scanning for ExecStart in units...${NC}"                                
  echo "--------------------------------------------------"                                 
                                                                                            
  local tmpfile=$(mktemp)                                                                   
  (                                                                                          
  grep -rh "^ExecStart=" /etc/systemd/system | while read -r line; do
    cmd_payload=$(echo "$line" | cut -d= -f2-)
    for word in "$cmd_payload"; do
      if [[ "$word" == /* ]] && [ -f "$word" ]; then
        if [ -w "$word" ]; then
          echo -e "${RED}    [CRITICAL] Service use vulnerable file:(Availabe for writing!)${NC}" 
          echo -e "\n    --- $word\n"
          sleep 1  
        else
          echo -e "${GREEN}    [OK] No vulnerabilities found."
          sleep 1  
        fi
      fi
    done
  done 
  ) 
}


