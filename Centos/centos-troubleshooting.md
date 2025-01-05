## CentOS Troubleshooting Guide

### Issue: Failed to download metadata for repo ‘AppStream’ [CentOS]

**Error Message:**

```
Error: Failed to download metadata for repo 'AppStream': Cannot prepare internal mirrorlist: No URLs in mirrorlist
```

### Solution:

1. Navigate to the repository configuration directory:

    ```bash
    cd /etc/yum.repos.d/
    ```

2. Disable the mirrorlist in the CentOS repository configuration files:

    ```bash
    sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
    ```

3. Replace the `baseurl` with the `vault.centos.org` URLs:

    ```bash
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
    ```

4. Update the system:

    ```bash
    dnf update -y
    ```

### Explanation:

CentOS has shifted older versions to the Vault repository, which hosts archived versions. This error occurs when the mirrorlist is no longer available for the version you're using. The solution points your system to the `vault.centos.org` repository for updates and packages.

### Reference:

- [CentOS Vault Documentation](https://wiki.centos.org/FAQ/CentOS7)
- [Yum and DNF Troubleshooting Guide](https://access.redhat.com/solutions/253273)
