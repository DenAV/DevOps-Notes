#  Docker Installation Guide

## Uninstall old versions

```bash
# Remove older versions of Docker if they exist
sudo apt-get remove docker docker-engine docker.io containerd runc
```

## Install using the repository

#### 1. Update the apt package index and install packages to allow apt to use a repository over HTTPS:

```bash
# Update the package index and install prerequisites for Docker
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release
```

#### 2. Add Docker’s official GPG key:

```bash
# Add the official Docker GPG key for package verification
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```

#### 3. Set up the stable repository:

```bash
# Add the Docker stable repository to the sources list
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

## Install Docker Engine

#### 1. Update the apt package index and install Docker:

```bash
# Install the latest version of Docker Engine and related components
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker
```

## Install Docker Compose on Linux systems

#### 1. Download the current stable release of Docker Compose:

```bash
# Download Docker Compose binary to the local system
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```

#### 2. Apply executable permissions to the binary:

```bash
# Make the Docker Compose binary executable
sudo chmod +x /usr/local/bin/docker-compose
```

#### 3. Test the installation:

```bash
# Verify that Docker Compose is correctly installed
docker-compose --version
```

### Reference

- [Docker Documentation](https://docs.docker.com/engine/install/ubuntu/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Official Ubuntu Package Sources](https://ubuntu.com/server/docs/package-management)
- [Best Practices for Docker](https://docs.docker.com/develop/dev-best-practices/)
- [Docker Security Best Practices](https://docs.docker.com/engine/security/security/)
- [Docker Performance Tuning](https://docs.docker.com/config/containers/resource_constraints/)
