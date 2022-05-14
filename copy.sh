#/bin/bash -xv 
#set -x
sudo chown admin_share:technics -Rf /opt/SAMBA_SHARE/DebianISO/
cp -Rf /opt/SAMBA_SHARE/DebianISO/install_ext/ /opt/SAMBA_SHARE/BilSrvStation_Server_PC/DebianISO
cp -Rf /opt/SAMBA_SHARE/DebianISO/preseed.cfg /opt/SAMBA_SHARE/BilSrvStation_Server_PC/DebianISO/
cp -Rf /opt/SAMBA_SHARE/DebianISO/pc.sh /opt/SAMBA_SHARE/BilSrvStation_Server_PC/DebianISO/
