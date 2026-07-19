#!/bin/bash

#check sticky /tmp                                                     
echo_sticky_tmp() {                                                    
  echo ""                                                              
  echo -e "${YELLOW} [*] Checking sticky bit in /tmp...${NC}"          
  echo "--------------------------------------------------"            
  sticky_info=$(ls -ld /tmp | awk '{print substr($1,length($1)-1,1)}')

  if [[ "$sticky_info" == "t" || "$sticky_info" == "T" ]]; then        
    echo -e "${GREEN}\n    [OK] No vulnerabilities found.  ${NC}"           
    sleep 1 
  else                                                                 
    echo -e "${RED}    sticky bit is missing on /tmp${NC}"                 
    ((WARNING_COUNT++))
  fi                                                                   
}                                                                      

