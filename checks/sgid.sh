#!/bin/bash                                                                
                                                                                                                           
 count_files=0
                                                                          
# Search SUID files                                                        
search_sgid() {                                                            
  echo ""                                                                  
  echo -e "${YELLOW} [*] Scanning for dangerous SGID binaries...${NC}"     
  echo "--------------------------------------------------"                

  
  local whitelist=(
    "/usr/bin/lockdev"
    "/usr/bin/plocate"
    "/usr/libexec/utempter/utempter"
  )

  local tmpfile
  tmpfile=$(mktemp)
  local sgid_var          

  ( find / -type f -perm -2000 2> /dev/null | grep -v "/proc" > "$tmpfile") &  
                                                                           
  spinner $!                                                             

  sgid_var=$(comm -23 <(sort "$tmpfile") <(printf '%s\n' "${whitelist[@]}" | sort))
  rm -f "$tmpfile"              

  if [ -z "$sgid_var" ]; then                                              
    echo -e "${GREEN}    [OK] No vulnerabilities found. ${NC}"                
  else                                                                     
    echo -e "${RED}    [CRITICAL] Vulnerable files with SGID found. ${NC}"    
    echo "$sgid_var"
    ((WARNING_COUNT++))
    count_files=$(wc -l <<< "$sgid_var")
    coef=$(awk "BEGIN {print the_min = ($count_files/10 < 1) ? $count_files/10 : 1}")
    COEF["sgid"]=$coef
    
  fi                                                                       
                                                                           
                                                                           
}                                                                          



