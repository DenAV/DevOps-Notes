## Git Setup Guide for CentOS and Ubuntu

### 1. Install Git on CentOS

```bash
# Install Git and related tools
sudo dnf install -y git
sudo dnf install -y wget unzip tar make gcc openssl-devel libcurl-devel expat-devel
```

### 2. Install Git on Ubuntu

```bash
# Update package index and install Git
sudo apt update
sudo apt install -y git build-essential libssl-dev libcurl4-gnutls-dev libexpat1-dev gettext unzip
```

### 3. Verify Git Installation

```bash
# Check Git configuration and version
git --version
```

### 4. Clone a Repository

```bash
# Clone a Git repository
$ git clone https://your-repo-url.git
```

### 5. Synchronize with Repository

#### Check the Status:

```bash
$ git status
```

#### Stage Changes:

```bash
$ git add *
```

#### Commit Changes:

```bash
$ git commit -m "your commit message"
```

#### View Commit Log:

```bash
$ git log
```

#### Push Changes:

```bash
$ git push
```

### 6. Pull Latest Changes from the Repository

```bash
$ git pull
```

### Reference:

- [Top 20 Git Commands with Examples](https://dzone.com/articles/top-20-git-commands-with-examples)
- [Git Documentation](https://git-scm.com/doc)
- [Git Best Practices](https://about.gitlab.com/topics/git-best-practices/)
- [Effective Git Commit Messages](https://chris.beams.io/posts/git-commit/)
