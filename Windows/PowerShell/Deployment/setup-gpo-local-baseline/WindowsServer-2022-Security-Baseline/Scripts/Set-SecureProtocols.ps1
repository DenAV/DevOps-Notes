# After running this script the computer only supports:
# - TLS 1.2
# - TLS 1.3

# Veeam Backup & Replication with Wasabi S3 storage configured?
$VBRWasabi = $true

# Get the operating system information
$os = Get-WmiObject -class Win32_OperatingSystem

# Determine the folder in which the script is located
$Script:ScriptPath = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition)
$Script:ScriptName = [System.IO.Path]::GetFileNameWithoutExtension($myInvocation.MyCommand.Definition)

# Troubleshooting
$Troubleshooting = $true

# Define the registry settings as a list of hashtables
$SettingsDisableOldProtocols = @(
    # Disable Multi-Protocol Unified Hello
    ## Server settings
    @{
        Hive = "HKLM:"
        Key = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\Multi-Protocol Unified Hello\Server"
        Name = "Enabled"
        Type = "DWORD"
        Value = 0
    },
    @{
        Hive = "HKLM:"
        Key = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\Multi-Protocol Unified Hello\Server"
        Name = "DisabledByDefault"
        Type = "DWORD"
        Value = 1
    },
    ## Client settings
    @{
        Hive = "HKLM:"
        Key = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\Multi-Protocol Unified Hello\Client"
        Name = "Enabled"
        Type = "DWORD"
        Value = 0
    },
    @{
        Hive = "HKLM:"
        Key = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\Multi-Protocol Unified Hello\Client"
        Name = "DisabledByDefault"
        Type = "DWORD"
        Value = 1
    },
    # Disable PCT 1.0
    ## Server settings
    @{
        Hive = "HKLM:"
        Key = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\PCT 1.0\Server"
        Name = "Enabled"
        Type = "DWORD"
        Value = 0
    },
    @{
        Hive = "HKLM:"
        Key = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\PCT 1.0\Server"
        Name = "DisabledByDefault"
        Type = "DWORD"
        Value = 1
    },
    ## Client settings
    @{
        Hive = "HKLM:"
        Key = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\PCT 1.0\Client"
        Name = "Enabled"
        Type = "DWORD"
        Value = 0
    },
    @{
        Hive = "HKLM:"
        Key = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\PCT 1.0\Client"
        Name = "DisabledByDefault"
        Type = "DWORD"
        Value = 1
    },
    # Disable SSL 2.0
    ## Server settings
    @{
        Hive = "HKLM:"
        Key = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server"
        Name = "Enabled"
        Type = "DWORD"
        Value = 0
    },
    @{
        Hive = "HKLM:"
        Key = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server"
        Name = "DisabledByDefault"
        Type = "DWORD"
        Value = 1
    },
    ## Client settings
    @{
        Hive = "HKLM:"
        Key = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client"
        Name = "Enabled"
        Type = "DWORD"
        Value = 0
    },
    @{
        Hive = "HKLM:"
        Key = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client"
        Name = "DisabledByDefault"
        Type = "DWORD"
        Value = 1
    },
    # Disable SSL 3.0
    ## Server settings
    @{
        Hive = "HKLM:"
        Key = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server"
        Name = "Enabled"
        Type = "DWORD"
        Value = 0
    },
    @{
        Hive = "HKLM:"
        Key = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server"
        Name = "DisabledByDefault"
        Type = "DWORD"
        Value = 1
    },
    ## Client settings
    @{
        Hive = "HKLM:"
        Key = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client"
        Name = "Enabled"
        Type = "DWORD"
        Value = 0
    },
    @{
        Hive = "HKLM:"
        Key = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client"
        Name = "DisabledByDefault"
        Type = "DWORD"
        Value = 1
    },
    # Disable TLS 1.0
    ## Server settings
    @{
        Hive = "HKLM:"
        Key = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server"
        Name = "Enabled"
        Type = "DWORD"
        Value = 0
    },
    @{
        Hive = "HKLM:"
        Key = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server"
        Name = "DisabledByDefault"
        Type = "DWORD"
        Value = 1
    },
    ## Client settings
    @{
        Hive = "HKLM:"
        Key = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client"
        Name = "Enabled"
        Type = "DWORD"
        Value = 0
    },
    @{
        Hive = "HKLM:"
        Key = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client"
        Name = "DisabledByDefault"
        Type = "DWORD"
        Value = 1
    },
    # Disable TLS 1.1
    ## Server settings
    @{
        Hive = "HKLM:"
        Key = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server"
        Name = "Enabled"
        Type = "DWORD"
        Value = 0
    },
    @{
        Hive = "HKLM:"
        Key = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server"
        Name = "DisabledByDefault"
        Type = "DWORD"
        Value = 1
    },
    ## Client settings
    @{
        Hive = "HKLM:"
        Key = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client"
        Name = "Enabled"
        Type = "DWORD"
        Value = 0
    },
    @{
        Hive = "HKLM:"
        Key = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client"
        Name = "DisabledByDefault"
        Type = "DWORD"
        Value = 1
    }
)

# Define the registry settings as a list of hashtables
$SettingsEnableTLS12 = @(
        # Enable TLS 1.2
    ## Server settings
    @{
        Hive = "HKLM:"
        Key = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server"
        Name = "Enabled"
        Type = "DWORD"
        Value = 1
    },
    @{
        Hive = "HKLM:"
        Key = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server"
        Name = "DisabledByDefault"
        Type = "DWORD"
        Value = 0
    },
    ## Client settings
    @{
        Hive = "HKLM:"
        Key = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client"
        Name = "Enabled"
        Type = "DWORD"
        Value = 1
    },
    @{
        Hive = "HKLM:"
        Key = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client"
        Name = "DisabledByDefault"
        Type = "DWORD"
        Value = 0
    }
)

$SettingsEnableTLS13 = @(
    # Enable TLS 1.3
    ## Server settings
    @{
        Hive = "HKLM:"
        Key = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.3\Server"
        Name = "Enabled"
        Type = "DWORD"
        Value = 1
    },
    @{
        Hive = "HKLM:"
        Key = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.3\Server"
        Name = "DisabledByDefault"
        Type = "DWORD"
        Value = 0
    },
    ## Client settings
    @{
        Hive = "HKLM:"
        Key = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.3\Client"
        Name = "Enabled"
        Type = "DWORD"
        Value = 1
    },
    @{
        Hive = "HKLM:"
        Key = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.3\Client"
        Name = "DisabledByDefault"
        Type = "DWORD"
        Value = 0
    }
)

# Function to create or update registry keys
function Set-RegistryValue {
    param (
        [string]$Hive,
        [string]$Key,
        [string]$Name,
        [string]$Type,
        [int]$Value
    )

    try {
        # Check if the item exists, if not create it
        $fullPath = "$($Hive)\$($Key)"
        if (-not (Test-Path $fullPath)) {
            # Create the key if it doesn't exist
            Write-Host "Creating registry key: $fullPath" -ForegroundColor Yellow
            New-Item -Path $fullPath -Force | Out-Null
        }

        # Create the registry value if it doesn't exist
        if (-not (Get-ItemProperty -Path $fullPath -Name $Name -ErrorAction SilentlyContinue)) {
            # Create the registry value
            Write-Host "Creating registry value: $fullPath\$Name" -ForegroundColor White
            New-ItemProperty -Path $fullPath -Name $Name -Value $Value -PropertyType $Type -Force | Out-Null
        } else {
            # Set the registry value
            Set-ItemProperty -Path $fullPath -Name $Name -Value $Value -Type $Type
        }
    } catch {
        Write-Host "Failed to set registry value: $fullPath\$Name" -ForegroundColor Red
    }
} # End of Set-RegistryValue

# Troubleshooting ##
if ($Troubleshooting) {
    $date = "{0:yyyy-MM-dd HH.mm}" -f (Get-Date)
    $log_path = $Script:ScriptPath
  
    $log_file = Join-Path -Path $log_path -ChildPath "$($Script:ScriptName)_$($date).log"
  
    # Start logging
    Start-Transcript $log_file
  }

Write-Host 'Configuring IIS with SSL/TLS Deployment Best Practices...' -ForegroundColor Cyan
Write-Host '--------------------------------------------------------------------------------' -ForegroundColor Yellow

######################################
# backup the current registry settings
######################################

try {
    # Create the backup directory if it doesn't exist
    $backupPath = "C:\Scripts\RegistryBackup"
    if (-not (Test-Path $backupPath -PathType Container)) {
        New-Item -Path $backupPath -ItemType Directory
    }

    $backupFile = "$backupPath\RegistryBackup_SecurityProviders_$(Get-Date -Format 'yyyyMMdd_HHmmss').reg"

    Write-Host "Backing up the current registry settings to $backupFile..."
    reg export "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders" $backupFile /y

} catch {
    Write-Host "Failed to backup the current registry settings." -ForegroundColor Red
    return
}

Write-Host '--------------------------------------------------------------------------------' -ForegroundColor Green
Write-Host "Applying registry settings for Security Schannel..." -ForegroundColor Magenta

Write-Host "Setting registry values for disabling old protocols ..." -ForegroundColor Cyan
# Apply the registry settings to disable old protocols
foreach ($setting in $SettingsDisableOldProtocols) {
    Set-RegistryValue -Hive $setting.Hive -Key $setting.Key -Name $setting.Name -Type $setting.Type -Value $setting.Value
}

Write-Host "Registry values for enabling TLS 1.2 ..." -ForegroundColor Cyan
# Apply the registry settings to enable TLS 1.2
foreach ($setting in $SettingsEnableTLS12) {
    Set-RegistryValue -Hive $setting.Hive -Key $setting.Key -Name $setting.Name -Type $setting.Type -Value $setting.Value
}

# Apply the registry settings to enable TLS 1.3
if ([System.Version]$os.Version -lt [System.Version]'10.0.20348') {
    # Microsoft integrated TLS 1.3 as a preview in Windows 10, but this code seems to be unstable and is causing malfunctions.
    Remove-Item -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.3' -Recurse -ErrorAction SilentlyContinue
    Write-Host 'TLS 1.3 has been disabled for Windows 10/2016/2019.'
  } else {
    Write-Host "Registry values for enabling TLS 1.3 ..." -ForegroundColor Cyan
    foreach ($setting in $SettingsEnableTLS13) {
        Set-RegistryValue -Hive $setting.Hive -Key $setting.Key -Name $setting.Name -Type $setting.Type -Value $setting.Value
    }
}

Write-Host "Registry settings have been applied successfully."
Write-Host '--------------------------------------------------------------------------------' -ForegroundColor Green

# Re-create the ciphers key.
New-Item 'HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers' -Force | Out-Null

# Disable insecure/weak ciphers.
$insecureCiphers = @(
  'DES 56/56',
  'NULL',
  'RC2 128/128',
  'RC2 40/128',
  'RC2 56/128',
  'RC4 40/128',
  'RC4 56/128',
  'RC4 64/128',
  'RC4 128/128',
  'Triple DES 168'
)
Foreach ($insecureCipher in $insecureCiphers) {
  $key = (Get-Item HKLM:\).OpenSubKey('SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers', $true).CreateSubKey($insecureCipher)
  $key.SetValue('Enabled', 0, 'DWord')
  $key.close()
  Write-Host "Weak cipher $insecureCipher has been disabled." -ForegroundColor DarkYellow
}

# Enable new secure ciphers.
# - RC4: It is recommended to disable RC4, but you may lock out WinXP/IE8 if you enforce this. This is a requirement for FIPS 140-2.
# - 3DES: It is recommended to disable these in near future. This is the last cipher supported by Windows XP.
# - Windows Vista and before 'Triple DES 168' was named 'Triple DES 168/168' per https://support.microsoft.com/en-us/kb/245030
$secureCiphers = @(
  'AES 128/128',
  'AES 256/256'
)
Foreach ($secureCipher in $secureCiphers) {
  $key = (Get-Item HKLM:\).OpenSubKey('SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers', $true).CreateSubKey($secureCipher)
  New-ItemProperty -path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\$secureCipher" -name 'Enabled' -value '0xffffffff' -PropertyType 'DWord' -Force | Out-Null
  $key.close()
  Write-Host "Strong cipher $secureCipher has been enabled."
}

Write-Host '--------------------------------------------------------------------------------' -ForegroundColor Green
# Set hashes configuration.
New-Item 'HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Hashes' -Force | Out-Null
New-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Hashes\MD5' -Force | Out-Null
New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Hashes\MD5' -name Enabled -value 0 -PropertyType 'DWord' -Force | Out-Null

$secureHashes = @(
  'SHA',
  'SHA256',
  'SHA384',
  'SHA512'
)
Foreach ($secureHash in $secureHashes) {
  $key = (Get-Item HKLM:\).OpenSubKey('SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Hashes', $true).CreateSubKey($secureHash)
  New-ItemProperty -path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Hashes\$secureHash" -name 'Enabled' -value '0xffffffff' -PropertyType 'DWord' -Force | Out-Null
  $key.close()
  Write-Host "Hash $secureHash has been enabled."
}

# Set KeyExchangeAlgorithms configuration.
New-Item 'HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms' -Force | Out-Null
$secureKeyExchangeAlgorithms = @(
  'Diffie-Hellman',
  'ECDH',
  'PKCS'
)
Foreach ($secureKeyExchangeAlgorithm in $secureKeyExchangeAlgorithms) {
  $key = (Get-Item HKLM:\).OpenSubKey('SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms', $true).CreateSubKey($secureKeyExchangeAlgorithm)
  New-ItemProperty -path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms\$secureKeyExchangeAlgorithm" -name 'Enabled' -value '0xffffffff' -PropertyType 'DWord' -Force | Out-Null
  $key.close()
  Write-Host "KeyExchangeAlgorithm $secureKeyExchangeAlgorithm has been enabled."
}

# Microsoft Security Advisory 3174644 - Updated Support for Diffie-Hellman Key Exchange
# https://docs.microsoft.com/en-us/security-updates/SecurityAdvisories/2016/3174644
Write-Host 'Configure longer DHE key shares for TLS servers.'
New-ItemProperty -path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms\Diffie-Hellman" -name 'ServerMinKeyBitLength' -value '2048' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms\Diffie-Hellman" -name 'ClientMinKeyBitLength' -value '2048' -PropertyType 'DWord' -Force | Out-Null

# https://support.microsoft.com/en-us/help/3174644/microsoft-security-advisory-updated-support-for-diffie-hellman-key-exc
New-ItemProperty -path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms\PKCS" -name 'ClientMinKeyBitLength' -value '2048' -PropertyType 'DWord' -Force | Out-Null

Write-Host '--------------------------------------------------------------------------------' -ForegroundColor Green

# if Veeam Backup & Replication with Wasabi S3 storage configured, not all ciphers are supported. Need to test and adjust.

if ($VBRWasabi) {

    Write-Host 'Veeam Backup & Replication with Wasabi S3 storage configured. Not all ciphers are supported. Need to test and adjust.' -ForegroundColor Yellow

} else {
    
    # TODO - for Veeam Backup & Replication with Wasabi S3 storage, not all ciphers are supported. Need to test and adjust.
    Write-Host 'Veeam Backup & Replication with Wasabi S3 storage not configured. All ciphers are supported.' -ForegroundColor Yellow

    # backup the current registry settings for Cryptography\Configuration\SSL
    # HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL

    try {
        # Create the backup directory if it doesn't exist
        $backupPath = "C:\Scripts\RegistryBackup"
        if (-not (Test-Path $backupPath -PathType Container)) {
            New-Item -Path $backupPath -ItemType Directory
        }

        $backupFile = "$backupPath\RegistryBackup_CryptographyConfigurationSSL_$(Get-Date -Format 'yyyyMMdd_HHmmss').reg"

        Write-Host "Backing up the current registry settings to $backupFile..."
        reg export "HKLM\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL" $backupFile /y

    } catch {
        Write-Host "Failed to backup the current registry settings." -ForegroundColor Red
        return
    }

    # Set cipher suites order as secure as possible (Enables Perfect Forward Secrecy).
    if ([System.Version]$os.Version -lt [System.Version]'10.0') {
        Write-Host 'Use cipher suites order for Windows 2008/2008R2/2012/2012R2.'
        $cipherSuitesOrder = @(
            'TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P521',
            'TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384',
            'TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256',
            'TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P521',
            'TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P384',
            'TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256',
            'TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P521',
            'TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384',
            'TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P256',
            'TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA_P521',
            'TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA_P384',
            'TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA_P256',
            'TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384_P521',
            'TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384_P384',
            'TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256_P521',
            'TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256_P384',
            'TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256_P256',
            'TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384_P521',
            'TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384_P384',
            'TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256_P521',
            'TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256_P384',
            'TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256_P256',
            'TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA_P521',
            'TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA_P384',
            'TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA_P256',
            'TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA_P521',
            'TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA_P384',
            'TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA_P256',
            # Below are the only AEAD ciphers available on Windows 2012R2 and earlier.
            # - RSA certificates need below ciphers, but ECDSA certificates (EV) may not.
            # - We get penalty for not using AEAD suites with RSA certificates.
            'TLS_RSA_WITH_AES_256_GCM_SHA384',
            'TLS_RSA_WITH_AES_128_GCM_SHA256',
            'TLS_RSA_WITH_AES_256_CBC_SHA256',
            'TLS_RSA_WITH_AES_128_CBC_SHA256',
            'TLS_RSA_WITH_AES_256_CBC_SHA',
            'TLS_RSA_WITH_AES_128_CBC_SHA'
        )
    } elseif ([System.Version]$os.Version -lt [System.Version]'10.0.20348') {
        Write-Host 'Use cipher suites order for Windows 10/2016/2019.'
        $cipherSuitesOrder = @(
            'TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384',
            'TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256',
            'TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384',
            'TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256',
            'TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA',
            'TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA',
            'TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384',
            'TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256',
            'TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384',
            'TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256',
            'TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA',
            'TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA'
            # 04.05.2024: Intel BUG - Enable TLS_RSA_WITH_AES_128_GCM_SHA256 if Intel EMA server is locally installed and AMT v12 devices need to be supported. Devices with AMT v14+ are not affected.
            #,'TLS_RSA_WITH_AES_128_GCM_SHA256'
        )
    } else {
        Write-Host 'Use cipher suites order for Windows 11/2022 and later.'
        $cipherSuitesOrder = @(
            'TLS_AES_256_GCM_SHA384',
            'TLS_AES_128_GCM_SHA256',
            'TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384',
            'TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256',
            'TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384',
            'TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256',
            'TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA',
            'TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA',
            'TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384',
            'TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256',
            'TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384',
            'TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256',
            'TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA',
            'TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA'
            # 04.05.2024: Intel BUG - Enable TLS_RSA_WITH_AES_128_GCM_SHA256 if Intel EMA server is locally installed and AMT v12 devices need to be supported. Devices with AMT v14+ are not affected.
            #,'TLS_RSA_WITH_AES_128_GCM_SHA256'
        )
    }

    $cipherSuitesAsString = [string]::join(',', $cipherSuitesOrder)
    # One user reported this key does not exists on Windows 2012R2. Cannot repro myself on a brand new Windows 2012R2 core machine. Adding this just to be save.
    New-Item 'HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002' -ErrorAction SilentlyContinue
    New-ItemProperty -path 'HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002' -name 'Functions' -value $cipherSuitesAsString -PropertyType 'String' -Force | Out-Null
    Write-Host '--------------------------------------------------------------------------------' -ForegroundColor Green

} # END of Veeam Backup & Replication with Wasabi S3 storage configured

## Troubleshooting ##
if ($Troubleshooting) {
Stop-Transcript
}

Remove-Variable -Name * -ErrorAction SilentlyContinue

######################################
Write-Host -ForegroundColor Red 'A computer restart is required to apply settings. Restart computer now?'
Restart-Computer -Force -Confirm

## END Script ##