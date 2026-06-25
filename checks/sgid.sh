#!/bin/bash                                                                
                                                                           
source lib/spinner.sh                                                      
                                                                           
# Search SUID files                                                        
search_sgid() {                                                            
  echo ""                                                                  
  echo -e "${YELLOW} [*] Scanning for dangerous SGID binaries...${NC}"     
  echo "--------------------------------------------------"                
                                                                           
                                                                           
  local suid_var                                                           
  suid_var=$(find / -type f -perm -2000 2> /dev/null | grep -v "/proc") &  
                                                                           
  spinner $!                                                               
                                                                           
  if [ -z "$suid_var" ]; then                                              
    echo -e "${GREEN} [OK] No vulnerabilities found. ${NC}"                
  else                                                                     
    echo -e "${RED} [CRITICAL] Vulnerable files with SGID found. ${NC}"    
    echo "$suid_var"                                                       
  fi                                                                       
                                                                           
  echo "--------------------------------------------------"                
                                                                           
}                                                                          



