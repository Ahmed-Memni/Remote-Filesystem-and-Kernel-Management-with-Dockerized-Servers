# Remote Filesystem and Kernel Management with Dockerized Servers

This repository contains a comprehensive project focused on managing remote filesystems and kernels using Dockerized servers. The project leverages NFS (Network File System) and TFTP (Trivial File Transfer Protocol) to facilitate seamless booting and file management for embedded systems, including STM32 and Raspberry Pi boards.

## Key Features
- **Dockerized NFS and TFTP Servers:** Simplified setup and deployment of NFS and TFTP services within Docker containers, ensuring portability and ease of management.
- **Remote Filesystem Management:** Efficient handling of remote filesystems, enabling embedded devices to mount root filesystems over a network.
- **Remote Kernel Loading:** Streamlined process for loading and booting kernels from a remote server using TFTP.
- **Extensibility:** Potential for further enhancement to integrate with online repositories and CI/CD pipelines, making the system more robust and scalable.

## Status
This project is a work in progress. Additional features and documentation will be added as development continues.


## Setup and Configuration Guide

### 1. **Network Configuration**

To ensure proper network operation, configure your network IP address to 192.168.0.1.

### 2. **U-Boot Configuration**

If U-Boot is not configured, you need to set up the environment variables for network booting. Follow these steps:

1. **Install picocom (if not already installed):**

   

bash
   sudo apt-get install picocom



2. **Configure U-Boot Environment Variables:**

   Connect to your device using picocom and set the following environment variables:

   

bash
   picocom /dev/ttyACM0 -b 115200



   Inside picocom, enter the following commands:

   

bash
   setenv ipaddr 192.168.0.100
   setenv serverip 192.168.0.9
   setenv bootargs "console=ttySTM0,115200 root=/dev/nfs ip=192.168.0.1 nfsroot=192.168.0.9:/nfs,nfsvers=3,tcp rw init=/bin/sh"
   setenv bootcmd 'tftp 0xc2000000 zImage; tftp 0xc4000000 stm32mp157a-dk1.dtb; bootz 0xc2000000 - 0xc4000000'
   saveenv



   - ipaddr: The IP address of your device.
   - serverip: The IP address of your TFTP server.
   - bootargs: Boot arguments including console, root filesystem, and NFS configuration.
   - bootcmd: Commands to load the kernel and Device Tree Blob (DTB) via TFTP and boot the system.

### 3. **Run the Script**

1. **Navigate to the Script Directory:**

   

bash
   cd /test_script



2. **Run the Script:**

   Execute the script with the paths or Git repository links for the root filesystem and kernel:

   

bash
   ./tftp_nfs_script <path_to_root_filesystem_or_git_repo> <path_to_kernel_or_git_repo>



   - Replace <path_to_root_filesystem_or_git_repo> with the path to your root filesystem directory or Git repository URL.
   - Replace <path_to_kernel_or_git_repo> with the path to your kernel directory or Git repository URL.

### Example Command

If your root filesystem is in /rootfs and your kernel is in /kernel, use:

bash
./tftp_nfs_script ./nfs ./tftp



If you need to clone from Git repositories, use:

bash
./tftp_nfs_script https://github.com/username/rootfs-repo.git https://github.com/username/kernel-repo.git



Make sure the script has executable permissions. If not, set them with:

bash
chmod +x tftp_nfs_script
