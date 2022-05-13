
semanage 
semanage fcontext -a -t ssh_home_t "/home/$USER_ADD/.ssh(/.*)?"
semanage fcontext -a -t ftpd_etc_t "/home/rootsu/vsftpd-virtual_user";

sudo semanage login -a -s sysadm_u -r "s0-s0:c0.c1023" admin
sudo semanage login -a -s sysadm_u -r "s0-s0:c0.c1023" %admins
sudo semanage login -m -s sysadm_u -r "s0-s0:c0.c1023" root
sudo semanage login -a -s sysadm_u -r "s0-s0:c0.c1023" %root
sudo semanage login -a -s sysadm_u -r "s0-s0:c0.c1023" %sudo


	systemctl disable auditd







#						_____________________________________						
#!/bin/bash -xv
# https://wiki.debian.org/Microcode
# uncomment #639!!!!
#if [[ -z $STATE ]]; then
#	exit 3;
#fi
# user add 
# echo "vkd174asqd" | mkpasswd -s -H MD5
# sudo usermod -p $(echo "" | mkpasswd -s -H MD5) test1
# sudo usermod -p $S test1
# su -p test1

#
#		AUTO 	POSTINSTALL		1.2.8a
#		octanovilca na SSL + po4initb script cmd
#		danger!!! do postinstall copy wufu & wpa_supplicant.conf + SAMBA
#
#		1.1.0	Pre-install EMV && Settings
#
#d-i preseed/late_command string mkdir -p /target/install/; cp -R /install/* /target/install/; cp -Rf /install/lib/ /target/lib/;
#

#cd /install/
#tar -xvf wpa_supplicant-0.7.3.tar.gz
#cd ./wpa_supplicant-0.7.3/
#./configure
#./install
#sudo apt install tasksel
#sudo apt install tasksel
#sudo apt install sddm / gdm3
#sudo dpkg-reconfigure sddm
#sudo tasksel install kde-desktop

echo -e "y\n" | sudo apt-get install setools policycoreutils selinux-basics selinux-utils selinux-policy-default selinux-policy-mls auditd policycoreutils-python-utils semanage-utils policycoreutils-gui 
#setroubleshoot 

#selinux-policy-targeted
#selinux-policy
#libselinux
#libselinux-python
#libselinux-utils
#policycoreutils
#policycoreutils-python
#setroubleshoot
#setroubleshoot-server
#setroubleshoot-plugins
Следующий список строк – это выдержка из файла /etc/pam.d/system–login
операционной системы Gentoo в части, касающейся служебных директив для
сессий, взаимодействующих с подключаемыми модулями аутентификации.
В файле запускаются коды библиотеки pam_SELi nux.so как составная часть процесса аутентификации следующим образом:
session required pam_selinux.so close

touch /.autorelabel
selinux-activate

sudo systemctl start auditd
sudo systemctl enable auditd

touch /.autorelabel
#getsebool -a | grep http
#semanage login -a -s sysadm_u "s0-s0:c0.c1023" root
#setsebool -P httpd_can_network_connect=1
sudo semanage login -a -s sysadm_u -r "s0-s0:c0.c1023" admin
sudo semanage login -a -s sysadm_u -r "s0-s0:c0.c1023" %admins
sudo semanage login -m -s sysadm_u -r "s0-s0:c0.c1023" root
sudo semanage login -a -s sysadm_u -r "s0-s0:c0.c1023" %root
sudo semanage login -a -s sysadm_u -r "s0-s0:c0.c1023" %sudo

sudo semanage login -a -s user_u tom

sudo setsebool -P ssh_sysadmn_login on
sudo setsebool -P allow_ftpd_full_access on
sudo setsebool -P allow_use_cifs on
sudo setsebool -P allow_use_nfs on

#sudo semanage user –a –R user_r –R system_r finance_u

sudo semanage fcontext --add -t ssh_home_t "/home/admin/.ssh(/.*)?"; 

sudo semanage fcontext -a -t ftpd_etc_t "/home/rootsu/vsftpd-virtual_user"; 
sudo chcon -Rv -t ftpd_etc_t "/home/rootsu/vsftpd-virtual_user"; 
sudo chcon -Rv -t ftpd_etc_t "/etc/ssl"; 
chcon -R -t public_content_rw_t /media/admin
chcon -R -t public_content_rw_t /opt/

chcon -R -t public_content_t /etc/ssl

semanage user -a -S sysadm -P tom -R "sysadm_r system_r" -r "s0-s0:c0.c127" sysadm_u

semanage user -a -R "sysadm_r system_r" -r "s0-s0:c0.c127" %sudo
semanage user -a -R "sysadm_r system_r" -r "s0-s0:c0.c127" admin
-s "_u" !!!

sudo audit2allow -w -a

sudo semanage port -a -t ssh_port_t -p tcp 4103
sudo semanage port -a -t ftp_port_t -p tcp 21

semanage permissive -a sshd_t 

semanage permissive -a boot_t 

setsebool ftp_home_dir -P

sudo setsebool -P allow_ftpd_full_access on
setsebool -P ftp_home_dir on
setsebool -P ftpd_use_passive_mode on


/etc/sysconfig/iptables
# Allow FTP connections @ port 21
-A INPUT -p tcp --sport 21 -m state --state ESTABLISHED -j ACCEPT
-A OUTPUT -p tcp --dport 21 -m state --state NEW,ESTABLISHED -j ACCEPT

# Allow Active FTP Connections
-A INPUT -p tcp --sport 20 -m state --state ESTABLISHED,RELATED -j ACCEPT
-A OUTPUT -p tcp --dport 20 -m state --state ESTABLISHED -j ACCEPT

# Allow Passive FTP Connections
-A INPUT -p tcp --sport 1024: --dport 1024: -m state --state ESTABLISHED -j ACCEPT
-A OUTPUT -p tcp --sport 1024: --dport 1024: -m state --state ESTABLISHED,RELATED -j ACCEPT

semanage fcontext -a -t public_content_t /myftp
restorecon -R -v /myftp/
semanage fcontext -a -t public_content_rw_t "/myftp/pub(/.*)?"
restorecon -R -v /myftp/pub
setsebool -P allow_ftpd_anon_write on
setsebool -P ftp_home_dir on
# setsebool -P allow_ftpd_use_nfs on
# setsebool -P allow_ftpd_use_cifs on

sudo /usr/sbin/semanage fcontext -a -t ftpd_etc_t /home/rootsu/vsftpd-virtual_user

chcon -u system_u /usr/bin/bash

getsebool -a | grep ftp
You should see something like the following

allow_ftpd_anon_write --> off
allow_ftpd_full_access --> off
allow_ftpd_use_cifs --> off
allow_ftpd_use_nfs --> off
ftp_home_dir --> off
ftpd_connect_db --> off
ftpd_use_fusefs --> off
ftpd_use_passive_mode --> off
httpd_enable_ftp_server --> off
tftp_anon_write --> off
tftp_use_cifs --> off
tftp_use_nfs --> off
You will need to adjust the ftp_home_dir option and ftpd_use_passive_mode

setsebool -P ftp_home_dir on
setsebool -P ftpd_use_passive_mode on

setsebool -P allow_ftpd_use_nfs on
setsebool -P allow_ftpd_use_cifs on

setsebool -P allow_ftpd_full_access on
setsebool -P ftp_home_dir on
setsebool -P ftpd_use_passive_mode on

setsebool -P allow_ftpd_use_cifs 1
setsebool -P allow_ftpd_full_access 1
setsebool -P allow_ftpd_use_cifs 1
setsebool -P allow_ftpd_use_nfs 1
setsebool -P ftpd_use_passive_mode 1
setsebool -P ftp_home_dir 1
setsebool -P ftpd_connect_db 1
setsebool -P allow_ftpd_use_nfs 1

chcon -R -t ftpd_t /home/rootsu/vsftpd-virtual_user
setsebool -P samba_export_all_ro 1
setsebool -P samba_export_all_rw 1
setsebool -P dhcpc_manage_samba 1
setsebool -P samba_create_home_dirs 1
setsebool -P samba_enable_home_dirs 1
setsebool -P samba_portmapper 1
setsebool -P samba_share_fusefs 1
setsebool -P samba_share_nfs 1
setsebool -P use_samba_home_dirs 1
setsebool -P virt_use_samba 1

setsebool -P ftpd_full_access 1

chcon -t samba_etc_t /home/rootsu/smbusers.conf

chcon -Rv -t samba_share_t /opt/SAMBA_SHARE
chcon -Rv -t samba_share_t /mnt/

#causes the sshd service is running in the bad domain. You can check /var/log/secure and you will see
#"Unable to get valid context for root"

semanage fcontext -a -t public_content_t /myftp
restorecon -R -v /myftp/


#So if you want to test it this way (without using a service script), you need to start the sshd service using

# runcon -r system_r -t initrc_t -- runcon -t sshd_t -- /usr/sbin/sshd -p133

setsebool secure_mode -P
setsebool secure_mode_insmod -P
setsebool secure_mode_policyload -P

handle-unknown=allow,deny,reject


# restorecon -vv test
restorecon: /mnt/test not reset customized by admin to user_u:object_r:httpd_sys_content_t:s0

Ah hah! Now we have some details. Since we now know that restorecon is being blocked due to the file/directory context being "customized", we can use the "-F" switch on restorecon to force the file context label to match the official policy.

# restorecon -vv -F test
restorecon reset /mnt/test context user_u:object_r:httpd_sys_content_t:s0->system_u:object_r:mnt_t:s0
# ls -ldZ test
drwxr-xr-x root root system_u:object_r:mnt_t test


# semanage fcontext -l | grep '/mnt'
/mnt(/[^/]*) symbolic link system_u:object_r:mnt_t:s0
/mnt(/[^/]*)? directory system_u:object_r:mnt_t:s0
/mnt/[^/]*/.* all files <<none>>

Executing a FTP daemon in the ftpd_t SELinux domain for FTP servers
The current SELinux module for FTP by default supports several common FTP daemons that are available like ProFTPd, vsFTPd and MuddleFTPd.

If you have installed and configured a FTP daemon that is not yet protected by SELinux, then you can simply add a file context specification for the FTP Daemon executable file to the list of system-wide file context specifications, and restore the file context of the FTP daemon executable file to the context that was specified.

To specify a file context for the "myftpd" FTP daemon executable file:

sudo /usr/sbin/semanage fcontext -a -t ftpd_exec_t /usr/sbin/myftpd  
To restore the context of the "myftpd" FTP daemon executable file to the file context that was specified:

sudo /sbin/restorecon -v /usr/sbin/myftpd
The labelling of objects that are part of FTP daemon not supported by default is not limited to just executable files.

If your FTP daemon is a init daemon and comes with an init script, then this init script file should be labelled similar:

sudo /usr/sbin/semodule fcontext -a -t ftpd_initrc_exec_t "/etc/rc.d/init.d/myftpd"
sudo /sbin/restorecon -v /etc/rc.d/init.d/myftpd
The same applies to PID files and log files that may be part of your FTP server package. The type to be used for FTP daemon PID files is ftpd_var_run_t, and the type to be used for FTP server log files is xferlog_t.

Reading and writing objects through FTP
FTP servers read and write objects on behalf of remote users that connect to FTP servers using FTP Clients.

To allow the FTP server to read files on behalf of clients, objects should be labeled type public_content_t.

sudo /usr/sbin/semanage fcontext -a -f -d -t public_content_t /srv/myftproot
sudo /sbin/restorecon -v /srv/myftproot
This allows the FTP daemon for read the /srv/myftproot on behalf of the FTP client

The FTP daemon SELinux policy can be configured to manage how the FTP daemon can interact with objects. FTP daemons can read object that are labelled type public_content_t.

In the example above we labelled the directory /srv/myftproot with type public_content_t which allows our FTP service to read this directory. In the next example the location /srv/myftproot/public and everything below this path, will be labelled with the type that our FTP daemon can read.

sudo /usr/sbin/semanage fcontext -a -t public_content_t "/srv/myftproot/public(/.*)?"
sudo /sbin/restorecon -R -v /srv/myftproot/public
All files that are places below /srv/myftproot/public will be readible by our FTP server. The ftpd_t SELinux domain type is allowed to read object with type public_content_t.

To allow our FTP daemon to write to a location, requires different rules. In the next example the location /srv/myftproot/incoming and everything below this location will be labelled with the type that our FTP daemon can write.

sudo /usr/sbin/semanage fcontext -a -t public_content_rw_t "/srv/myftproot/incoming(/.*)?"
sudo /sbin/restorecon -R -v /srv/myftproot/incoming
For SELinux to allow the FTP daemon SELinux domain to write to this location, the policy has to be tuned. The SELinux policy can be tuned on-the-fly to allow our FTP daemon to write to paths that are labelled public_content_rw_t by toggling a SELinux boolean called "allow_ftpd_anon_write".

sudo /usr/sbin/semanage boolean -m --on allow_ftpd_anon_write
This will allow our FTP server to write to the /srv/myftproot/incoming directory.

If the FTP content is located on a NFS or Samba share we can instruct SELinux to allow our FTP daemon to read this content as well.

sudo /usr/sbin/semanage boolean -m --on allow_ftpd_use_cifs
This allows our FTP server to read samba shares.

sudo /usr/sbin/semanage boolean -m --on allow_ftpd_use_nfs
This allows our FTP server to read NFS shares.

To instruct SELinux to allow our FTP service to also write to Samba or NFS locations, we would also be required to toggle to "allow_ftpd_anon_write" boolean.

Hosting user directories using FTP
FTP daemons can be configured to serve user directories. Unlike public FTP servers, clients are required to authenticate when a FTP daemon is configured to host Linux user directories. These clients log in using their Linux login password and have their own user directory on the FTP server.

SELinux can be configured to allow this functionality if required. By toggling a boolean we can instruct SELinux to allow our FTP daemon SELinux domain to read and write user content.

sudo /usr/sbin/semanage boolean -m --on ftp_home_dir
This will allow our FTP daemon to log clients into their user directory and read and write user content as well as read all the files that are required to make the user authentication succeed with the exception of the /etc/shadow file.

Currently this also allows our FTP service to search directories that store system web content.

Optionally our FTP server can be allowed to just manage almost every file. The use of this functionality is not encouraged but may be required in some scenarios.

sudo /usr/sbin/semanage boolean -m --on allow_ftpd_full_access
This will allow our FTP server to read and write all files except the file /etc/shadow.

SELinux can also be configured to allow our FTP daemon to support "old style" samba and NFS home directories. If our user directories are mounted with NFS or Samba we can instruct SELinux to allow our FTP daemon to read and write that content.

sudo /usr/sbin/semanage boolean -m --on use_nfs_home_dirs
sudo /usr/sbin/semanage boolean -m --on ftp_home_dir
This will allow our FTP daemon to read and write NFS mounted user directories and it will also allow the FTP server to read the files that are required to authenticate Linux users.

sudo /usr/sbin/semanage boolean -m --on use_samba_home_dirs
sudo /usr/sbin/semanage boolean -m --on ftp_home_dir
Similar to above this will allow our FTP daemon to read and write Samba mounted directories and it will also allow the FTP server to read the files that are required to authenticate Linux users.

Storing virtual FTP users in a database
FTP daemons can also be configured to use virtual users. These clients have to authenticate, but instead of using Linux logins, authentication is done by the FTP server. The FTP daemon can be configured to store the authentication information in a database.

To instruct SELinux to allow our FTP daemon access to connect to database network ports we are required to toggle a boolean.

sudo /usr/sbin/semanage boolean -m --on ftpd_connect_db


workaround-cyrillic-console-1.0-5.fc19.R.noarch

#https://docs.fedoraproject.org/en-US/epel/
subscription-manager repos --enable codeready-builder-for-rhel-8-$(arch)-rpms
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm


#http://nsk.lug.ru/system/make-mirror-with-apt-rpm-rsync-red-hat-80/
#http://rus-linux.net/lib.php?name=/MyLDP/po/APT_RH80.html
# http://rus-linux.net/lib.php?name=/MyLDP/po/APT_RH80.html
# http://nsk.lug.ru/system/make-mirror-with-apt-rpm-rsync-red-hat-80/


http://ftp.freshrpms.net/redhat/8.0/apt/apt-0.5.5cnc6-fr0.rh80.1.src.rpm

yum install yum-utils