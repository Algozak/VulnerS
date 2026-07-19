#!/bin/bash

                                                                           
                                                                                                 
# Writable-units                                                                            
writable-units() {                                                                               
  echo ""                                                                                        
  echo -e "${YELLOW} [*] Scanning for writable-units files...${NC}"                              
  echo "--------------------------------------------------"                                      
                                                                                                 
  local tmpfile=$(mktemp)                                                                        
  find /etc/systemd/system -type f \( -perm -o+w -o -perm -g+w \) > $tmpfile &        
  spinner $!                                                                                     
  wu_var=$(cat "$tmpfile")                                                                      
  rm -f "$tmpfile"                                                                               
                                                                                                 
  if [ -z "$wu_var" ]; then                                                                     
    echo -e "${GREEN}    [OK] No vulnerabilities found. ${NC}"                                   
  else                                                                                           
    echo -e "${RED}    [CRITICAL] Writable unit files found. \n${NC}"                             
    echo "$wu_var" | while read -r line; do
    echo "----- $line"
    done                                                                            
    ((CRITICAL++))
    sleep 0.8                                                                                    
  fi                                                                                             
                                                                                                 
                                                                                                 
}                                                                                                


