#####
####  UFW Setup Guide
#####

### Install UFW

```bash
sudo apt-get update
sudo apt-get install -y ufw
```

### Enable UFW

```bash
sudo ufw enable
```

### Allow SSH Connections

```bash
sudo ufw allow ssh
```

### Allow Specific Ports

#### Example: Allow HTTP and HTTPS traffic

```bash
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
```

#### Example: Allow a custom port

```bash
sudo ufw allow 8080/tcp
```

#### Example: Allow traffic from a specific IP to a specific port

```bash
sudo ufw allow from 192.168.1.2 to any port 22
```

### Deny Incoming Traffic (Default Policy)

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
```

### View UFW Rules

#### View rules with numbers

```bash
sudo ufw status numbered
```

### Delete UFW Rules

#### Example: Remove rule for port 8080

```bash
sudo ufw delete allow 8080/tcp
```

#### Example: Delete a rule by number

```bash
sudo ufw delete <rule-number>
```

### Reference

- [UFW Documentation](https://help.ubuntu.com/community/UFW)
- [Firewall Best Practices](https://ubuntu.com/server/docs/security-firewall)
