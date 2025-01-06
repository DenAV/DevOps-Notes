# OpenSSL Setup Guide

OpenSSL is a powerful toolkit for SSL/TLS and general-purpose cryptography. This guide provides instructions for installing OpenSSL, configuring it, and exploring its capabilities.

## 1. Installation

### CentOS

```bash
# Install OpenSSL and development libraries
sudo dnf install -y openssl openssl-devel
```

### Ubuntu

```bash
# Install OpenSSL and development libraries
sudo apt update
sudo apt install -y openssl libssl-dev
```

### Verify Installation

```bash
# Check OpenSSL version
openssl version
```

## 2. Configuration

### Default Configuration File

The default configuration file for OpenSSL is typically located at:

- **CentOS:** `/etc/pki/tls/openssl.cnf`
- **Ubuntu:** `/etc/ssl/openssl.cnf`

You can customize this file to define default settings for certificate generation, cryptographic algorithms, and more.

### Example Customization

- Edit the configuration file:

    ```bash
    sudo nano /etc/ssl/openssl.cnf
    ```

- Set the default location for new certificates:

    ```
    dir = /etc/ssl/certs
    ```

- Configure default key size:

    ```
    default_bits = 2048
    ```

## 3. Capabilities of OpenSSL

OpenSSL supports a wide range of cryptographic operations, including:

### Certificate Management

- Generate a private key:

    ```bash
    openssl genrsa -out private.key 2048
    ```

- Create a certificate signing request (CSR):

    ```bash
    openssl req -new -key private.key -out request.csr
    ```

- Self-sign a certificate:

    ```bash
    openssl x509 -req -days 365 -in request.csr -signkey private.key -out certificate.crt
    ```

### Encrypt and Decrypt Files

- Encrypt a file:

    ```bash
    openssl enc -aes-256-cbc -salt -in file.txt -out file.txt.enc
    ```

- Decrypt a file:

    ```bash
    openssl enc -d -aes-256-cbc -in file.txt.enc -out file.txt
    ```

### Hashing

- Generate a hash of a file:

    ```bash
    openssl dgst -sha256 file.txt
    ```

### Testing SSL/TLS Connections

- Test a secure connection to a server:

    ```bash
    openssl s_client -connect example.com:443
    ```

### Convert Certificates

- Convert a certificate from PEM to DER format:

    ```bash
    openssl x509 -outform der -in certificate.crt -out certificate.der
    ```

- Convert a private key to PKCS#8 format:

    ```bash
    openssl pkcs8 -topk8 -inform PEM -outform PEM -in private.key -out private_pkcs8.key -nocrypt
    ```

## 4. Additional Useful Commands

### Check PKCS#12 File

```bash
# View details of a PKCS#12 file
openssl pkcs12 -info -in certificate-site.example.com.pfx -passin pass:password
```

### Extract Private Key

- Extract an encrypted private key:

    ```bash
    openssl pkcs12 -in certificate-site.example.com.pfx -nocerts -out privkey-encrypted.pem -passin pass:password -passout pass:password
    ```

- Convert to an unencrypted private key:

    ```bash
    openssl rsa -in privkey-encrypted.pem -out privkey.pem
    ```

### Extract Certificates

- Extract certificates:

    ```bash
    openssl pkcs12 -in certificate-site.example.com.pfx -clcerts -nokeys -out cert.pem -passin pass:password
    ```

- Extract certificate chain:

    ```bash
    openssl pkcs12 -in certificate-site.example.com.pfx -cacerts -nokeys -out chain.pem -passin pass:password
    ```

### Create Complete Set for Apache

- Combine the server certificate and certificate chain:

    ```bash
    cat cert.pem chain.pem > fullchain.pem
    ```

## 5. Documentation and Resources

- [OpenSSL Official Documentation](https://www.openssl.org/docs/)
- [OpenSSL Commands Cheat Sheet](https://cheatsheet.dennyzhang.com/openssl-cheat-sheet)
- [Cryptographic Best Practices](https://www.ssl.com/guide/openssl-best-practices/)

This guide offers an overview of OpenSSL's core features. For advanced usage and configurations, refer to the official documentation and best practices.
