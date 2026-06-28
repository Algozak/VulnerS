#!/bin/bash

# Loading Animation                                                
spinner() {                                                        
  local pid=$1                                                     
  local spin='-\|/'                                                
  local i=0                                                        
                                                                   
  while kill -0 "$pid" 2>/dev/null; do                             
    i=$(( (i+1) % 4 ))                                             
    printf "\r    [%c] Scanning system, please wait..." "${spin:$i:1}" 
    sleep 0.1                                                      
    printf "\r\033[K" ""
  done                                                             
                                                                   
  printf "                      \n"                                
}                                                                  

