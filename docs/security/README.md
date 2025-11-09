# vSphere 7 Security Best Practices

## 🔒 Security Overview

Enterprise-grade security practices for VMware vSphere 7.0 environments, covering hardening, compliance, and monitoring strategies.

## 📋 Security Checklist

### ESXi Host Security
- [ ] Enable Secure Boot and TPM 2.0
- [ ] Configure strong authentication
- [ ] Isolate management networks
- [ ] Enable audit logging
- [ ] Configure firewall rules

### vCenter Server Security
- [ ] Implement SSO with MFA
- [ ] Configure certificate management
- [ ] Enable session timeouts
- [ ] Restrict administrative access
- [ ] Monitor security events

### Virtual Machine Security
- [ ] Enable VM encryption
- [ ] Configure security policies
- [ ] Disable unnecessary devices
- [ ] Implement access controls
- [ ] Regular security updates

## 🛡️ Implementation Scripts

### ESXi Hardening
```powershell
# ESXi Security Configuration
Get-VMHost | Get-AdvancedSetting -Name "Security.PasswordQualityControl" | 
    Set-AdvancedSetting -Value "similar=deny retry=3 min=disabled,disabled,disabled,disabled,15"

Get-VMHost | Get-AdvancedSetting -Name "Config.HostAgent.plugins.solo.enableMob" | 
    Set-AdvancedSetting -Value $false
```

### VM Encryption
```python
# Enable VM encryption
config_spec = vim.vm.ConfigSpec()
crypto_spec = vim.vm.device.VirtualDeviceSpec.CryptoSpec()
crypto_spec.cryptoKeyId = vim.encryption.CryptoKeyId()
crypto_spec.cryptoKeyId.keyId = "encryption-key-id"
config_spec.crypto = crypto_spec
vm.ReconfigVM_Task(config_spec)
```

## 📊 Compliance Frameworks

### NIST Cybersecurity Framework
- **Identify**: Asset inventory and risk assessment
- **Protect**: Access control and data security
- **Detect**: Continuous monitoring
- **Respond**: Incident response procedures
- **Recover**: Recovery planning and improvements

### CIS Controls
- Control 1: Hardware and software inventory
- Control 2: Software asset management
- Control 3: Data protection
- Control 4: Secure configuration
- Control 5: Account management

## 🔍 Security Monitoring

### Event Monitoring
```bash
# Security event collection
tail -f /var/log/vmware/hostd.log | grep -i "authentication\|login\|failed"
```

### Automated Scanning
```bash
# SSL certificate check
openssl s_client -connect vcenter.local:443 -servername vcenter.local
```

## 🚨 Incident Response

### Emergency Procedures
1. **Identify** the security incident
2. **Contain** affected systems
3. **Eradicate** threats
4. **Recover** services
5. **Learn** from the incident

### VM Isolation Script
```powershell
# Emergency VM isolation
Get-VM "compromised-vm" | Get-NetworkAdapter | Set-NetworkAdapter -Connected:$false
New-Snapshot -VM "compromised-vm" -Name "Incident_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
```

---

