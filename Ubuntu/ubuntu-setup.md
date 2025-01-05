# Ubuntu Server Setup Guide

## UPDATE

```bash
# Update package lists and upgrade all packages
apt update
apt list --upgradable
apt upgrade -y

# Perform a full upgrade and remove unnecessary packages
apt full-upgrade -y
apt autoremove -y
```

## PROGRAMMS

```bash
# Install common text editors and Midnight Commander
apt install -y mc vim nano

# Fix syntax highlighting for unknown file types in Midnight Commander
cp /usr/share/mc/syntax/sh.syntax /usr/share/mc/syntax/unknown.syntax
```

## SSH connection

```bash
# Edit the SSH configuration to change the port
nano /etc/ssh/sshd_config
# Example change: Set "Port 22678" in the configuration file

# Restart the SSH service to apply changes
service sshd restart
```

## FIREWALL

```bash
# Install UFW (Uncomplicated Firewall) and enable it
apt install -y ufw
systemctl enable ufw

# Allow SSH connections from a specific IP and port
ufw allow from 192.168.1.2 to any port 22678

# Enable the firewall
ufw enable
```

## HISTORY

```bash
# Customize bash history settings
vim ~/.bashrc

# Add the following lines to the file:
# export HISTSIZE=10000
# export HISTTIMEFORMAT="%h %d %H:%M:%S "
# PROMPT_COMMAND='history -a'
# export HISTIGNORE="ls:ll:history:w:htop"

# Reload bash configuration to apply changes
source ~/.bashrc
```

## TOOLS

```bash
# Install additional utilities and tools
apt install -y wget bzip2 traceroute gdisk tree
apt install -y net-tools iftop htop inetutils-ping
apt install -y open-vm-tools
```

## REFERENCE

### Sources
- [Debian Server Setup Guide](https://serveradmin.ru/debian-nastroyka-servera/)
- [Official UFW Documentation](https://help.ubuntu.com/community/UFW)
- [Midnight Commander Syntax Fix](https://midnight-commander.org/)
- [Bash History Customization](https://bash.cyberciti.biz/guide/Setting_up_the_history_command)
- [Cowsay and Fortune Documentation](https://en.wikipedia.org/wiki/Cowsay)
