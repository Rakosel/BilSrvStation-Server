#/bin/bash -xv 
set -x
sudo chown admin_share:technics -Rf /opt/SAMBA_SHARE/DebianISO/
cp -Rf /opt/SAMBA_SHARE/DebianISO/install_ext/ ~/BilSrvStation_Server_PC/DebianISO
cp -R /opt/SAMBA_SHARE/DebianISO/preseed.cfg ~/BilSrvStation_Server_PC/DebianISO/
cp -R /opt/SAMBA_SHARE/DebianISO/pc.sh ~/BilSrvStation_Server_PC/DebianISO/
