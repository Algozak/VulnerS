#!/bin/bash

# Check for empty password                                                
empty_password() {                                                        
  echo ""                                                                 
  echo -e "${YELLOW} [*] Checking /etc/shadow for empty password...${NC}" 
  echo "--------------------------------------------------"               
                   
  local tmpfile
  local empass_var
  tmpfile=$(mktemp)
  ( awk -F: '$2 == "" { print $1 }' /etc/shadow ) &

  spinner $!
                                                   
  empass_var=$(cat "$tmpfile")
  rm -f "$tmpfile"

  if [ -z "$empass_var" ]; then                                           
    echo -e "${GREEN}    [OK] No vulnerabilities found. ${NC}"               
    sleep 1
  else                                                                    
    echo -e "${RED}    [CRITICAL] Empty passwords found. ${NC}"              
    echo "$empass_var"                                                    
  fi                                                                      
                                                                          
}                                                                         

