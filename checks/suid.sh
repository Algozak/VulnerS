#!/bin/bash



# Search SUID files                                                       
search_suid() {                                                           
  echo ""                                                                 
  echo -e "${YELLOW} [*] Scanning for dangerous SUID binaries...${NC}"    
  echo "--------------------------------------------------"               
                                                                          
  local tmpfile                                                                        
  local suid_var 
  tmpfile=$(mktemp)
  
  ( find / -type f -perm -4000 2> /dev/null | grep -v "/proc" > "$tmpfile" ) & 
                                                                          
  spinner $!               

  suid_var=$(cat "$tmpfile")
  rm -f "$tmpfile"
                                                                        
  if [ -z "$suid_var" ]; then                                             
    echo -e "${GREEN}    [OK] No vulnerabilities found. ${NC}"               
  else                                                                    
    echo -e "${RED}    [CRITICAL] Vulnerable files with SUID found. \n ${NC}"   
    echo "$suid_var"                                                      
  fi                                                                      
                                                                          
                       
}                                                                         

