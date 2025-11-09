$ErrorActionPreference = "Stop"
<#
.SYNOPSIS
Automated VM deployment script for vSphere environments

.DESCRIPTION
    This script automates the deployment of virtual machines in a vSphere environment.
    It supports template-based deployment, customization, and post-deployment configuration.

.PARAMETER vCenterServer
    The vCenter Server FQDN or IP address

.PARAMETER Credential
    PSCredential object for vCenter authentication

.PARAMETER VMName
    Name of the virtual machine to deploy

.PARAMETER Template
    Name of the VM template to use for deployment

.PARAMETER Datastore
    Target datastore for VM deployment

.PARAMETER Cluster
    Target cluster for VM deployment

.PARAMETER ResourcePool
    Target resource pool (optional)

.PARAMETER Network
    Target network/port group for VM

.PARAMETER CustomizationSpec
    Guest OS customization specification name

.PARAMETER PowerOn
    Switch to power on VM after deployment

.EXAMPLE
    .\deploy-vm.ps1 -vCenterServer "vcenter.example.com" -VMName "web-server-01" -Template "windows-2019-template" -Datastore "datastore1" -Cluster "production-cluster" -Network "VM Network" -PowerOn

.EXAMPLE
    $cred = Get-Credential
    .\deploy-vm.ps1 -vCenterServer "vcenter.example.com" -Credential $cred -VMName "db-server-01" -Template "rhel8-template" -Datastore "ssd-datastore" -Cluster "database-cluster" -Network "database-vlan" -CustomizationSpec "linux-custom" -PowerOn

.NOTES
    Author: VMware vSphere Learning Hub
    Version: 1.0
    Requires: PowerCLI 12.0+
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$vCenterServer,
    
    [Parameter(Mandatory = $false)]
    [PSCredential]$Credential,
    
    [Parameter(Mandatory = $true)]
    [string]$VMName,
    
    [Parameter(Mandatory = $true)]
    [string]$Template,
    
    [Parameter(Mandatory = $true)]
    [string]$Datastore,
    
    [Parameter(Mandatory = $true)]
    [string]$Cluster,
    
    [Parameter(Mandatory = $false)]
    [string]$ResourcePool,
    
    [Parameter(Mandatory = $true)]
    [string]$Network,
    
    [Parameter(Mandatory = $false)]
    [string]$CustomizationSpec,
    
    [Parameter(Mandatory = $false)]
    [switch]$PowerOn
)

# Import required modules
try {
    Import-Module VMware.PowerCLI -ErrorAction Stop
    Write-Host "✓ PowerCLI module imported successfully" -ForegroundColor Green
}
catch {
    Write-Error "Failed to import PowerCLI module. Please install VMware PowerCLI."
    exit 1
}

# Suppress certificate warnings for lab environments
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false -Scope Session | Out-Null

# Function to write colored output
function Write-Status {
    param(
        [string]$Message,
        [string]$Status = "Info"
    )
    
    switch ($Status) {
        "Success" { Write-Host "✓ $Message" -ForegroundColor Green }
        "Warning" { Write-Host "⚠ $Message" -ForegroundColor Yellow }
        "Error" { Write-Host "✗ $Message" -ForegroundColor Red }
        "Info" { Write-Host "ℹ $Message" -ForegroundColor Cyan }
        default { Write-Host $Message }
    }
}

# Function to validate prerequisites
function Test-Prerequisites {
    Write-Status "Validating prerequisites..." "Info"
    
    # Check if VM name already exists
    try {
        $existingVM = Get-VM -Name $VMName -ErrorAction SilentlyContinue
        if ($existingVM) {
            Write-Status "VM with name '$VMName' already exists" "Error"
            return $false
        }
    }
    catch {
        # VM doesn't exist, which is what we want
    }
    
    # Validate template exists
    try {
        $templateObj = Get-Template -Name $Template -ErrorAction Stop
        Write-Status "Template '$Template' found" "Success"
    }
    catch {
        Write-Status "Template '$Template' not found" "Error"
        return $false
    }
    
    # Validate datastore exists and has space
    try {
        $datastoreObj = Get-Datastore -Name $Datastore -ErrorAction Stop
        $freeSpaceGB = [math]::Round($datastoreObj.FreeSpaceGB, 2)
        Write-Status "Datastore '$Datastore' found with $freeSpaceGB GB free space" "Success"
        
        if ($freeSpaceGB -lt 20) {
            Write-Status "Datastore has less than 20GB free space" "Warning"
        }
    }
    catch {
        Write-Status "Datastore '$Datastore' not found" "Error"
        return $false
    }
    
    # Validate cluster exists
    try {
        $clusterObj = Get-Cluster -Name $Cluster -ErrorAction Stop
        Write-Status "Cluster '$Cluster' found" "Success"
    }
    catch {
        Write-Status "Cluster '$Cluster' not found" "Error"
        return $false
    }
    
    # Validate network exists
    try {
        $networkObj = Get-VirtualPortGroup -Name $Network -ErrorAction Stop
        Write-Status "Network '$Network' found" "Success"
    }
    catch {
        Write-Status "Network '$Network' not found" "Error"
        return $false
    }
    
    return $true
}

# Function to deploy VM
function Deploy-VirtualMachine {
    Write-Status "Starting VM deployment..." "Info"
    
    try {
        # Build deployment parameters
        $deployParams = @{
            Name = $VMName
            Template = $Template
            Datastore = $Datastore
            VMHost = (Get-Cluster -Name $Cluster | Get-VMHost | Get-Random)
            Location = $Cluster
        }
        
        # Add resource pool if specified
        if ($ResourcePool) {
            $deployParams.ResourcePool = $ResourcePool
        }
        
        # Deploy VM from template
        Write-Status "Deploying VM '$VMName' from template '$Template'..." "Info"
        $vm = New-VM @deployParams -ErrorAction Stop
        Write-Status "VM deployed successfully" "Success"
        
        # Configure network
        Write-Status "Configuring network adapter..." "Info"
        $vm | Get-NetworkAdapter | Set-NetworkAdapter -NetworkName $Network -Confirm:$false | Out-Null
        Write-Status "Network adapter configured to '$Network'" "Success"
        
        # Apply customization specification if provided
        if ($CustomizationSpec) {
            Write-Status "Applying customization specification '$CustomizationSpec'..." "Info"
            try {
                $customSpec = Get-OSCustomizationSpec -Name $CustomizationSpec -ErrorAction Stop
                Set-VM -VM $vm -OSCustomizationSpec $customSpec -Confirm:$false | Out-Null
                Write-Status "Customization specification applied" "Success"
            }
            catch {
                Write-Status "Failed to apply customization specification: $($_.Exception.Message)" "Warning"
            }
        }
        
        # Power on VM if requested
        if ($PowerOn) {
            Write-Status "Powering on VM..." "Info"
            Start-VM -VM $vm -Confirm:$false | Out-Null
            Write-Status "VM powered on successfully" "Success"
        }
        
        # Display VM information
        Write-Status "VM Deployment Summary:" "Info"
        Write-Host "  Name: $($vm.Name)"
        Write-Host "  PowerState: $($vm.PowerState)"
        Write-Host "  NumCpu: $($vm.NumCpu)"
        Write-Host "  MemoryGB: $($vm.MemoryGB)"
        Write-Host "  VMHost: $($vm.VMHost)"
        Write-Host "  Datastore: $((Get-Datastore -VM $vm).Name)"
        
        return $vm
    }
    catch {
        Write-Status "VM deployment failed: $($_.Exception.Message)" "Error"
        throw
    }
}

# Main execution
try {
    Write-Status "Starting VM deployment process" "Info"
    Write-Status "Target vCenter: $vCenterServer" "Info"
    
    # Connect to vCenter
    Write-Status "Connecting to vCenter Server..." "Info"
    if ($Credential) {
        $connection = Connect-VIServer -Server $vCenterServer -Credential $Credential -ErrorAction Stop
    }
    else {
        $connection = Connect-VIServer -Server $vCenterServer -ErrorAction Stop
    }
    Write-Status "Connected to vCenter Server successfully" "Success"
    
    # Validate prerequisites
    if (-not (Test-Prerequisites)) {
        Write-Status "Prerequisites validation failed" "Error"
        exit 1
    }
    
    # Deploy VM
    $deployedVM = Deploy-VirtualMachine
    
    Write-Status "VM deployment completed successfully!" "Success"
    Write-Status "VM '$VMName' is ready for use" "Info"
}
catch {
    Write-Status "Deployment failed: $($_.Exception.Message)" "Error"
    exit 1
}
finally {
    # Disconnect from vCenter
    if ($connection) {
        Disconnect-VIServer -Server $vCenterServer -Confirm:$false
        Write-Status "Disconnected from vCenter Server" "Info"
    }
}