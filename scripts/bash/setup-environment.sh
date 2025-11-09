#!/bin/bash

# VMware vSphere 7 Learning Environment Setup Script
# 
# This script automates the setup of a development environment for
# VMware vSphere 7 learning and automation tasks.
#
# Author: VMware vSphere Learning Hub
# Version: 1.0
# Supported OS: Ubuntu 20.04+, CentOS 8+, macOS 10.15+

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging function
log() {
    echo -e "${BLUE}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

success() {
    echo -e "${GREEN}✓${NC} $1"
}

warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

error() {
    echo -e "${RED}✗${NC} $1"
}

# Detect operating system
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if command -v apt-get &> /dev/null; then
            OS="ubuntu"
        elif command -v yum &> /dev/null; then
            OS="centos"
        else
            error "Unsupported Linux distribution"
            exit 1
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
    else
        error "Unsupported operating system: $OSTYPE"
        exit 1
    fi
    
    log "Detected OS: $OS"
}

# Check if running as root (not recommended)
check_root() {
    if [[ $EUID -eq 0 ]]; then
        warning "Running as root is not recommended for this setup"
        read -p "Continue anyway? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi
}

# Install system dependencies
install_system_deps() {
    log "Installing system dependencies..."
    
    case $OS in
        ubuntu)
            sudo apt-get update
            sudo apt-get install -y \
                curl \
                wget \
                git \
                python3 \
                python3-pip \
                python3-venv \
                build-essential \
                libssl-dev \
                libffi-dev \
                python3-dev \
                jq \
                unzip
            ;;
        centos)
            sudo yum update -y
            sudo yum install -y \
                curl \
                wget \
                git \
                python3 \
                python3-pip \
                gcc \
                openssl-devel \
                libffi-devel \
                python3-devel \
                jq \
                unzip
            ;;
        macos)
            if ! command -v brew &> /dev/null; then
                log "Installing Homebrew..."
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            fi
            
            brew update
            brew install \
                python3 \
                git \
                jq \
                wget
            ;;
    esac
    
    success "System dependencies installed"
}

# Install PowerShell Core
install_powershell() {
    log "Installing PowerShell Core..."
    
    case $OS in
        ubuntu)
            # Download and install PowerShell
            wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
            sudo dpkg -i packages-microsoft-prod.deb
            sudo apt-get update
            sudo apt-get install -y powershell
            rm packages-microsoft-prod.deb
            ;;
        centos)
            # Register Microsoft repository
            curl https://packages.microsoft.com/config/rhel/8/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo
            sudo yum install -y powershell
            ;;
        macos)
            brew install --cask powershell
            ;;
    esac
    
    success "PowerShell Core installed"
}

# Install PowerCLI
install_powercli() {
    log "Installing VMware PowerCLI..."
    
    # Install PowerCLI for current user
    pwsh -Command "Set-PSRepository -Name PSGallery -InstallationPolicy Trusted"
    pwsh -Command "Install-Module -Name VMware.PowerCLI -Scope CurrentUser -Force"
    
    # Configure PowerCLI settings
    pwsh -Command "Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:\$false -Scope User"
    pwsh -Command "Set-PowerCLIConfiguration -ParticipateInCEIP \$false -Confirm:\$false -Scope User"
    
    success "PowerCLI installed and configured"
}

# Setup Python virtual environment
setup_python_env() {
    log "Setting up Python virtual environment..."
    
    # Create virtual environment
    python3 -m venv venv
    source venv/bin/activate
    
    # Upgrade pip
    pip install --upgrade pip
    
    # Install Python dependencies
    if [[ -f "requirements.txt" ]]; then
        pip install -r requirements.txt
    else
        # Install basic vSphere dependencies
        pip install \
            pyvmomi \
            requests \
            urllib3 \
            pyyaml \
            click \
            rich \
            tabulate
    fi
    
    success "Python environment setup complete"
}

# Create configuration directories
create_config_dirs() {
    log "Creating configuration directories..."
    
    mkdir -p ~/.vsphere-learning/{configs,logs,scripts,templates}
    mkdir -p ~/.vsphere-learning/credentials
    
    # Set secure permissions for credentials directory
    chmod 700 ~/.vsphere-learning/credentials
    
    success "Configuration directories created"
}

# Create sample configuration files
create_sample_configs() {
    log "Creating sample configuration files..."
    
    # Create sample environment configuration
    cat > ~/.vsphere-learning/configs/environment.yaml << 'EOF'
# VMware vSphere Environment Configuration
# Copy this file and customize for your environment

vcenter:
  host: "<vcenter-server-fqdn>"
  username: "<username>"
  password: "<password>"  # Use environment variable instead
  port: 443
  ignore_ssl: true

esxi_hosts:
  - name: "esxi-01"
    host: "<esxi-host-1>"
    username: "root"
    password: "<password>"
  - name: "esxi-02"
    host: "<esxi-host-2>"
    username: "root"
    password: "<password>"

defaults:
  datacenter: "Datacenter"
  cluster: "Cluster"
  datastore: "datastore1"
  network: "VM Network"
  
logging:
  level: "INFO"
  file: "~/.vsphere-learning/logs/operations.log"
EOF

    # Create sample PowerShell profile
    cat > ~/.vsphere-learning/configs/powershell-profile.ps1 << 'EOF'
# VMware PowerCLI Profile for vSphere Learning

# Import PowerCLI modules
Import-Module VMware.PowerCLI

# Set PowerCLI configuration
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false -Scope Session
Set-PowerCLIConfiguration -ParticipateInCEIP $false -Confirm:$false -Scope Session

# Custom functions
function Connect-LabvCenter {
    param(
        [string]$Server = $env:VCENTER_SERVER,
        [PSCredential]$Credential
    )
    
    if (-not $Server) {
        Write-Error "vCenter server not specified. Set VCENTER_SERVER environment variable or use -Server parameter."
        return
    }
    
    if (-not $Credential) {
        $Credential = Get-Credential -Message "Enter vCenter credentials"
    }
    
    Connect-VIServer -Server $Server -Credential $Credential
}

function Get-LabVMInfo {
    Get-VM | Select-Object Name, PowerState, NumCpu, MemoryGB, @{N="IP Address";E={$_.Guest.IPAddress[0]}}, VMHost
}

Write-Host "VMware vSphere Learning Environment Loaded" -ForegroundColor Green
Write-Host "Use 'Connect-LabvCenter' to connect to your lab environment" -ForegroundColor Yellow
EOF

    # Create environment variables template
    cat > ~/.vsphere-learning/configs/environment-template.env << 'EOF'
# VMware vSphere Environment Variables
# Copy to .env and customize for your environment

# vCenter Server Configuration
VCENTER_SERVER=<vcenter-server-fqdn>
VCENTER_USERNAME=<username>
VCENTER_PASSWORD=<password>

# ESXi Host Configuration
ESXI_HOST=<esxi-host-fqdn>
ESXI_USERNAME=root
ESXI_PASSWORD=<password>

# Default Configuration
DEFAULT_DATACENTER=Datacenter
DEFAULT_CLUSTER=Cluster
DEFAULT_DATASTORE=datastore1
DEFAULT_NETWORK="VM Network"

# Logging Configuration
LOG_LEVEL=INFO
LOG_FILE=~/.vsphere-learning/logs/operations.log
EOF

    success "Sample configuration files created"
}

# Install additional tools
install_additional_tools() {
    log "Installing additional tools..."
    
    # Install govc (vSphere CLI)
    if [[ "$OS" == "macos" ]]; then
        brew install govmomi/tap/govc
    else
        # Download and install govc for Linux
        GOVC_VERSION=$(curl -s https://api.github.com/repos/vmware/govmomi/releases/latest | jq -r .tag_name)
        GOVC_URL="https://github.com/vmware/govmomi/releases/download/${GOVC_VERSION}/govc_Linux_x86_64.tar.gz"
        
        wget -q "$GOVC_URL" -O /tmp/govc.tar.gz
        tar -xzf /tmp/govc.tar.gz -C /tmp
        sudo mv /tmp/govc /usr/local/bin/
        sudo chmod +x /usr/local/bin/govc
        rm /tmp/govc.tar.gz
    fi
    
    success "Additional tools installed"
}

# Create useful aliases and functions
create_aliases() {
    log "Creating useful aliases..."
    
    # Create bash aliases file
    cat > ~/.vsphere-learning/configs/bash-aliases << 'EOF'
# VMware vSphere Learning Aliases

# PowerShell/PowerCLI
alias pwsh-vcenter='pwsh -NoProfile -Command "& ~/.vsphere-learning/configs/powershell-profile.ps1"'

# Python virtual environment
alias activate-vsphere='source ~/.vsphere-learning/venv/bin/activate'

# Logging
alias vsphere-logs='tail -f ~/.vsphere-learning/logs/operations.log'

# Quick navigation
alias vsphere-cd='cd ~/.vsphere-learning'
alias vsphere-scripts='cd ~/.vsphere-learning/scripts'
alias vsphere-configs='cd ~/.vsphere-learning/configs'

# govc shortcuts (set GOVC_URL, GOVC_USERNAME, GOVC_PASSWORD first)
alias govc-vms='govc ls /*/vm'
alias govc-hosts='govc ls /*/host'
alias govc-datastores='govc ls /*/datastore'
EOF

    # Add to shell profile
    if [[ -f ~/.bashrc ]]; then
        echo "source ~/.vsphere-learning/configs/bash-aliases" >> ~/.bashrc
    elif [[ -f ~/.zshrc ]]; then
        echo "source ~/.vsphere-learning/configs/bash-aliases" >> ~/.zshrc
    fi
    
    success "Aliases created"
}

# Verify installation
verify_installation() {
    log "Verifying installation..."
    
    # Check PowerShell
    if command -v pwsh &> /dev/null; then
        success "PowerShell Core: $(pwsh --version)"
    else
        error "PowerShell Core not found"
    fi
    
    # Check PowerCLI
    if pwsh -Command "Get-Module -ListAvailable VMware.PowerCLI" &> /dev/null; then
        success "PowerCLI: Available"
    else
        error "PowerCLI not found"
    fi
    
    # Check Python
    if command -v python3 &> /dev/null; then
        success "Python: $(python3 --version)"
    else
        error "Python 3 not found"
    fi
    
    # Check pyvmomi
    if python3 -c "import pyVmomi" &> /dev/null 2>&1; then
        success "pyvmomi: Available"
    else
        warning "pyvmomi not found (activate virtual environment first)"
    fi
    
    # Check govc
    if command -v govc &> /dev/null; then
        success "govc: $(govc version)"
    else
        warning "govc not found"
    fi
}

# Display next steps
show_next_steps() {
    echo
    echo -e "${GREEN}🎉 Setup completed successfully!${NC}"
    echo
    echo -e "${YELLOW}Next Steps:${NC}"
    echo "1. Activate Python virtual environment:"
    echo "   source ~/.vsphere-learning/venv/bin/activate"
    echo
    echo "2. Configure your environment:"
    echo "   cp ~/.vsphere-learning/configs/environment-template.env ~/.vsphere-learning/configs/.env"
    echo "   # Edit the .env file with your vCenter/ESXi details"
    echo
    echo "3. Test PowerCLI connection:"
    echo "   pwsh -Command 'Connect-VIServer -Server <your-vcenter>'"
    echo
    echo "4. Test Python connection:"
    echo "   python3 scripts/python/vsphere-api-examples.py"
    echo
    echo "5. Explore the learning materials:"
    echo "   - docs/tutorials/ - Step-by-step tutorials"
    echo "   - labs/ - Hands-on lab exercises"
    echo "   - scripts/ - Automation examples"
    echo
    echo -e "${BLUE}Configuration files location: ~/.vsphere-learning/${NC}"
    echo -e "${BLUE}Logs location: ~/.vsphere-learning/logs/${NC}"
}

# Main execution
main() {
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║          VMware vSphere 7 Learning Environment Setup        ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    
    detect_os
    check_root
    
    log "Starting environment setup..."
    
    install_system_deps
    install_powershell
    install_powercli
    setup_python_env
    create_config_dirs
    create_sample_configs
    install_additional_tools
    create_aliases
    verify_installation
    
    show_next_steps
}

# Run main function
main "$@"# Updated Sun Nov  9 12:49:15 CET 2025
