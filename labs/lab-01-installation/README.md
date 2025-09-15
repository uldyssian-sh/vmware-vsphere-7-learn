# Lab 01: ESXi Installation and Initial Configuration

## Lab Overview

In this hands-on lab, you will install VMware ESXi 7.0 and perform initial configuration tasks. This lab provides practical experience with ESXi installation, network configuration, and basic management operations.

## Learning Objectives

By completing this lab, you will be able to:

- Install VMware ESXi 7.0 on physical or virtual hardware
- Configure basic network settings
- Access the ESXi Host Client interface
- Configure NTP and DNS settings
- Create and manage local users
- Configure SSH access
- Monitor system resources and logs

## Lab Environment

### Hardware Requirements

**Physical Installation:**
- 64-bit x86 server with VT-x/AMD-V support
- Minimum 8GB RAM (16GB+ recommended)
- 32GB+ storage for ESXi installation
- Network interface card (NIC)

**Virtual Installation (Nested):**
- VMware Workstation Pro 16+ or VMware Fusion 12+
- Host system with 16GB+ RAM
- 100GB+ available disk space
- Virtualization features enabled in BIOS

### Software Requirements

- VMware ESXi 7.0 ISO image
- Rufus or similar tool for USB creation (physical installation)
- Web browser (Chrome, Firefox, Edge)

## Lab Duration

**Estimated Time:** 45-60 minutes

## Prerequisites

- Basic understanding of server hardware
- Familiarity with BIOS/UEFI configuration
- Basic networking concepts (IP addressing, DNS)

---

## Exercise 1: Prepare Installation Media

### Step 1.1: Download ESXi ISO

1. Visit the VMware vSphere download page
2. Download VMware vSphere Hypervisor (ESXi) 7.0
3. Register for a free license key if needed

### Step 1.2: Create Bootable USB (Physical Installation)

**Using Rufus (Windows):**

1. Insert USB drive (8GB+ capacity)
2. Launch Rufus as administrator
3. Select your USB device
4. Choose the ESXi ISO file
5. Set partition scheme to **GPT**
6. Set target system to **UEFI (non CSM)**
7. Click **START** to create bootable USB

**Using dd command (Linux/macOS):**

```bash
# Find USB device
lsblk  # Linux
diskutil list  # macOS

# Create bootable USB (replace /dev/sdX with your USB device)
sudo dd if=VMware-ESXi-7.0.0-xxxxx.iso of=/dev/sdX bs=4M status=progress
sync
```

### Step 1.3: Prepare Virtual Machine (Nested Installation)

**VMware Workstation Pro:**

1. Create new virtual machine
2. Select **Custom (advanced)** configuration
3. Choose **I will install the operating system later**
4. Select **VMware ESXi 7** as guest OS
5. Configure VM settings:
   - **Name:** ESXi-Lab-01
   - **Memory:** 8GB (8192 MB)
   - **Processors:** 2 cores
   - **Hard Disk:** 60GB (Thin provisioned)
   - **Network:** NAT or Bridged

6. **Important:** Enable virtualization features:
   - Go to VM Settings → Processors
   - Check **Virtualize Intel VT-x/EPT or AMD-V/RVI**
   - Check **Virtualize CPU performance counters**

**VMware Fusion:**

1. Create new virtual machine
2. Select **Install from disc or image**
3. Choose the ESXi ISO file
4. Configure similar settings as Workstation Pro

---

## Exercise 2: Install ESXi

### Step 2.1: Boot from Installation Media

**Physical Installation:**
1. Insert USB drive into target server
2. Power on server and enter BIOS/UEFI
3. Set USB drive as first boot device
4. Save and exit BIOS

**Virtual Installation:**
1. Power on the virtual machine
2. Mount the ESXi ISO to the CD/DVD drive
3. Boot from CD/DVD

### Step 2.2: ESXi Installation Process

1. **Boot Screen**
   - Wait for ESXi installer to load
   - Press **Enter** to continue with standard installation

2. **End User License Agreement**
   - Press **F11** to accept the EULA

3. **Select Installation Disk**
   - Choose the target disk for ESXi installation
   - Press **Enter** to continue

4. **Select Keyboard Layout**
   - Choose your keyboard layout (default: US Default)
   - Press **Enter** to continue

5. **Set Root Password**
   - Enter a strong password for the root account
   - Confirm the password
   - Press **Enter** to continue

6. **Confirm Installation**
   - Review installation settings
   - Press **F11** to install ESXi

7. **Installation Complete**
   - Remove installation media when prompted
   - Press **Enter** to reboot

### Step 2.3: First Boot Configuration

1. **System Boot**
   - ESXi will boot and display the Direct Console User Interface (DCUI)
   - Note the default IP address assigned via DHCP

2. **Initial Network Configuration**
   - Press **F2** to customize system
   - Login with root credentials
   - Navigate to **Configure Management Network**

---

## Exercise 3: Basic Network Configuration

### Step 3.1: Configure Static IP Address

1. In the DCUI, press **F2** and login as root
2. Select **Configure Management Network**
3. Select **IPv4 Configuration**
4. Choose **Set static IPv4 address and network configuration**
5. Configure network settings:
   ```
   IPv4 Address: 192.168.1.100
   Subnet Mask: 255.255.255.0
   Default Gateway: 192.168.1.1
   ```
6. Press **Enter** to save
7. Press **Esc** to return to main menu

### Step 3.2: Configure DNS Settings

1. Select **DNS Configuration**
2. Configure DNS settings:
   ```
   Primary DNS Server: 8.8.8.8
   Alternate DNS Server: 8.8.4.4
   Hostname: esxi-lab-01.local
   ```
3. Press **Enter** to save

### Step 3.3: Apply Network Changes

1. Press **Esc** to exit Configure Management Network
2. Press **Y** to restart management network
3. Verify new IP address is displayed in DCUI

---

## Exercise 4: Access ESXi Host Client

### Step 4.1: Connect via Web Browser

1. Open web browser on management workstation
2. Navigate to: `https://192.168.1.100`
3. Accept security certificate warning
4. Login with root credentials

### Step 4.2: Explore Host Client Interface

**Dashboard Overview:**
- System resource utilization
- Hardware information
- Recent tasks and events

**Navigation Menu:**
- **Host** - System configuration and monitoring
- **Virtual Machines** - VM management
- **Storage** - Datastore and storage management
- **Networking** - Network configuration
- **Monitor** - Performance and logs

### Step 4.3: Review System Information

1. Navigate to **Host → Hardware**
2. Review hardware information:
   - CPU details and features
   - Memory configuration
   - Storage devices
   - Network adapters

---

## Exercise 5: Configure System Settings

### Step 5.1: Configure NTP

1. Navigate to **Host → Manage → System → Time & date**
2. Click **Edit settings**
3. Configure NTP:
   ```
   NTP Servers:
   - pool.ntp.org
   - time.google.com
   ```
4. Set **NTP service startup policy** to **Start and stop with host**
5. Click **Save**

### Step 5.2: Configure DNS

1. Navigate to **Host → Manage → System → Advanced settings**
2. Search for **DNS**
3. Verify DNS configuration matches DCUI settings

### Step 5.3: Configure Hostname

1. Navigate to **Host → Manage → System → Advanced settings**
2. Search for **hostname**
3. Verify hostname is set correctly

---

## Exercise 6: User Management and Security

### Step 6.1: Create Local User Account

1. Navigate to **Host → Manage → Security & users**
2. Click **Add user**
3. Create new user:
   ```
   User name: labadmin
   Full name: Lab Administrator
   Password: <strong-password>
   User group: root (for full access)
   ```
4. Click **Add**

### Step 6.2: Configure SSH Access

1. Navigate to **Host → Manage → Services**
2. Find **SSH** service
3. Click **Start** to enable SSH
4. Set **Startup policy** to **Start and stop with host**

### Step 6.3: Test SSH Access

```bash
# From Linux/macOS terminal or Windows PowerShell
ssh root@192.168.1.100

# Test basic commands
esxcli system version get
esxcli hardware cpu list
esxcli network ip interface list
```

---

## Exercise 7: Storage Configuration

### Step 7.1: Review Default Datastore

1. Navigate to **Storage → Datastores**
2. Review the default **datastore1**
3. Note available capacity and file system type (VMFS)

### Step 7.2: Create Additional Datastore (Optional)

If you have additional storage available:

1. Navigate to **Storage → Devices**
2. Identify unused storage device
3. Navigate to **Storage → Datastores**
4. Click **New datastore**
5. Follow wizard to create VMFS datastore

---

## Exercise 8: Monitoring and Troubleshooting

### Step 8.1: Monitor System Performance

1. Navigate to **Monitor → Performance**
2. Review performance charts:
   - CPU utilization
   - Memory usage
   - Network throughput
   - Storage latency

### Step 8.2: Review System Logs

1. Navigate to **Monitor → Logs**
2. Review different log types:
   - **vmkernel.log** - Core ESXi messages
   - **hostd.log** - Host management service
   - **vpxa.log** - vCenter agent (if applicable)

### Step 8.3: System Health Check

1. Navigate to **Monitor → Hardware → Sensors**
2. Review hardware health:
   - Temperature sensors
   - Fan speeds
   - Power supplies
   - System health status

---

## Exercise 9: Backup Configuration

### Step 9.1: Export Host Configuration

```bash
# Connect via SSH
ssh root@192.168.1.100

# Create configuration backup
vim-cmd hostsvc/firmware/backup_config

# Download the backup file via SCP
# The backup will be saved as configBundle-<hostname>.tgz
```

### Step 9.2: Document Configuration

Create a configuration document with:
- Network settings (IP, DNS, NTP)
- User accounts created
- Services enabled
- Storage configuration
- Any custom settings applied

---

## Lab Validation

### Validation Checklist

Verify the following items are completed:

- [ ] ESXi 7.0 successfully installed
- [ ] Static IP address configured and accessible
- [ ] DNS resolution working
- [ ] NTP synchronization configured
- [ ] SSH access enabled and tested
- [ ] Local user account created
- [ ] Host Client accessible via web browser
- [ ] System logs reviewed
- [ ] Configuration backup created

### Validation Commands

```bash
# System version and build
esxcli system version get

# Network configuration
esxcli network ip interface ipv4 get
esxcli network ip dns server list

# NTP status
esxcli system ntp get

# Service status
esxcli system service list | grep -E "(ssh|ntpd)"

# Storage information
esxcli storage filesystem list

# Hardware information
esxcli hardware cpu list
esxcli hardware memory get
```

---

## Troubleshooting

### Common Issues

**Issue: Cannot access Host Client**
- Verify IP address configuration
- Check firewall settings
- Ensure management network is up
- Try different web browser

**Issue: SSH connection refused**
- Verify SSH service is running
- Check firewall rules
- Confirm correct IP address

**Issue: Time synchronization problems**
- Verify NTP server accessibility
- Check firewall rules for NTP (port 123)
- Restart NTP service

**Issue: Network connectivity problems**
- Verify physical network connections
- Check VLAN configuration
- Confirm switch port configuration

### Useful Commands

```bash
# Restart management network
esxcli network ip interface set -e false -i vmk0
esxcli network ip interface set -e true -i vmk0

# Restart services
/etc/init.d/hostd restart
/etc/init.d/vpxa restart

# Check network connectivity
vmkping -I vmk0 192.168.1.1
vmkping -I vmk0 8.8.8.8

# View real-time logs
tail -f /var/log/vmkernel.log
tail -f /var/log/hostd.log
```

---

## Lab Summary

In this lab, you have successfully:

1. ✅ Installed VMware ESXi 7.0
2. ✅ Configured basic network settings
3. ✅ Accessed the ESXi Host Client
4. ✅ Configured system services (NTP, SSH, DNS)
5. ✅ Created user accounts and configured security
6. ✅ Reviewed storage configuration
7. ✅ Monitored system performance and logs
8. ✅ Created configuration backup

You now have a fully functional ESXi host ready for virtual machine deployment and advanced configuration tasks.

---

## Next Steps

- **[Lab 02: Network Configuration](../lab-02-networking/)** - Advanced networking setup
- **[Lab 03: Storage Management](../lab-03-storage/)** - Storage configuration and management
- **[Tutorial: vCenter Server Deployment](../../docs/tutorials/03-vcenter-deployment.md)** - Deploy vCenter for centralized management

---

## Additional Resources

### Documentation
- [VMware ESXi Installation Guide](https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.esxi.install.doc/GUID-B2F01BF5-078A-4C7E-B505-5DFFED0B8C38.html)
- [ESXi Configuration Guide](https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.esxi.install.doc/GUID-7C9A1E23-7FCD-4295-9CB1-C932F2423C63.html)

### Video Resources
- [ESXi Installation Walkthrough](https://example.com/video-link)
- [ESXi Basic Configuration](https://example.com/video-link)

### Community
- [VMware Community Forums](https://communities.vmware.com/)
- [r/vmware Subreddit](https://reddit.com/r/vmware)