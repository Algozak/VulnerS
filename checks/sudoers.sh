#!/bin/bash

# Sudoers configuration                                                                       
sudoers() {                                                                                   
    echo ""                                                                                   
    echo -e "${YELLOW} [*] Analyzing sudoers misconfigurations...${NC}"                        
    echo "------------------------------------------------"                                   
     
    local tmpfile
    local sudo_errors
    tmpfile=$(mktemp)

    ( grep -r "NOPASSWD" /etc/sudoers /etc/sudoers.d/ 2>/dev/null | grep -v ":#" > "$tmpfile" ) &

    spinner $!
                                                                                              
    sudo_errors=$(cat "$tmpfile")
    rm -f "$tmpfile"

    if [ -z "$sudo_errors" ]; then                                                            
        echo -e "${GREEN}    [OK] No active NOPASSWD rules found.${NC}"
        sleep 1
    else                                                                                      
        echo -e "${RED}    [CRITICAL] Dangerous NOPASSWD rules detected!${NC}"                    
        echo "$sudo_errors"                                                                   
    fi                                                                                        
                                                                                                                                 
    echo ""                                                                                   
}                                                                                             

