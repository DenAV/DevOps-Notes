# DevOps-Notes

Documentation and scripts for setting up and managing Linux and Windows servers. Organized by OS, security, and tools.

## Structure

### CentOS

- **[centos-setup.md](./Centos/centos-setup.md):** Guide to setting up CentOS servers.
- **[centos-troubleshooting.md](./Centos/centos-troubleshooting.md):** Troubleshooting common issues in CentOS.
- **[IPtables.sh](./Centos/IPtables.sh):** Script to configure iptables firewall on CentOS.

### Ubuntu

- **[ubuntu-setup.md](./Ubuntu/ubuntu-setup.md):** Guide to setting up Ubuntu servers.
- **[docker-install.md](./Ubuntu/docker-install.md):** Instructions for installing Docker on Ubuntu.

### Security

- **[fail2ban-setup.md](./Security/fail2ban-setup.md):** Instructions for setting up Fail2ban for intrusion prevention.
- **[ufw-setup.md](./Security/ufw-setup.md):** Guide to configuring UFW (Uncomplicated Firewall).

### Tools

- **[git-setup.md](./Tools/git-setup.md):** Guide to installing and using Git on CentOS and Ubuntu.
- **[openssl-setup.md](./Tools/openssl-setup.md):** Guide to installing OpenSSL, configuring it, and exploring its capabilities.
- **[PlantUML](./Tools/plantuml.md):** Guide to using PlantUML.

### Windows

- **[Setup-BgInfo](./Windows/PowerShell/Deployment/Setup-BgInfo/):** BgInfo deployment scripts for Windows Server.
- **[Windows Server 2022 Security Baseline](./Windows/PowerShell/Deployment/setup-gpo-local-baseline/):** GPO security baseline configuration for Windows Server 2022.

## Purpose

This repository serves as a comprehensive reference for system administrators to efficiently set up and maintain Linux and Windows systems. It includes best practices, essential tools, and troubleshooting steps.

## Requirements

- Tested on Ubuntu 20.04/22.04, CentOS 7/8, and Windows Server 2022
- Tools: bash, sudo, git, PowerShell
- Optional tools referenced in guides: Docker, Fail2ban, UFW, OpenSSL, PlantUML

## Quick Start

```bash
git clone https://github.com/DenAV/DevOps-Notes.git
cd DevOps-Notes
```

- Browse docs in `Centos/`, `Ubuntu/`, `Security/`, `Tools/`, `Windows/`.
- Example (CentOS firewall): back up rules, then run the script carefully:

```bash
sudo iptables-save > iptables-backup-$(date +%F).rules
sudo bash Centos/IPtables.sh
```

- Docker on Ubuntu: see `Ubuntu/docker-install.md`.

## Contributions

Contributions are welcome! Feel free to submit pull requests with additional guides or improvements.

## License

This repository is licensed under the [MIT License](./LICENSE).

