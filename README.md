# vmware-vsphere-7-learn

> **A polished, single-file training outline for VMware vSphere 7** — no external links embedded in the syllabus.

👤 **Author:** LT  📜 **License:** MIT  🗓️ **Format:** 5 days  🎯 **Level:** Admins & SysEng

---

## 🧭 Table of Contents
- [Audience & Fit](#-audience--fit)
- [Prerequisites](#-prerequisites)
- [Certification Path](#-certification-path)
- [Product Versions](#-product-versions)
- [Training Syllabus](#-training-syllabus)
  - [Module Matrix](#-module-matrix)
  - [Detailed Modules](#-detailed-modules)
- [Trainer Checklist](#-trainer-checklist)
- [Suggested Delivery Flow](#-suggested-delivery-flow)
- [Repository Layout](#-repository-layout)
- [License](#-license)

---

## 👥 Audience & Fit
- System administrators and system engineers who will operate a vSphere-based data center.  
- Five-day format with intensive hands-on practice to prepare you to manage environments of any size.

## 🧱 Prerequisites
- Prior experience administering **Microsoft Windows** or **Linux** systems.

## 🎓 Certification Path
- Meets the training requirement for the **VMware Certified Professional – Data Center Virtualization (VCP-DCV)**.

## 🗂️ Product Versions
- **ESXi 7.0**  
- **vCenter Server 7.0**

---

# 📝 Training Syllabus

### 🧩 Domain Icons
🧱 Foundations • 🖥️ Compute/VMs • 🧠 Platform Services • 🌐 Networking • 💾 Storage • 🛠️ Ops/Automation • 🛡️ Resilience • 🔄 Lifecycle

## 🔢 Module Matrix
| # | Module | Primary Domains |
|---:|---|---|
| 1 | Course Introduction | 🧱 |
| 2 | vSphere & the Software-Defined Data Center | 🧱 🛠️ |
| 3 | Virtual Machines | 🖥️ |
| 4 | vCenter Server | 🧠 🛠️ |
| 5 | Configuring & Managing Virtual Networks | 🌐 |
| 6 | Configuring & Managing Virtual Storage | 💾 |
| 7 | Virtual Machine Management | 🖥️ 🛠️ |
| 8 | Resource Management & Monitoring | 🛠️ |
| 9 | vSphere Clusters | 🛡️ |
|10 | vSphere Lifecycle Management | 🔄 |

> ℹ️ The outline below is original wording and contains **no external links**.

## 🔍 Detailed Modules

<details><summary><strong>Module 1 — Course Introduction 🧱</strong></summary>

- Meet the group and cover logistics.  
- Review course goals and how progress will be measured.

</details>

<details><summary><strong>Module 2 — vSphere & the Software-Defined Data Center 🧱</strong></summary>

**Foundations**  
- Clarify core virtualization ideas and where vSphere fits in a cloud-style data center.  
- Explain how compute, memory, networking and storage are abstracted.  

**Host fundamentals**  
- Identify ESXi architecture and do first-boot setup via the Direct Console UI.  
- Apply ESXi local-account best practices.  

**Access and tools**  
- Find your way around vCenter and ESXi interfaces.  
- Install an ESXi host and adjust host settings with VMware Host Client.

</details>

<details><summary><strong>Module 3 — Virtual Machines 🖥️</strong></summary>

- Build and provision a VM; install VMware Tools.  
- List the files and components that form a VM and the devices it can use.  
- Compare containers to VMs and place each in context.

</details>

<details><summary><strong>Module 4 — vCenter Server 🧠</strong></summary>

- Map the vCenter architecture and host communication model.  
- Deploy and configure the vCenter Server Appliance.  
- Organize the inventory: add data centers, folders and hosts.  
- Grant access with roles and permissions.  
- Back up the appliance; monitor tasks, events and health.  
- Protect the appliance using vCenter High Availability.

</details>

<details><summary><strong>Module 5 — Configuring & Managing Virtual Networks 🌐</strong></summary>

- Create and administer standard switches.  
- Differentiate virtual switch connection types.  
- Tune security, traffic shaping and load-balancing policies.  
- Contrast distributed vs standard switches.

</details>

<details><summary><strong>Module 6 — Configuring & Managing Virtual Storage 💾</strong></summary>

- Recognize storage device categories and protocols.  
- Attach ESXi to iSCSI, NFS and Fibre Channel storage.  
- Create and manage VMFS and NFS datastores.  
- Explain multipath behavior across the protocols.  
- Identify the building blocks of a vSAN configuration.

</details>

<details><summary><strong>Module 7 — Virtual Machine Management 🖥️🛠️</strong></summary>

- Roll out new VMs via templates and cloning; modify existing VMs.  
- Build a content library and deploy from templates stored there.  
- Customize guests with specification files.  
- Perform vMotion and Storage vMotion; understand Enhanced vMotion Compatibility.  
- Create and manage snapshots.  
- Describe vSphere Replication and how backup tools use Storage APIs for Data Protection.

</details>

<details><summary><strong>Module 8 — Resource Management & Monitoring 🛠️</strong></summary>

- Explain CPU/memory behavior and what overcommit means.  
- Apply techniques to optimize CPU and memory use.  
- Monitor resource consumption with available tools.  
- Create alarms that notify on important conditions/events.

</details>

<details><summary><strong>Module 9 — vSphere Clusters 🛡️</strong></summary>

- Define the purpose of a DRS cluster; create one and observe its state.  
- Explore options for high availability; describe HA architecture and manage an HA cluster.  
- Explain Fault Tolerance for critical workloads.

</details>

<details><summary><strong>Module 10 — vSphere Lifecycle Management 🔄</strong></summary>

- Note the role of Update Planner and how Lifecycle Manager operates.  
- Update ESXi hosts using baselines and validate compliance with a cluster image.  
- Upgrade VMware Tools and VM hardware versions.

</details>

---

## ✅ Trainer Checklist
- [ ] Environment access prepared (ESXi hosts, vCenter, networks, storage).  
- [ ] Demo datasets and placeholder VMs ready.  
- [ ] Lab steps tested end-to-end.  
- [ ] Recovery/rollback plan for demos.  
- [ ] Timeboxes per module finalized.  
- [ ] Assessment or knowledge checks drafted.

## 🧑‍🏫 Suggested Delivery Flow
1. **Day 1:** Modules 1–2 (Foundations, host setup)  
2. **Day 2:** Modules 3–4 (VMs and vCenter)  
3. **Day 3:** Modules 5–6 (Networking & Storage)  
4. **Day 4:** Modules 7–8 (VM management & monitoring)  
5. **Day 5:** Modules 9–10 (Clusters & lifecycle)  

> 💡 Tip: Reserve the final hour for Q&A and optional deep dives.

## 📁 Repository Layout
