#!/bin/bash                                                                
                                                                           
                                                  
                                                                           
# Search SUID files                                                        
search_sgid() {                                                            
  echo ""                                                                  
  echo -e "${YELLOW} [*] Scanning for dangerous SGID binaries...${NC}"     
  echo "--------------------------------------------------"                
                                                                           
  local tmpfile
  tmpfile=$(mktemp)
  local sgid_var          

  ( find / -type f -perm -2000 2> /dev/null | grep -v "/proc" > "$tmpfile") &  
                                                                           
  spinner $!                                                             

  sgid_var=$(cat "$tmpfile")
  rm -f "$tmpfile"
                                                                           
  if [ -z "$sgid_var" ]; then                                              
    echo -e "${GREEN}    [OK] No vulnerabilities found. ${NC}"                
  else                                                                     
    echo -e "${RED}    [CRITICAL] Vulnerable files with SGID found. ${NC}"    
    echo "$sgid_var"                                                       
  fi                                                                       
                                                                           
                                                                           
}                                                                          



