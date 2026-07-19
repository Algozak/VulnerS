#!/bin/bash

 

# World-writable_files                                                                    
world_writable() {                                                                        
  echo ""                                                                                 
  echo -e "${YELLOW} [*] Scanning for world-writable files...${NC}"                       
  echo "--------------------------------------------------"                               
                                                                                          
  local tmpfile=$(mktemp)                                                                       
  find / -type f -perm -o+w 2>/dev/null | grep -v "/proc" | grep -v "/sys" | grep -v "/tmp" | grep -v "/var/tmp/" > "$tmpfile" & 
  spinner $!                                                                               
  wwf_var=$(cat "$tmpfile")                                                              
  rm -f "$tmpfile"                                                                        
                                                                                          
  if [ -z "$wwf_var" ]; then                                                             
    echo -e "${GREEN}    [OK] No vulnerabilities found. ${NC}"                               
  else                                                                                    
    echo -e "${RED}    [CRITICAL] World-writable files found. \n${NC}"                         
    echo "$wwf_var"
    ((WARNING_COUNT++))
    sleep 0.8
  fi                                                                                      
                                                                                          
                                                                                          
}                                                                                         

