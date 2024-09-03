#this s the configuration of the board
setenv ipaddr 192.168.0.100
setenv serverip 192.168.0.9
setenv bootargs "console=ttySTM0,115200 root=/dev/nfs ip=192.168.0.1 nfsroot=192.168.0.9:/nfs,nfsvers=3,tcp rw init=/bin/sh" 
setenv bootcmd 'tftp 0xc2000000 zImage; tftp 0xc4000000 stm32mp157a-dk1.dtb; bootz 0xc2000000 - 0xc4000000'
#this s the commands u run inside this folder 
docker build -t tftpnfs .
docker run -d --name tftp-nfs-server     --network my_macvlan_net     --ip 192.168.0.9     --privileged     -v ./nfs/:/nfs     -v ./tftp/:/var/lib/tftpboot     -p 2088:2049     -p 69:69/udp     tftpnfs
