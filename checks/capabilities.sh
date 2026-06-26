#!/bin/bash

#Dangerous Capabilities list                                                                       
DANGEROUS_CAPS="cap_sys_admin|cap_sys_ptrace|cap_sys_module|cap_dac_override|cap_chown|cap_fowner" 

#check Dangerous Capabilities                                       
check_capabilities() {                                              
  echo ""                                                           
  echo -e "${YELLOW} [*] Checking Dangerous Capabilities...${NC}"   
  echo "--------------------------------------------------"         
                                                                    
  tmpfile=$(mktemp)                                                 
  getcap -r / 2>/dev/null > "$tmpfile" &                            
  spinner $!                                                        
  all_cap=$(cat "$tmpfile")                                         
  rm -f "$tmpfile"                                                  
  cap_res=$(echo "$all_cap" | grep -E "$DANGEROUS_CAPS")            
  if [ -z "$cap_res" ]; then                                        
    echo -e "${GREEN}    [OK] No vulnerabilities found. ${NC}"          
  else                                                              
    echo -e "${RED}    [CRITICAL] Dangerous capabilities found. ${NC} " 
    echo "$cap_res"                                                 
  fi                                                                
  echo ""                                                           
}                                                                   

