# vmware-vsphere-7-learn

[![AI-Powered](https://img.shields.io/badge/AI-Powered-blue?style=flat-square&logo=openai)](https://github.com/features/copilot)
[![CodeQL](https://github.com/uldyssian-sh/vmware-vsphere-7-learn/workflows/AI%20CodeQL%20Analysis/badge.svg)](https://github.com/uldyssian-sh/vmware-vsphere-7-learn/actions)
[![AI Assistant](https://img.shields.io/badge/AI-Assistant-green?style=flat-square)](https://github.com/uldyssian-sh/vmware-vsphere-7-learn/actions)
[![Dependabot](https://img.shields.io/badge/Dependabot-AI-orange?style=flat-square)](https://github.com/uldyssian-sh/vmware-vsphere-7-learn/network/dependencies)


[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub issues](https://img.shields.io/github/issues/uldyssian-sh/vmware-vsphere-7-learn)](https://github.com/uldyssian-sh/vmware-vsphere-7-learn/issues)
[![GitHub stars](https://img.shields.io/github/stars/uldyssian-sh/vmware-vsphere-7-learn)](https://github.com/uldyssian-sh/vmware-vsphere-7-learn/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/uldyssian-sh/vmware-vsphere-7-learn)](https://github.com/uldyssian-sh/vmware-vsphere-7-learn/network)
[![CI](https://github.com/uldyssian-sh/vmware-vsphere-7-learn/workflows/CI/badge.svg)](https://github.com/uldyssian-sh/vmware-vsphere-7-learn/actions)
[![Security Scan](https://github.com/uldyssian-sh/vmware-vsphere-7-learn/workflows/Security%20Scan/badge.svg)](https://github.com/uldyssian-sh/vmware-vsphere-7-learn/actions)
[![Quality Gate](https://github.com/uldyssian-sh/vmware-vsphere-7-learn/workflows/Quality%20Gate/badge.svg)](https://github.com/uldyssian-sh/vmware-vsphere-7-learn/actions)
[![Security](https://img.shields.io/badge/Security-Enterprise-blue.svg)](https://github.com/uldyssian-sh/vmware-vsphere-7-learn/blob/main/SECURITY.md)

## 🎯 Overview

Professional VMware vSphere 7 learning solution with enterprise-grade automation and security features. Comprehensive learning resources and practical examples for VMware vSphere 7.0 virtualization platform with hands-on tutorials, automation scripts, and enterprise-grade examples for mastering vSphere 7 administration and development.

**Repository Type:** Educational & Enterprise VMware Solutions  
**Technology Stack:** PowerCLI, vSphere API, PowerShell, Python, REST API  
**Target Audience:** VMware Administrators, DevOps Engineers, Cloud Architects

## 📊 Repository Stats

- **Files:** 32+
- **Technologies:** Python PowerShell YAML Bash
- **Type:** Infrastructure Automation
- **Status:** Production Ready

## ✨ Key Features

- 🏗️ **Enterprise Architecture** - Production-ready infrastructure
- 🎯 **Comprehensive Learning Path** - Structured tutorials from basics to advanced topics
- 🚀 **Hands-on Labs** - Practical exercises with real-world scenarios
- 🔒 **Zero-Trust Security** - Enterprise-grade security implementations
- 🤖 **Automation Scripts** - PowerCLI and Python automation examples
- 📊 **Performance Monitoring** - vSphere performance analysis tools
- 🛠️ **Infrastructure as Code** - Terraform and Ansible integrations
- 📚 **Rich Documentation** - Step-by-step guides and API references
- 🧪 **Quality Assurance** - Automated testing and validation
- 🔄 **CI/CD Integration** - GitHub Actions workflows for automation
- 🛡️ **Compliance Ready** - SOC2, GDPR, HIPAA standards

## 🚀 Quick Start

### Prerequisites

- **VMware vSphere 7.0+** environment (vCenter Server + ESXi hosts)
- **Python 3.8+** for API automation scripts
- **PowerShell 5.1+** or **PowerShell Core 7+**
- **VMware PowerCLI 12.0+** module
- **Git** for repository management
- **Docker** (optional, for containerized examples)

### Installation

```bash
# Clone repository
git clone https://github.com/uldyssian-sh/vmware-vsphere-7-learn.git
cd vmware-vsphere-7-learn

# Install Python dependencies
pip install -r requirements.txt

# Install PowerCLI (Windows/Linux/macOS)
Install-Module -Name VMware.PowerCLI -Scope CurrentUser

# Verify installation
python scripts/python/vsphere-api-examples.py --help
```

### Quick Examples

#### Python vSphere API
```python
from scripts.python.vsphere_api_examples import vSphereManager

# Connect to vCenter
vsphere = vSphereManager("vcenter.example.com", "username", "password")
vsphere.connect()

# List all VMs
vms = vsphere.get_all_vms()
for vm in vms:
    print(f"VM: {vm.name}, State: {vm.power_state}")
```

#### PowerCLI VM Deployment
```powershell
# Deploy VM from template
.\scripts\powercli\deploy-vm.ps1 -vCenterServer "vcenter.example.com" `
  -VMName "web-server-01" -Template "ubuntu-20.04-template" `
  -Datastore "datastore1" -Cluster "production" -Network "VM Network" -PowerOn
```

## 📚 Documentation

### Learning Path
- [vSphere 7 Fundamentals](VSPHERE7_FUNDAMENTALS.md) - Core concepts and architecture
- [Getting Started Tutorial](docs/tutorials/01-introduction.md) - First steps with vSphere 7
- [Lab Exercises](labs/) - Hands-on practical labs
- [Script Examples](examples/) - Ready-to-use automation scripts

### Technical References
- [PowerCLI Examples](scripts/powercli/) - PowerShell automation scripts
- [Python API Examples](scripts/python/) - vSphere API automation
- [Bash Utilities](scripts/bash/) - Environment setup scripts
- [Testing Framework](tests/) - Validation and testing tools

### Enterprise Resources
- [Security Best Practices](docs/security/) - Enterprise security guidelines
- [Performance Optimization](docs/performance/) - Performance tuning guides
- [API Reference](https://developer.vmware.com/apis/vsphere-automation/latest/) - Official VMware API documentation

## 🔧 Configuration

### Environment Setup

1. **vCenter Connection**
```bash
export VCENTER_SERVER="vcenter.example.com"
export VCENTER_USERNAME="administrator@vsphere.local"
export VCENTER_PASSWORD="<secure-password>"
```

2. **Python Configuration**
```python
# config.py
VCENTER_CONFIG = {
    'host': 'vcenter.example.com',
    'port': 443,
    'username': 'administrator@vsphere.local',
    'password': '<secure-password>',
    'ignore_ssl': True  # Only for lab environments
}
```

3. **PowerCLI Configuration**
```powershell
# Set PowerCLI configuration
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
Set-PowerCLIConfiguration -ParticipateInCEIP $false -Confirm:$false
```

## 📊 Learning Modules

### Module 1: vSphere Fundamentals
```bash
# Start with basic concepts
cd labs/lab-01-installation
cat README.md

# Follow the tutorial
open docs/tutorials/01-introduction.md
```

### Module 2: API Automation
```python
# Python vSphere API examples
from scripts.python.vsphere_api_examples import vSphereManager

# Connect and list inventory
vsphere = vSphereManager("vcenter.local", "admin", "password")
if vsphere.connect():
    vms = vsphere.get_all_vms()
    hosts = vsphere.get_all_hosts()
    dc_info = vsphere.get_datacenter_info()
```

### Module 3: PowerCLI Automation
```powershell
# PowerCLI VM management
Connect-VIServer -Server vcenter.local

# Deploy VM using our script
.\scripts\powercli\deploy-vm.ps1 -vCenterServer "vcenter.local" `
  -VMName "test-vm" -Template "ubuntu-template" `
  -Datastore "datastore1" -Cluster "cluster1" -Network "VM Network"
```

## 🧪 Testing & Validation

### Script Validation
```bash
# Validate Python scripts
python -m py_compile scripts/python/vsphere-api-examples.py

# Test PowerShell scripts
PowerShell -Command "Test-Path scripts/powercli/deploy-vm.ps1"

# Validate configuration files
yamllint .github/workflows/
```

### Environment Testing
```bash
# Test Python scripts
python -c "import sys; sys.path.append('scripts/python'); print('Python modules available')"

# Test PowerCLI module
PowerShell -Command "Get-Module -ListAvailable VMware.PowerCLI"
```

### Automated Testing
```bash
# Run GitHub Actions locally (using act)
act -j test

# Manual validation
ls scripts/bash/
```

## 🤝 Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## 📄 License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file.

## 🆘 Support

- 🐛 **Issues**: [GitHub Issues](https://github.com/uldyssian-sh/vmware-vsphere-7-learn/issues)
- 📖 **Documentation**: [GitHub Pages](https://uldyssian-sh.github.io/vmware-vsphere-7-learn/)

---

⭐ **Star this repository if you find it helpful!**
# Fixed Sun Nov  9 13:46:23 CET 2025
# File updated 1762692709

## 🤖 AI-Enhanced Repository

**FREE GitHub AI Features:**
- 🤖 GitHub Copilot integration
- 🔒 AI security scanning
- 📦 Smart dependency updates
- 🛡️ Automated vulnerability detection
