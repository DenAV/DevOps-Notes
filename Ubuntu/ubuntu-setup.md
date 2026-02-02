# Ubuntu Server Setup Guide

## UPDATE

```bash
# Update package lists and upgrade all packages
sudo apt update
```

```bash
sudo apt list --upgradable
```

```bash
sudo apt upgrade -y
```

```bash
# Perform a full upgrade and remove unnecessary packages
sudo apt full-upgrade -y
```

```bash
sudo apt autoremove -y
```

## PROGRAMMS

```bash
# Install common text editors and Midnight Commander
sudo apt install -y mc vim nano

# Fix syntax highlighting for unknown file types in Midnight Commander
sudo cp /usr/share/mc/syntax/sh.syntax /usr/share/mc/syntax/unknown.syntax
```

## SSH connection

```bash
# Edit the SSH configuration to change the port
sudo nano /etc/ssh/sshd_config
# Example change: Set "Port 22678" in the configuration file
```

```bash
# Restart the SSH service to apply changes
sudo service sshd restart
```

## FIREWALL

```bash
# Install UFW (Uncomplicated Firewall) and enable it
sudo apt install -y ufw
sudo systemctl enable ufw
```

```bash
# Allow SSH connections from a specific IP and port
sudo ufw allow from 192.168.1.2 to any port 22678
```

```bash
# Enable the firewall
sudo ufw enable
```

## HISTORY

Customize bash history settings

```bash
nano ~/.bashrc
```

Add the following lines to the file:

```bash
export HISTSIZE=10000
export HISTTIMEFORMAT="%h %d %H:%M:%S "
PROMPT_COMMAND='history -a'
export HISTIGNORE="ls:ll:history:w:htop"
```

Reload bash configuration to apply changes

```bash
source ~/.bashrc
```

## TOOLS

```bash
# Install additional utilities and tools
sudo apt install -y wget bzip2 traceroute gdisk tree
sudo apt install -y net-tools iftop htop inetutils-ping
sudo apt install -y open-vm-tools
```

## REFERENCE

### Sources
- [Debian Server Setup Guide](https://serveradmin.ru/debian-nastroyka-servera/)
- [Official UFW Documentation](https://help.ubuntu.com/community/UFW)
- [Midnight Commander Syntax Fix](https://midnight-commander.org/)
- [Bash History Customization](https://bash.cyberciti.biz/guide/Setting_up_the_history_command)
- [Cowsay and Fortune Documentation](https://en.wikipedia.org/wiki/Cowsay)
