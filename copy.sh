#!/bin/bash -xv 
#set -x 
sudo rm -Rf /opt/SAMBA_SHARE/git/BilSrvStation_Server_PC/DebianISO/
sudo mkdir /opt/SAMBA_SHARE/git/BilSrvStation_Server_PC/DebianISO

sudo cp -Rf /opt/SAMBA_SHARE/DebianISO/install_ext/ /opt/SAMBA_SHARE/git/BilSrvStation_Server_PC/DebianISO/
sudo cp -Rf /opt/SAMBA_SHARE/DebianISO/preseed.cfg /opt/SAMBA_SHARE/git/BilSrvStation_Server_PC/DebianISO/
sudo cp -Rf /opt/SAMBA_SHARE/DebianISO/pc.sh /opt/SAMBA_SHARE/git/BilSrvStation_Server_PC/DebianISO/
sudo chown admin_share:technics -Rf /opt/SAMBA_SHARE/git
sudo chmod ugo+rwx /opt/SAMBA_SHARE/git
python /opt/SAMBA_SHARE/git/BilSrvStation_Server_PC/docs/conf.py
cd /opt/SAMBA_SHARE/git/BilSrvStation_Server_PC & sphinx-build -b html docs/ docs/_build/
