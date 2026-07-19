Name:           vulners                                                         
Version:        0.1                                                             
Release:        1%{?dist}                                                       
Summary:        A tool for checking system configuration vulnerabilities        
                                                                                
License:        MIT                                                             
Source0:        %{name}-%{version}.tar.gz                                       
BuildArch:      noarch                                                          
                                                                                
%description                                                                    
VulnerS — a set of system checks for typical security issues:                   
SUID/SGID, ACL, права sudoers, capabilities, world-writable файлы и другое.     
                                                                                
%prep                                                                           
%setup -q                                                                       
                                                                                
%build                                                                          
#dont need                                                                      
                                                                                
%install                                                                        
install -Dm755 vulners %{buildroot}%{_bindir}/vulners                           
                                                                                
for f in checks/*.sh; do                                                        
    install -Dm644 "$f" %{buildroot}%{_datadir}/vulners/checks/$(basename "$f") 
done                                                                            
                                                                                
for f in lib/*.sh; do                                                           
    install -Dm644 "$f" %{buildroot}%{_datadir}/vulners/lib/$(basename "$f")    
done                                                                            
                                                                                
%files                                                                          
%license LICENSE                                                                
%doc README.md                                                                  
%{_bindir}/vulners                                                              
%{_datadir}/vulners/checks/*.sh                                                 
%{_datadir}/vulners/lib/*.sh                                                    
                                                                                
%changelog                                                                      
                                                                                
* Sun Jul 19 2026 algozak <harutyunyanvazgen10@gmail.com> - 0.1-1               
- First Release                                                                 
                                                                                




































