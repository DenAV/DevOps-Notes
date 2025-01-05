# CentOS Server Setup Guide

### 1. Update the System

```bash
# Update all packages
sudo dnf update
```

### 2. Install Basic Utilities

```bash
# Install Midnight Commander and Vim
sudo dnf install -y mc vim

# Fix syntax highlighting for unknown file types in Midnight Commander
sudo cp /usr/share/mc/syntax/sh.syntax /usr/share/mc/syntax/unknown.syntax
```

### 3. Disable SELinux

Edit the SELinux configuration file:

```bash
sudo vim /etc/sysconfig/selinux
```

Change the following line:

```plaintext
SELINUX=disabled
```

Temporarily disable SELinux:

```bash
sudo setenforce 0
```

### 4. Configure Firewall

Stop and disable the default firewall service:

```bash
sudo systemctl stop firewalld
sudo systemctl disable firewalld
```

Install and enable iptables:

```bash
sudo dnf install -y iptables-services
sudo systemctl enable iptables
```

Create a custom iptables configuration file:

```bash
sudo vim /etc/iptables.sh
```

Set permissions and apply the configuration:

```bash
sudo chmod 0740 /etc/iptables.sh
sudo /etc/iptables.sh
```

View the current iptables rules:

```bash
sudo iptables -L -v -n
```

### 5. Enable Additional Repositories

```bash
# Enable EPEL repository
sudo dnf install -y epel-release

# Add Remi repository
sudo rpm -Uhv https://rpms.remirepo.net/enterprise/remi-release-8.rpm
```

### 6. Customize Command History

Edit the `.bashrc` file to configure command history settings:

```bash
vim ~/.bashrc
```

Add the following lines:

```bash
HISTSIZE=10000
HISTTIMEFORMAT="%h %d %H:%M:%S "
PROMPT_COMMAND='history -a'
HISTIGNORE="ls:ll:history:w:htop"
```

Reload the `.bashrc` file to apply changes:

```bash
source ~/.bashrc
```

### 7. Install Additional Tools

```bash
# Install commonly used tools and utilities
sudo dnf install -y wget bzip2 traceroute gdisk tree
sudo dnf install -y net-tools bind-utils iftop htop atop
```

### 8. Configure SSH Keys

```bash
# Create the .ssh directory and set appropriate permissions
mkdir ~/.ssh
chmod 0700 ~/.ssh

# Create the authorized_keys file and set appropriate permissions
touch ~/.ssh/authorized_keys
chmod 0644 ~/.ssh/authorized_keys
```

### Reference

- [CentOS Server Setup Guide](https://serveradmin.ru/centos-nastroyka-servera/)
- [SELinux Documentation](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/using_selinux/)
- [Iptables Documentation](https://wiki.centos.org/HowTos/Network/IPTables)
- [Best Practices for CentOS](https://wiki.centos.org/HowTos)
- [CentOS Security Best Practices](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/security_hardening/)
