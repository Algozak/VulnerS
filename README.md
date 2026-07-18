# VulnerS

A minimalistic Bash tool for basic local Linux security auditing.
Checks the system for dangerous SUID/SGID files, world-writable files,
empty passwords, misconfigured sudoers, dangerous capabilities, and more.

## Checks performed

- SUID / SGID binaries
- World-writable files and directories
- Sticky bit on `/tmp`-like directories
- File ACLs
- Writable systemd unit files
- Dangerous Linux capabilities
- Empty password accounts
- Sudoers misconfiguration
- ExecStart permissions in systemd services

## Installation

Download the latest `.rpm` package from the [Releases](https://github.com/AlgoZak/VulnerS/releases) page and install it:

```bash
sudo dnf install vulners-1.*.noarch.rpm
```

## Usage

```bash
sudo vulners        # Quick start of the audit
sudo vulners -l      # Background audit with entry in /var/log/vulners.log
sudo vulners -h      # Calling Help
```

## Uninstallation

```bash
sudo dnf remove vulners
```

## Building from source

If you want to build the RPM package yourself instead of using a prebuilt release:

\`\`\`
git clone https://github.com/AlgoZak/VulnerS.git
cd VulnerS
./build.sh
\`\`\`

The resulting package will be in `~/rpmbuild/RPMS/noarch/`.

## License

See [LICENSE](LICENSE).




























