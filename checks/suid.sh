#!/bin/bash


count_files=0
coef=0
# Search SUID files                                                       
search_suid() {                                                           
  echo ""                                                                 
  echo -e "${YELLOW} [*] Scanning for dangerous SUID binaries...${NC}"    
  echo "--------------------------------------------------"               
   
  local whitelist=(
    "/usr/bin/at"
    "/usr/bin/crontab"
    "/usr/bin/fusermount"
    "/usr/bin/fusermount3"
    "/usr/bin/pam_timestamp_check"
    "/usr/bin/pkexec"
    "/usr/bin/unix_chkpwd"
    "/usr/bin/userhelper"
    "/usr/bin/chage"
    "/usr/bin/gpasswd"
    "/usr/bin/newgrp"
    "/usr/bin/passwd"
    "/usr/bin/sudo"
    "/usr/bin/vmware-user-suid-wrapper"
    "/usr/bin/grub2-set-bootflag"
    "/usr/bin/fusermount-glusterfs"
    "/usr/bin/mount.nfs"
    "/usr/bin/mount"
    "/usr/bin/umount"
    "/usr/bin/chfn"
    "/usr/bin/chsh"
    "/usr/bin/su"
    "/usr/lib/polkit-1/polkit-agent-helper-1"
    "/usr/lib/virtualbox/VBoxHeadless"
    "/usr/lib/virtualbox/VBoxNetAdpCtl"
    "/usr/lib/virtualbox/VBoxNetDHCP"
    "/usr/lib/virtualbox/VBoxNetNAT"
    "/usr/lib/virtualbox/VBoxVolInfo"
    "/usr/lib/virtualbox/VirtualBoxVM"
    "/usr/lib64/cef/chrome-sandbox"
    "/usr/libexec/dbus-1/dbus-daemon-launch-helper"
    "/usr/libexec/spice-gtk-x86_64/spice-client-glib-usb-acl-helper"
    "/usr/libexec/libgtop_server2"
    "/usr/libexec/qemu-bridge-helper"
  )

  local tmpfile                                                                        
  local suid_var 
  tmpfile=$(mktemp)
  
  ( find / -type f -perm -4000 2> /dev/null | grep -v "/proc" > "$tmpfile" ) & 
                                                                          
  spinner $!               

  suid_var=$(comm -23 <(sort "$tmpfile") <(printf '%s\n' "${whitelist[@]}" | sort))
  rm -f "$tmpfile"
                                                                        
  if [ -z "$suid_var" ]; then                                             
    echo -e "${GREEN}    [OK] No vulnerabilities found. ${NC}"               
  else                                                                    
    echo -e "${RED}    [CRITICAL] Vulnerable files with SUID found. \n ${NC}"   
    echo "$suid_var"
    ((CRITICAL_COUNT++))
    count_files=$(wc -l <<< "$suid_var")
    coef=$(awk "BEGIN {print the_min = ($count_files/20 < 1) ? $count_files/20 : 1}") 
    COEF["suid"]=$coef
    
    

  fi                                                                      
                                                                          
                       
}                                                                         

