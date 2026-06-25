#!/bin/bash

source lib/spinner.sh 

# World-writable_files                                                                    
world_writable() {                                                                        
  echo ""                                                                                 
  echo -e "${YELLOW} [*] Scanning for world-writable files...${NC}"                       
  echo "--------------------------------------------------"                               
                                                                                          
  tmpfile=$(mktemp)                                                                       
  find / -type f -perm -o+w 2>/dev/null | grep -v "/proc" | grep -v "/sys" > "$tmpfile" & 
  spinner $!                                                                               
  suid_var=$(cat "$tmpfile")                                                              
  rm -f "$tmpfile"                                                                        
                                                                                          
  if [ -z "$suid_var" ]; then                                                             
    echo -e "${GREEN} [OK] No vulnerabilities found. ${NC}"                               
  else                                                                                    
    echo -e "${RED} [CRITICAL] World-writable files found. ${NC}"                         
    echo "$suid_var"                                                                      
  fi                                                                                      
                                                                                          
  echo "--------------------------------------------------"                               
                                                                                          
}                                                                                         

