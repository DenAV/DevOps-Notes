## Failed to download metadata for repo ‘AppStream’ [CentOS]
>Error: Failed to download metadata for repo 'AppStream': Cannot prepare internal mirrorlist: No URLs in mirrorlist
```
# cd /etc/yum.repos.d/
# sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
# sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
# dnf update -y
```
