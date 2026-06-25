# VulnerS

A minimalistic Bash tool for basic local Linux security auditing.
Checks the system for dangerous SUID files, access rights (world-writable), empty passwords, etc.

## Using

```bash
sudo vulners        # Quick start of the audit
sudo vulners -l     # Background audit with entry in /var/log/vulners.log
sudo vulners -h     # Calling Help
```
## Installation

Clone the repository and run the installation script:

```bash
git clone https://github.com/AlgoZak/VulnerS.git
cd VulnerS
chmod +x install
sudo ./install.sh
```
## Uninstallation

To completely remove the utility from the system, run the same script with the delete flag.:

```bash
sudo ./install.sh --uninstall
```
