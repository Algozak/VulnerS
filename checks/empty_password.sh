#!/bin/bash

# Check for empty password                                                
empty_password() {                                                        
  echo ""                                                                 
  echo -e "${YELLOW} [*] Checking /etc/shadow for empty password...${NC}" 
  echo "--------------------------------------------------"               
                                                                          
  local empass_var                                                        
  empass_var=$(awk -F: '$2 == "" { print $1 }' /etc/shadow)               
                                                                          
  if [ -z "$empass_var" ]; then                                           
    echo -e "${GREEN} [OK] No vulnerabilities found. ${NC}"               
  else                                                                    
    echo -e "${RED} [CRITICAL] Empty passwords found. ${NC}"              
    echo "$empass_var"                                                    
  fi                                                                      
                                                                          
  echo "--------------------------------------------------"               
}                                                                         

