# VMware vSphere 7 Learning Hub

## Table of Contents
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Examples](#examples)
- [Contributing](#contributing)
- [License](#license)
- [Support](#support)

## Prerequisites

Before using this project, ensure you have:
- Required tools and dependencies
- Proper access credentials
- System requirements met


[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PowerCLI](https://img.shields.io/badge/PowerCLI-12.0+-blue.svg)](https://www.powershellgallery.com/packages/VMware.PowerCLI)
[![Python](https://img.shields.io/badge/Python-3.8+-green.svg)](https://www.python.org/)
[![vSphere](https://img.shields.io/badge/vSphere-7.0+-orange.svg)](https://www.vmware.com/products/vsphere.html)

A comprehensive learning resource for VMware vSphere 7 with hands-on labs, automation scripts, and real-world examples.

**Author**: LT - [GitHub Profile](https://github.com/uldyssian-sh)

## 🎯 Overview

This repository provides a complete learning path for VMware vSphere 7, from basic concepts to advanced automation and management techniques.
Whether you're preparing for VCP certification or looking to enhance your virtualization skills, this hub has everything you need.

## 📚 What You'll Learn

- **Core vSphere Concepts**: ESXi, vCenter, networking, storage
- **Virtual Machine Management**: Creation, configuration, optimization
- **High Availability & DRS**: Clustering, load balancing, fault tolerance
- **Automation**: PowerCLI, Python scripting, REST API integration
- **Monitoring & Troubleshooting**: Performance analysis, log management
- **Security**: Best practices, compliance, hardening

## 🚀 Quick Start

### Prerequisites
- VMware vSphere 7.0+ environment (or VMware Workstation/Fusion for labs)
- PowerShell 5.1+ with PowerCLI module
- Python 3.8+ with pyvmomi library
- Basic understanding of virtualization concepts

### Installation
```bash
# Clone the repository
git clone https://github.com/uldyssian-sh/vmware-vsphere-7-learn.git
cd vmware-vsphere-7-learn

# Install PowerCLI (Windows/Linux/macOS)
Install-Module -Name VMware.PowerCLI -Scope CurrentUser

# Install Python dependencies
pip install -r requirements.txt
```

## 📖 Learning Path

### 🎓 Beginner Level
1. [Introduction to vSphere](docs/tutorials/01-introduction.md)
2. [ESXi Installation & Configuration](docs/tutorials/02-esxi-setup.md)
3. [vCenter Server Deployment](docs/tutorials/03-vcenter-deployment.md)
4. [Basic VM Operations](docs/tutorials/04-vm-basics.md)

### 🔧 Intermediate Level
5. [Networking Configuration](docs/tutorials/05-networking.md)
6. [Storage Management](docs/tutorials/06-storage.md)
7. [High Availability Setup](docs/tutorials/07-ha-setup.md)
8. [DRS Configuration](docs/tutorials/08-drs-config.md)

### 🚀 Advanced Level
9. [PowerCLI Automation](docs/tutorials/09-powercli-automation.md)
10. [Python vSphere API](docs/tutorials/10-python-api.md)
11. [Monitoring & Alerting](docs/tutorials/11-monitoring.md)
12. [Backup & Recovery](docs/tutorials/12-backup-recovery.md)

## 🧪 Hands-on Labs

| Lab | Topic | Duration | Difficulty |
|-----|-------|----------|------------|
| [Lab 01](labs/lab-01-installation/) | ESXi Installation | 45 min | Beginner |
| [Lab 02](labs/lab-02-networking/) | Network Configuration | 60 min | Beginner |
| [Lab 03](labs/lab-03-storage/) | Storage Setup | 60 min | Intermediate |
| [Lab 04](labs/lab-04-vms/) | VM Management | 90 min | Intermediate |
| [Lab 05](labs/lab-05-ha-drs/) | HA & DRS | 120 min | Advanced |
| [Lab 06](labs/lab-06-backup/) | Backup Solutions | 90 min | Advanced |

## 🛠️ Scripts & Tools

### PowerCLI Scripts
- [VM Deployment Automation](scripts/powercli/deploy-vm.ps1)
- [Health Check Reports](scripts/powercli/health-check.ps1)
- [Bulk VM Operations](scripts/powercli/bulk-operations.ps1)

### Python Scripts
- [vSphere API Examples](scripts/python/vsphere-api-examples.py)
- [Performance Monitoring](scripts/python/performance-monitor.py)
- [Automated Provisioning](scripts/python/auto-provision.py)

### Bash Utilities
- [Environment Setup](scripts/bash/setup-environment.sh)
- [Log Analysis](scripts/bash/analyze-logs.sh)
- [Backup Scripts](scripts/bash/backup-automation.sh)

## 📊 Examples

### Basic Examples
- [Connect to vCenter](examples/basic/connect-vcenter.md)
- [Create Virtual Machine](examples/basic/create-vm.md)
- [Configure Networking](examples/basic/setup-networking.md)

### Advanced Examples
- [Automated Deployment Pipeline](examples/advanced/deployment-pipeline.md)
- [Custom Monitoring Dashboard](examples/advanced/monitoring-dashboard.md)
- [Multi-Site Configuration](examples/advanced/multi-site-setup.md)

## 🔧 Tools & Utilities

### Monitoring Tools
- [Performance Dashboard](tools/monitoring/performance-dashboard.py)
- [Alert Manager](tools/monitoring/alert-manager.ps1)
- [Capacity Planner](tools/monitoring/capacity-planner.py)

### Deployment Tools
- [Template Manager](tools/deployment/template-manager.ps1)
- [Bulk Provisioning](tools/deployment/bulk-provision.py)
- [Configuration Validator](tools/deployment/config-validator.sh)

## 📚 Documentation

- [API Reference](docs/api-reference/) - Complete vSphere API documentation
- [Troubleshooting Guide](docs/troubleshooting/) - Common issues and solutions
- [Best Practices](docs/guides/best-practices.md) - Production-ready configurations
- [Security Hardening](docs/guides/security-hardening.md) - Security guidelines

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- VMware Community for excellent documentation
- PowerCLI team for powerful automation tools
- Contributors who make this project better

## 📞 Support

- 📖 [Wiki](../../wiki) - Detailed documentation and FAQs
- 🐛 [Issues](../../issues) - Bug reports and feature requests
- 💬 [Discussions](../../discussions) - Community support and questions

---

⭐ **Star this repository if it helps you learn vSphere!** ⭐

## Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details on:
- How to submit issues
- How to propose changes
- Code style guidelines
- Review process

## Support

- 📖 [Wiki Documentation](../../wiki)
- 💬 [Discussions](../../discussions)
- 🐛 [Issue Tracker](../../issues)
- 🔒 [Security Policy](SECURITY.md)

---
**Made with ❤️ for the community**
