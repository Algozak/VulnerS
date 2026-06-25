#!/bin/bash

# Sudoers configuration                                                                       
sudoers() {                                                                                   
    echo ""                                                                                   
    echo -e "${YELLOW}[*] Analyzing sudoers misconfigurations...${NC}"                        
    echo "------------------------------------------------"                                   
                                                                                              
    local sudo_errors                                                                         
    sudo_errors=$(grep -r "NOPASSWD" /etc/sudoers /etc/sudoers.d/ 2>/dev/null | grep -v ":#") 
                                                                                              
    if [ -z "$sudo_errors" ]; then                                                            
        echo -e "${GREEN}[OK] No active NOPASSWD rules found. System is safe.${NC}"           
    else                                                                                      
        echo -e "${RED}[CRITICAL] Dangerous NOPASSWD rules detected!${NC}"                    
        echo "$sudo_errors"                                                                   
    fi                                                                                        
                                                                                              
    echo "------------------------------------------------"                                   
    echo ""                                                                                   
}                                                                                             

