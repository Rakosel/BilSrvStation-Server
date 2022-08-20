#!/bin/bash -xv 
#set -x
rm -Rf /opt/SAMBA_SHARE/git/BilSrvStation_Server_PC/DebianISO/
mkdir /opt/SAMBA_SHARE/git/BilSrvStation_Server_PC/DebianISO

cp -Rf /opt/SAMBA_SHARE/DebianISO/install_ext/ /opt/SAMBA_SHARE/git/BilSrvStation_Server_PC/DebianISO/
cp -Rf /opt/SAMBA_SHARE/DebianISO/preseed.cfg /opt/SAMBA_SHARE/git/BilSrvStation_Server_PC/DebianISO/
cp -Rf /opt/SAMBA_SHARE/DebianISO/pc.sh /opt/SAMBA_SHARE/git/BilSrvStation_Server_PC/DebianISO/
sudo chown admin_share:technics -Rf /opt/SAMBA_SHARE/git
sudo chmod ugo+rwx /opt/SAMBA_SHARE/git
