#!/bin/bash



# Search SUID files                                                       
search_suid() {                                                           
  echo ""                                                                 
  echo -e "${YELLOW} [*] Scanning for dangerous SUID binaries...${NC}"    
  echo "--------------------------------------------------"               
                                                                          
                                                                          
  local suid_var                                                          
  suid_var=$(find / -type f -perm -4000 2> /dev/null | grep -v "/proc") & 
                                                                          
  spinner $!                                                              
                                                                          
  if [ -z "$suid_var" ]; then                                             
    echo -e "${GREEN}    [OK] No vulnerabilities found. ${NC}"               
  else                                                                    
    echo -e "${RED}    [CRITICAL] Vulnerable files with SUID found. ${NC}"   
    echo "$suid_var"                                                      
  fi                                                                      
                                                                          
                                                                          
}                                                                         

