#!/bin/bash -xv
#
#		AUTO 	POSTINSTALL		1.1.8a
#		octanovilca na SSL + po4initb script cmd
#		danger!!! do postinstall copy wufu & wpa_supplicant.conf + SAMBA
#
#		1.1.0	Pre-install EMV && Settings
#
#d-i preseed/late_command string mkdir -p /target/install/; cp -R /install/* /target/install/; cp -Rf /install/lib/ /target/lib/;
#
#cp -Rf /install/home/ /home/ # -> rootsu, admin
#cd /install/
#tar -xvf wpa_supplicant-0.7.3.tar.gz
#cd ./wpa_supplicant-0.7.3/
#./configure
#./install
set -x
# include this boilerplate
#
#	https://stackoverflow.com/questions/9639103/is-there-a-goto-statement-in-bash
#	# GOTO for bash, based upon https://stackoverflow.com/a/31269848/5353461
#
function jumpto
{
    label=$1
    cmd=$(sed -n "/$label:/{:a;n;p;ba};" $0 | grep -v ':$')
    eval "$cmd"
    exit
}
start=${1:-"start"}
step_one=${2:-"step_one"}
step_two=${3:-"step_two"}
step_three=${4:-"step_three"}

# 		+ install wpa_supplicant-0.7.3.tar.gz
export LC_ALL=ru_RU.UTF-8
FILES="steps.txt"
BUF="";
TMPS="";
COUNT=0;
DEB_VER="";
NET_EN="";
NET_WI="";
STATE="0";
PORT_SSH="23"
NET_ARR=();
#
#		1.1.1	Check root privilege
#

if [[ $EUID -ne 0 ]]; then
	if [[ ${LANG:0:5} -eq 'ru_RU' ]]; then
		echo "Ошибка скрипта перезапустите скрипт на root" 1>&2
	else
		echo "This script must be run as root" 1>&2
	fi
	exit 1;
fi

if [[ ! -f "$FILES" ]]; then
	touch steps.txt
fi	

#https://askubuntu.com/questions/1705/how-can-i-create-a-select-menu-in-a-shell-script
#options=("Option 1" "Option 2" "Option 3" "Quit")
#select opt in "${options[@]}"
select opt in Auto PoluAuto Hands Exit; do
case $opt in
    Auto)
		echo -n "Сейчас будет произведена автоматическая найстройка ";
		sleep 3;
		jumpto start
      ;;
	Polstart)
		echo -n "В разработке...";
      ;;
    Hands)
		echo -n "В разработке...";
      ;;
    Exit)
      exit 1;
      ;;
    *) 
      echo "Недопустимая опция $REPLY";
      ;;
  esac
done
#

jumpto $start

start:

#
#
#  Проверка отдельных переменных окружения.
#  Если переменная, к примеру $USER, не установлена,
#+ то выводится сообщение об ошибке.
: ${HOSTNAME?} ${USER?} ${HOME?} ${MAIL?}
  echo
  echo "Имя машины: $HOSTNAME."
  echo "Ваше имя: $USER."
  echo "Ваш домашний каталог: $HOME."
  echo "Ваш почтовый ящик: $MAIL."
  echo
  echo "Если перед Вами появилось это сообщение,"
  echo "то это значит, что все критические переменные окружения установлены."
  echo 
  echo "Сейчас будут установлена postinstall настройка"
  echo



cd /etc/apt/
cp sources.list sources.tmp

# &VERSION_DEBIAN -e mojno off
#lsb_release -d | sed -n -e 's/.*(\([^\)]\+\))/\1/p'

# egrep '^[a-z]' sources.list
# sed -i 's/#deb-src http/deb-src http/g' sources.list
# sed -i 's/#deb http/deb http/g' sources.list
# 	algoritm: 
#	a.0 search deb, deb-src 
#???	bash buffer
#lsb_release -d | sed -n 's/.*\([^\)]\)//p'
#	if then yes ???
#	next
#	else 
#	poist #deb, #deb-src naub,security, updates
#	if yes ???, to ubrat #
#	else
#	version + add deb-src, deb http:// ... + non-free
#	a.1 search 'contrib /|\ non-free' >> test
#	a.2 if test = 0 ? then 
#	??? nado grep posi, a potom replace with check codename:
#	lsb_version -da
#	a.3 else ok
#
if [[ -n $(sed -n -e "s/^\(1_src_list\).*/\1/p") ]]; then
#
if [[ -z $( lsb_release -d | sed -n -e 's/.*(\([^\)]\+\))/\1/p') ]]; then
#	echo "Error: not defined version DebianOS, wait 3 sec";
	DEB_VER=$( cat /etc/os-release | sed -n -e "s/.*(\([^\)].*\))\"$/\1/p");
	DEB_VER=$(echo $DB | sed -n -e "s/\([a-z]*\)$//p")
else
	DEB_VER=$( lsb_release -d | sed -n -e 's/.*(\([^\)]\+\))/\1/p')
fi;
#
#cd /etc/apt/;
# rm sources.tmp;
#touch sources.tmp
#
#							check null string		???? 		dob add usloviya proverki ft http
#
if [[ -n $( egrep -n '^[a-z] || ^#' sources.list) || -z $( sed -n -e "s/^deb http:\/\/ftp//p" sources.list) || -z $( sed -n -e "s/^deb-src http:\/\/ftp//p" sources.list) || -z $( sed -n -e "s/^deb http:\/\/deb//p" sources.list) || -z $( sed -n -e "s/^deb-src http:\/\/deb//p" sources.list) ]]; then
STATE="1";
rm sources.list;
# touch sources.tmp;
BUF="#deb cdrom:[Debian GNU/Linux _*_ - Official amd64 NETINST 20210814-10:07]/ * main\ndeb http://ftp.debian.org/debian/ $DEB_VER main non-free contrib\ndeb-src http://ftp.debian.org/debian/ $DEB_VER main non-free contrib\n
\ndeb http://security.debian.org/debian-security/ $DEB_VER-security main contrib non-free \ndeb-src http://security.debian.org/debian-security/ $DEB_VER-security main contrib non-free \n
\n# *-updates, to get updates before a point release is made; \r\n# see https://www.debian.org/doc/manuals/debian-reference/ch02.en.html#_updates_and_backports \ndeb http://deb.debian.org/debian/ $DEB_VER-updates main contrib non-free \ndeb-src http://deb.debian.org/debian/ $DEB_VER-updates main contrib non-free \n
\n
# This system was installed using small removable media \n
# (e.g. netinst, live or single CD). The matching \"deb cdrom\" \n
# entries were disabled at the end of the installation process. \n
# For information about how to configure apt package sources, \n
# see the sources.list(5) manual. \n"
echo -e $BUF > sources.list;
echo "Info: sources.list is null";
sleep 1;  # Waits 5 seconds.
# sed -i '34s/AAA/BBB/' file_name
else
#The first part of it is an "address", i.e. the following command only applies to lines matching it. The ! negates the condition, i.e. the command will only be applied to lines not matching the address. So, in other words, Replace Hello by Hello world! on lines that don't contain Hello world!.
# sed -n -e 's/.*bullseye\-[a-z]\(.\)/\1/p' sources.tmp
#The pattern [a-z]* matches zero or more characters in the range a to z (the actual characters are dependent on the current locale). There are zero such characters at the very start of the string 123 abc (i.e. the pattern matches), and also four of them at the start of this is a line.
#If you need at least one match, then use [a-z][a-z]* or [a-z]\{1,\}, or enable extended regular expressions with sed -E and use [a-z]+.
 sed -i -e "s/$DEB_VER\s.*$/$DEB_VER main contrib non-free/g" sources.list
 sed -i -e "s/\(\/\s$DEB_VER\-[a-z]*\).*/\1 main contrib non-free/g" sources.list
fi;

apt-get update &&  apt-get full-upgrade 
if [ $? -ne 0 ]; then
   echo "Error: full upgrade error!!!"
   exit 1
fi

echo -e "1_src_list" >> steps.txt

fi

exit 1;


step_two:
#
if [[ -n $(sed -n -e "s/^\(2_install_driver\).*/\1/p") ]]; then
#
#		1_1_5 Install drivers: install non-free firmware && *-nonfree
# 		??? do make analys 'lspci' and install autochoose driver
#
apt -y install firmware-linux firmware-linux-nonfree firmware-linux firmware-realtek libdrm-amdgpu1 xserver-xorg-video-amdgpu man
if [ $? -ne 0 ]; then
   echo "Error: install driver failed!!!"
   exit 1
fi

fi

echo -e "2_install_driver" >> steps.txt
#
#
if [[ -n $(sed -n -e "s/^\(3_nanorc\).*/\1/p") ]]; then
#
# nano /etc/rc.local
#setupcon
#git clone git://git.savannah.gnu.org/nano.git; cd nano;./autogen.sh;./configure;sudo make install 

apt -y install git
if [ $? -ne 0 ]; then
   echo "Error: error install git!!!"
   exit 1
fi

git clone https://github.com/nanorc/nanorc.git
cd nanorc
make install

cat ~/.nano/syntax/ALL.nanorc
touch ~/.nanorc
echo -e "include ~/.nano/syntax/ALL.nanorc" > ~/.nanorc
rm -Rf /nanorc/
rmdir /nanorc/

fi

echo -e "3_nanorc" >> steps.txt

if [[ -n $(sed -n -e "s/^\(4_copy_sh\).*/\1/p") ]]; then
#
cp -Rf /install/home/rootsu/ /home/rootsu/
cp -Rf /install/home/admin/.bashrc /root/
cp -Rf /install/home/admin/.cmd_shell.sh /root/ 
# cp -Rf /install/home/admin/.bashrc /root/
cp /etc/nanorc ~/.nanorc
#
fi
#
echo -e "4_copy_sh" >> steps.txt
#
#cp -Rf /install/home/ /home/ # -> rootsu, admin
# https://superuser.com/questions/904001/how-to-install-tar-xz-file-in-ubuntu
#apt-get install xz-utils
if [[ -n $(sed -n -e "s/^\(5_install_util_wd\).*/\1/p") ]]; then
#
apt -y install build-essential
if [ $? -ne 0 ]; then
   echo "Error: error install gcc-utils!!!"
   exit 1
fi
add-apt-repository -y ppa:ubuntu-toolchain-r/test && apt update
apt -y install gcc-snapshot && apt -y install gcc-11g++-11
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 60 --slave /usr/bin/g++ g++ /usr/bin/g++-9

apt -y install manpages-dev | apt -y install wpa_supplicant | apt -y install console-setup | apt -y install mc | apt -y install htop
if [ $? -ne 0 ]; then
   echo "Error: error install setup-utils!!!"
   exit 1
fi

#
#	Update settings LOCALE
#
#	locale -a
 update-locale LC_TIME=ru_RU.UTF-8;
 update-locale LC_ALL=ru_RU.UTF-8;
 update-locale LANG=ru_RU.UTF-8;
 sed -n -e "s/\(=\).*/\1\"$ru_RU.UTF-8\"/p" /etc/default/locale
 update-locale;

fi

cp -Rf /install/etc/ /etc/
if [ $? -ne 0 ]; then
   echo "Error: copy install to etc"
   exit 1
fi

echo -e "5_install_util_wd" >> steps.txt
#dpkg -i xz-utils_5.2.4-1_amd64.deb
#tar -xvf wpa_supplicant-0.7.3.tar.gz
#cd ./wpa_supplicant-0.7.3/
#mv /install/.config /install/wpa_supplicant-0.7.3/wpa_supplicant/
#bash make
exit 1;
#tar -xvf console-setup_1.205.tar.xz
#cd ./console-setup-1.205.tar.xz/
#./configure
#./install
#cp -Rf /install/etc/default/console-setup /etc/default/

#
#
#if [ -f /etc/resolv.conf ]; then
#	jumpto STEP_TWO_AFTER;
#fi
step_three:

if [[ -n $(sed -n -e "s/^\(6_settings_interface_with_wifi\).*/\1/p") ]]; then
#		1_1_2	settings network/interfaces
#
#
cd /etc/network/
#
#		1_1_2_1		search interfaces (wifi?)
#
#	#2:	number  
#
# t.k while 1 step s.b. str !0
#
COUNT=1;
NET_EN="START"

while [[ -n $( ip addr | sed -n -e "s/.*$COUNT\:\s\(.*\)\:\s<.*/\1/p") ]]
do
NET_ARR[COUNT]=$( ip addr | sed -n -e "s/.*$COUNT\:\s\(.*\)\:\s<.*/\1/p");
  echo Counter: $COUNT $NET_EN;
  ((COUNT++));
done

COUNT=0;

#search index arr for WIFI[COUNT] and NETEN[COUNT]
for COUNT in ${NET_ARR[@]}
do
	if [[ -n $(echo $NET_ARR[$COUNT] | sed -n -e 's/en\(.*\).*/\1/p') ]]; then
		NET_EN=$COUNT;
	fi
	if [[ -n $(echo $NET_ARR[$COUNT] | sed -n -e 's/wl\(.*\).*/\1/p') ]]; then
		NET_WI=$COUNT;
	fi
done

COUNT=0;

if [[ -n NET_EN && -n NET_WI ]]; then
	STATE="0";
elif [[ -n NET_EN ]]; then
	STATE="1";
else 
	echo "Error: not search lan interfaces";
	sleep 1;
	exit 2;
fi;
#
# state => "1" add interfaces only en_*!!!
# state => "0" all ok
# interfaces.back - zamenit bez .back
#
# proverka interfaces
#
#	Jump to label interface_sh
#
#
#		
#		1_1_2_2		Settings /etc/network -> interfaces 
#
#
cd /etc/network/
#
if [[ -z $( egrep -n '^[a-z] || ^#' interfaces) ]]; then
BUF="# This file describes the network interfaces available on your system\n
# and how to activate them. For more information, see interfaces(5).\n
\n
source /etc/network/interfaces.d/*\n
\n
# The loopback network interface\n
auto lo\n
iface lo inet loopback\n
\n
# The Primary\n
allow-hotpluging en\n
iface en inet dhcp\n";
echo -e $BUF > interfaces;
fi
# cat interfaces.back
# analys set en wifi to two branch
# create interfaces.tmp c orig
# empty? yes - add svoi, else search 'source' 'allow' 'iface' +append_wpa
# search source and return number line $begin
#BEGIN="0"
#END="0";
#		mojet nay4itca kak udalit ostalnye stroki?
# https://www.baeldung.com/linux/bash-count-lines-in-file
# sed -r -e '/[a-z]\/+{1,}\*/=' < interfaces.back
# sed -r -e '/.*\/+\{1,\}/ { =;  q; }' < interfaces.back
# echo -e "abc\n\rta\n123456789" | sed -r -e '/.*[0-9]/{1,/}/'
# sed -r -e '/[a-z]\/+{1,}\*/{=;q;}' interfaces.back
#
#	-1
#
# https://www.gnu.org/software/sed/manual/html_node/Regular-Expressions.html
# str /sources/
#COUNT=$(($( sed -r -e '/[a-z]\/+{1,}\*/{=;q;}' interfaces.back | sed -n '$=')-1));
if [[ STATE\="0" ]]; then
	
if (($(($( sed -r -e '/[a-z]\/+{1,}\*/{=;q;}' interfaces | sed -n '$=')-1))==0)); then
		jumpto interface_sh;
fi
# str auto
if [[-z $( sed -n -e "s/\(auto\s\).*/\1$NET_ARR[$NET_WI]\s$NET_ARR[$NET_EN]/p" interfaces) ]]
		jumpto interface_sh;
fi
# str iface NET_EN
if [[-z $( sed -n -e "s/\(iface\s\).*/\1$NET_ARR[$NET_EN] inet dhcp/p" interfaces) ]]
		jumpto interface_sh;
fi
# str allow-hotplug
if [[-z $( sed -n -e "s/\(allow.*\s\).*/\1$NET_ARR[$NET_WIFI]\sinet\sdhcp/p" interfaces) ]]
		jumpto interface_sh;
fi
# str iface NET_WI
if [[-z $( sed -n -e "s/\(iface\s\).*/\1$NET_ARR[$NET_WIFI] inet dhcp/p" interfaces) ]]
		jumpto interface_sh;
#
 sed '$a	wpa-conf \/home\/rootsu\/wpa_supplicant.conf' interfaces >> interfaces;

else
if (($(($( sed -r -e '/[a-z]\/+{1,}\*/{=;q;}' interfaces.back | sed -n '$=')-1))==0)); then
		jumpto interface_sh;
fi
# str auto
if [[-z $( sed -n -e "s/\(auto\s\).*/\1$NET_ARR[$NET_WI]\s$NET_ARR[$NET_EN]/p" interfaces) ]]
		jumpto interface_sh;
fi
# str iface NET_EN
if [[-z $( sed -n -e "s/\(iface\s\).*/\1$NET_ARR[$NET_EN] inet dhcp/p" interfaces) ]]
		jumpto interface_sh;
fi
# str allow-hotplug
if [[-z $( sed -n -e "s/\(allow.*\s\).*/\1$NET_ARR[$NET_WIFI]\sinet\sdhcp/p" interfaces) ]]
		jumpto interface_sh;
fi
#	
#		1_1_2_3		restart service
#
 systemctl restart wpa_supplicant@$NET_ARR[$NET_WI]
 service network restart
 
fi

echo -e "6_settings_interface_with_wifi" >> steps.txt

#Search 
# add-apt-repository ppa:un-brice/ppa
# apt-get update
# apt-get install shake-fs
step_four:

if [[ -n $(sed -n -e "s/^\(7_driver_opt\).*/\1/p") ]]; then
#
#		1_1_3	create disk /opt/
#
#		1_1_3_1 search /dev/s**
#
cd ~/
touch txt;
touch txt
 fdisk -l > txt
STATE=$( sed -n -e "s/\(\/dev\/s[a-z]*[0-9]\).*/\1/p" txt);

if [[ -z STATE ]]; then
	STATE=$( sed -n -e "s/\(\/dev\/s[a-z]\).*/\1/p" txt);
else
	exit 3;
fi


#		1_1_3_2 create disk /dev/s**
#
# https://www.computerhope.com/unix/fdisk.htm
# https://superuser.com/questions/332252/how-to-create-and-format-a-partition-using-a-bash-script
#
#	OPTIONS: g , w
#
echo "\ng\nn\n1\n2048\n\nw" |  fdisk $STATE --wipe AUTO 

#
#	Create fs
#
mkfs.ext4 $STATE /opt
#
fi
#
echo -e "7_driver_opt" >> steps.txt

#
##  in-target mkfs.ext4 /dev/sdb1 ; \
#  in-target echo "/dev/sdb1  /srv  ext4  nodiratime  0  2" >> /etc/fstab
#			???
#	fdisk
#	mkfs
#
#
#		1_1_4	editor /etc/apt/sources.list
#		add info ro "contrib non-free|
#	
#		copy sources.list -> sources.tmp
#

#	https://www.baeldung.com/linux/run-script-on-startup
#
cp /install/pii2.sh /etc/init.d/
chkconfig --add pii2.sh
update-rc.d pii2.sh defaults
#
touch /install/step_two.txt
#
#	Posle del!!!
# https://serverfault.com/questions/32438/disable-a-service-from-starting-at-all-runlevels
#
echo "Press ESC key to quit and reboot"
# read a single character
while read -r -n1 key
do
# if input == ESC key
if [[ $key == $'\e' ]];
then
fi
	reboot;
	exit 5;
done
#
#	Jump to label interface_sh
#
STEP_TWO_AFTER:
#
#
 rm /install/pii2.sh /etc/init.d/
update-rc.d -f pii2.sh remove
#
#	 cp sources.tmp sources.list;
#
#			1_1_6 Create users and groups
#           1.1.6 Создание пользователей и групп
#
#
 groupadd -g 1000 admin
 groupadd -g 2000 exp_users
 groupadd -g 3000 pro_users
 groupadd -g 4000 moderator
 groupadd -g 5000 technics
 groupadd -g 6000 users
 groupadd -g 7000 other
# user add 
 useradd -u 1100 -g admin -c "admin" -p "debian" admin,
 useradd -u 2100 -g exp_users -c "far_exp" -p "debian" far_exp
 useradd -u 3100 -g pro_users -c "far_pro" -p "debian" far_pro
 useradd -u 4100 -g moderator -c "far_moderator" -p "debian" far_mod
 useradd -c "admin_share" -g technics -u 5100 -M -s /usr/sbin/nologin --ingroup technical admin_share
 useradd -c "pub_share" -g technics -u 5200 -M -s /usr/sbin/nologin --ingroup technical pub_share
 useradd -u 6100 -g users -M -c "far_user" -p "debian" far_user
 cmd -p "ssh_crset" -ua "admin" -ga "admin" -p "12345678"

mkdir /opt/SAMBA_SHARE/
 chown :technical /opt/SAMBA_SHARE
 chmod ug+rw /opt/SAMBA_SHARE


cp -Rf /install/home/admin/.bashrc /home/admin/
cp -Rf /install/home/admin/.cmd_shell.sh /home/admin/
#
#		1_1_7 Create ssh_ssl
# 		1_1_7_1 Install ssh && settings
#
cd /etc/ssh/

cp ssh_config ssh_config.tmp
#
# #Port 22
#
 sed -i -e "s/#Port\s.*$\|Port\s.*$/Port $PORT_SSH/g" sshd_config
#
# #HostKey
#
 sed -i -e "s/#HostKey\s.*\|HostKey\s.*/HostKey/g" sshd_config
#
# #SysLogFacility
#
 sed -i -e "s/#SysLogFacility\s.*$\|SysLogFacility\s.*$/SysLogFacility AUTHPRIV/g" sshd_config
#
# #LogLevel
#
 sed -i -e "s/#LogLevel\s.*$\|LogLevel\s.*$/SysLogFacility AUTHPRIV/g" sshd_config
#
# #LogLevel
#
 sed -i -e "s/#LoginGraceTime\s.*$\|LoginGraceTime\s.*$/LoginGraceTime 2m/g" sshd_config
#
# #PermitRootLogin
#
 sed -i -e "s/#PermitRootLogin\s.*$\|PermitRootLogin\s.*$/PermitRootLogin yes/g" sshd_config
#
# #StrictModes
#
 sed -i -e "s/#StrictModes\s.*$\|StrictModes\s.*$/StrictModes no/g" sshd_config
#
# #MaxAuthTries
#
 sed -i -e "s/#MaxAuthTries\s.*$\|MaxAuthTries\s.*$/MaxAuthTries 3/g" sshd_config
#
# #MaxAuthTries
#
 sed -i -e "s/#MaxSessions\s.*$\|MaxSessions\s.*$/MaxSessions 3/g" sshd_config
#
# #PubkeyAuthentification
#
 sed -i -e "s/#PubkeyAuthentification\s.*$\|PubkeyAuthentification\s.*$/PubkeyAuthentification yes/g" sshd_config
#
# #AuthorizedKeysFile
#
 sed -i -e "s/#AuthorizedKeysFile\s.*$\|AuthorizedKeysFile\s.*$/AuthorizedKeysFile \/home\/rootsu\/.ssh\/authorized_keys \/home\/%u\/.ssh\/authorized_keys/g" sshd_config
#
# #PasswordAuthentication no
#
 sed -i -e "s/#PasswordAuthentication\s.*$\|PasswordAuthentication\s.*$/PasswordAuthentication no/g" sshd_config
#
# #PermitEmptyPasswords no
#
 sed -i -e "s/#PermitEmptyPasswords\s.*$\|PermitEmptyPasswords\s.*$/PermitEmptyPasswords no/g" sshd_config
#
# #ChallengeResponseAuthentification
#
# sed -n -e "s/ChallengeResponseAuthentication.*$\|#ChallengeResponseAuthentication.*$/ChallengeResponseAuthentification yes/p" sshd_config.tmp
 sed -i -e "s/ChallengeResponseAuthentication.*$\|#ChallengeResponseAuthentication.*$/ChallengeResponseAuthentification yes/g" sshd_config
#
# #UsePAM yes
#
# sed -n -e "s/#UsePAM\s.*$\|UsePAM\s.*$/UsePAM yes/p" sshd_config.tmp
 sed -i -e "s/#UsePAM\s.*$\|UsePAM\s.*$/UsePAM yes/g" sshd_config
#
# #AllowTcpForwarding yes
#
 sed -i -e "s/#AllowTcpForwarding\s.*$\|AllowTcpForwarding\s.*$/AllowTcpForwarding yes/g" sshd_config
#
# #X11Forwarding yes
#
 sed -i -e "s/#X11Forwarding\s.*$\|X11Forwarding\s.*$/X11Forwarding yes/g" sshd_config
#
# #X11DisplayOffset yes
#
 sed -i -e "s/#X11DisplayOffset\s.*$\|X11DisplayOffset\s.*$/X11DisplayOffset 10/g" sshd_config
#
# #PrintMotd no
#
 sed -i -e "s/#PrintMotd\s.*$\|PrintMotd\s.*$/PrintMotd yes/g" sshd_config
#
# # Subsystem 
#
 sed -i -e "s/Subsystem\s.*$/# Subsystem\s.*$/g" sshd_config
#
#
#		1_1_8 Create SAMBA
#
#
apt-get install cifs-utils
apt-get install samba
apt-get install smbfs

mount -v -t cifs //FARID_IOTWIFIST/SOFT_2TBSEAGREEN/  /mnt/FARID_IOTWIFIST_DATA/ -o credentials=/home/rootsu/.smbusers;
mount -v -t cifs //FARID_IOTWIFIST/SOFT_3TBSEASYAN/  /mnt/FARID_IOTWIFIST_DATA/ -o credentials=/home/rootsu/.smbusers;

cp -Rf /install/etc/autofs /etc/autofs
cp -Rf /install/etc/samba /etc/samba

service smbd restart

#		1_1_7_1 Install and settings firewall ?

#		1_1_8 Install other soft

 apt install whois
 apt install mkpasswd


#		1_1_8_1 Extended nano (non autosettings)
cp /install/nanorc /etc/nanorc

#		1_1_8_2 cp ers (non autosettings)
cp /install/ers /etc/ers

 echo -e "y" | apt-get install ntfs-3g;

rm /install/step_two.txt

echo "Press ESC key to quit"
# read a single character
while read -r -n1 key
do
# if input == ESC key
if [[ $key == $'\e' ]];
then
break;
fi
set +x
#ls -la
exit 0;
