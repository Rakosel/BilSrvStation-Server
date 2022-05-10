#!/bin/bash -xv
#
#		AUTO 	POSTINSTALL		1.1.4a
#	octanovilca na SSL + po4initb script cmd
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
#
# 		+ install wpa_supplicant-0.7.3.tar.gz
#
#
set -x
export LC_ALL=ru_RU.UTF-8
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
#
#
if [ -f /etc/resolv.conf ]; then
	jumpto STEP_TWO_AFTER;
fi
#
#
#
# include this boilerplate
#
#	https://stackoverflow.com/questions/9639103/is-there-a-goto-statement-in-bash
#
function jumpto
{
    label=$1
    cmd=$(sed -n "/$label:/{:a;n;p;ba};" $0 | grep -v ':$')
    eval "$cmd"
    exit
}
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
  echo "сейчас будут установлены postinstall настройка"
  echo
  
PS3="Выберите операцию: "

select opt in Auto PoluAuto Hands Exit; do

  case $opt in
    Auto)
		echo -n "Сейчас будет произведена автоматическая найстройка ";
		sleep 3;
      ;;
    PoluAuto)
		echo -n "В разработке...";
      ;;
    Hands)
		echo -n "В разработке...";
      ;;
    Exit)
      break
      ;;
    *) 
      echo "Недопустимая опция $REPLY";
      ;;
  esac
done
#
#
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

while [[ -n $(sudo ip addr | sed -n -e "s/.*$COUNT\:\s\(.*\)\:\s<.*/\1/p") ]]
do
NET_ARR[COUNT]=$(sudo ip addr | sed -n -e "s/.*$COUNT\:\s\(.*\)\:\s<.*/\1/p");
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
# !!! install wpasupplicant from /install/
#proverka usloviy
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
interface_sh:
#
#		
#		1_1_2_2		Settings /etc/network -> interfaces 
#
#
cd /etc/network/
#
if [[ -z $(sudo egrep -n '^[a-z] || ^#' interfaces.back) ]]; then
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
echo -e $BUF > interfaces.back;
fi
#sudo cat interfaces.back
# analys set en wifi to two branch
# create interfaces.tmp c orig
# empty? yes - add svoi, else search 'source' 'allow' 'iface' +append_wpa
# search source and return number line $begin
#BEGIN="0"
#END="0";
#		mojet nay4itca kak udalit ostalnye stroki?
# https://www.baeldung.com/linux/bash-count-lines-in-file
#sudo sed -r -e '/[a-z]\/+{1,}\*/=' < interfaces.back
#sudo sed -r -e '/.*\/+\{1,\}/ { =;  q; }' < interfaces.back
#sudo echo -e "abc\n\rta\n123456789" | sed -r -e '/.*[0-9]/{1,/}/'
#sudo sed -r -e '/[a-z]\/+{1,}\*/{=;q;}' interfaces.back
#
#	-1
#
# https://www.gnu.org/software/sed/manual/html_node/Regular-Expressions.html
# str /sources/
#COUNT=$(($(sudo sed -r -e '/[a-z]\/+{1,}\*/{=;q;}' interfaces.back | sed -n '$=')-1));
if [[ STATE\="0" ]]; then
	
if (($(($(sudo sed -r -e '/[a-z]\/+{1,}\*/{=;q;}' interfaces.back | sed -n '$=')-1))==0)); then
		jumpto interface_sh;
fi
# str auto
if [[-z $(sudo sed -n -e "s/\(auto\s\).*/\1$NET_ARR[$NET_WI]\s$NET_ARR[$NET_EN]/p" interfaces.back) ]]
		jumpto interface_sh;
fi
# str iface NET_EN
if [[-z $(sudo sed -n -e "s/\(iface\s\).*/\1$NET_ARR[$NET_EN] inet dhcp/p" interfaces.back) ]]
		jumpto interface_sh;
fi
# str allow-hotplug
if [[-z $(sudo sed -n -e "s/\(allow.*\s\).*/\1$NET_ARR[$NET_WIFI]\sinet\sdhcp/p" interfaces.back) ]]
		jumpto interface_sh;
fi
# str iface NET_WI
if [[-z $(sudo sed -n -e "s/\(iface\s\).*/\1$NET_ARR[$NET_WIFI] inet dhcp/p" interfaces.back) ]]
		jumpto interface_sh;
#
sudo sed '$a	wpa-conf \/home\/rootsu\/wpa_supplicant.conf' interfaces.back >> interfaces.back;

else
if (($(($(sudo sed -r -e '/[a-z]\/+{1,}\*/{=;q;}' interfaces.back | sed -n '$=')-1))==0)); then
		jumpto interface_sh;
fi
# str auto
if [[-z $(sudo sed -n -e "s/\(auto\s\).*/\1$NET_ARR[$NET_WI]\s$NET_ARR[$NET_EN]/p" interfaces.back) ]]
		jumpto interface_sh;
fi
# str iface NET_EN
if [[-z $(sudo sed -n -e "s/\(iface\s\).*/\1$NET_ARR[$NET_EN] inet dhcp/p" interfaces.back) ]]
		jumpto interface_sh;
fi
# str allow-hotplug
if [[-z $(sudo sed -n -e "s/\(allow.*\s\).*/\1$NET_ARR[$NET_WIFI]\sinet\sdhcp/p" interfaces.back) ]]
		jumpto interface_sh;
fi
#	
#		restart service
#
sudo systemctl restart wpa_supplicant@$NET_ARR[$NET_WI]
sudo service network restart

#Search 
#sudo add-apt-repository ppa:un-brice/ppa
#sudo apt-get update
#sudo apt-get install shake-fs

#
#		1_1_3	create disk /opt/
#
#		1_1_3_1 search /dev/s**
#
cd ~/
touch txt;
touch txt
sudo fdisk -l > txt
STATE=$(sudo sed -n -e "s/\(\/dev\/s[a-z]*[0-9]\).*/\1/p" txt);

if [[ -z STATE ]]; then
	STATE=$(sudo sed -n -e "s/\(\/dev\/s[a-z]\).*/\1/p" txt);
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
sudo fdisk $STATE --wipe AUTO 
echo "\ng\nn\n1\n2048\n\nw"
#
#	Create fs
#
mkfs.ext4 $STATE /opt
#
#
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
cd /etc/apt/
cp sources.list sources.tmp

# &VERSION_DEBIAN -e mojno off
#lsb_release -d | sed -n -e 's/.*(\([^\)]\+\))/\1/p'

# egrep '^[a-z]' sources.list
#sudo sed -i 's/#deb-src http/deb-src http/g' sources.list
#sudo sed -i 's/#deb http/deb http/g' sources.list
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
#
if [[ -z $(sudo lsb_release -d | sed -n -e 's/.*(\([^\)]\+\))/\1/p') ]]; then
	echo "Error: not defined version DebianOS, wait 3 sec";
	sleep 3;
	exit 0;  # Waits 5 seconds.
fi;
#
#cd /etc/apt/;
#sudo rm sources.tmp;
#touch sources.tmp
#
#							check null string		???? 		dob add usloviya proverki ft http
#
if [[ -z $(sudo egrep -n '^[a-z] || ^#' sources.tmp) ]]; then
STATE="1";
#sudo rm sources.tmp;
#sudo touch sources.tmp;
BUF="#deb cdrom:[Debian GNU/Linux _*_ - Official amd64 NETINST 20210814-10:07]/ * main\n#deb http://ftp.debian.org/debian/ $DEB_VER main non-free contrib\n#deb-src http://ftp.debian.org/debian/ $DEB_VER main non-free contrib\n
\n#deb http://security.debian.org/debian-security/ $DEB_VER-security main contrib non-free \n#deb-src http://security.debian.org/debian-security/ $DEB_VER-security main contrib non-free \n
\n# *-updates, to get updates before a point release is made; \r\n# see https://www.debian.org/doc/manuals/debian-reference/ch02.en.html#_updates_and_backports \n#deb http://deb.debian.org/debian/ $DEB_VER-updates main contrib non-free \n#deb-src http://deb.debian.org/debian/ $DEB_VER-updates main contrib non-free \n
\n
# This system was installed using small removable media \n
# (e.g. netinst, live or single CD). The matching \"deb cdrom\" \n
# entries were disabled at the end of the installation process. \n
# For information about how to configure apt package sources, \n
# see the sources.list(5) manual. \n"
echo -e $BUF > sources.tmp;
echo "Info: sources.list is null";
sleep 1;  # Waits 5 seconds.
# sed -i '34s/AAA/BBB/' file_name
else
#The first part of it is an "address", i.e. the following command only applies to lines matching it. The ! negates the condition, i.e. the command will only be applied to lines not matching the address. So, in other words, Replace Hello by Hello world! on lines that don't contain Hello world!.
#sudo sed -n -e 's/.*bullseye\-[a-z]\(.\)/\1/p' sources.tmp
#The pattern [a-z]* matches zero or more characters in the range a to z (the actual characters are dependent on the current locale). There are zero such characters at the very start of the string 123 abc (i.e. the pattern matches), and also four of them at the start of this is a line.
#If you need at least one match, then use [a-z][a-z]* or [a-z]\{1,\}, or enable extended regular expressions with sed -E and use [a-z]+.
sudo sed -n -e "s/$DEB_VER\s.*$/$DEB_VER main contrib non-free/p" sources.tmp
sudo sed -n -e "s/\(\/\s$DEB_VER\-[a-z]*\).*/\1 main contrib non-free/p" sources.tmp

fi;

sudo apt-get update && sudo apt-get full-upgrade 
apt-get install man
#
#
#		1_1_5 Install drivers: install non-free firmware && *-nonfree
# 		??? do make analys 'lspci' and install autochoose driver
#
sudo apt-get install firmware-linux firmware-linux-nonfree firmware-linux firmware-realtek	libdrm-amdgpu1 xserver-xorg-video-amdgpu
#
#
reboot
#	https://www.baeldung.com/linux/run-script-on-startup
#
sudo cp /install/pii2.sh /etc/init.d/
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
reboot;
fi
	exit 5;
done
#
#	Jump to label interface_sh
#
STEP_TWO_AFTER:
#
#
sudo rm /install/pii2.sh /etc/init.d/
update-rc.d -f pii2.sh remove
#
#	sudo cp sources.tmp sources.list;
#
#		1_1_6_1 Create users
#
#
sudo groupadd -g 1000 admin
sudo groupadd -g 2000 exp_users
sudo groupadd -g 3000 pro_users
sudo groupadd -g 4000 moderator
sudo groupadd -g 5000 technics
sudo groupadd -g 6000 users
sudo groupadd -g 7000 other
# user add 
sudo useradd -u 1100 -G admin -c "admin" -p "" admin
sudo useradd -u 2100 -g exp_users -c "far_exp" -p "" far_exp
sudo useradd -u 3100 -g pro_users -c "far_pro" -p "" far_pro
sudo useradd -u 4100 -g moderator -c "far_moderator" -p "" far_mod
sudo useradd -u 5100 -g technics -M -c "pub_share" -p "" pub_share
sudo useradd -u 5200 -g technics -M -c "admin_share" -p "" admin_share
sudo useradd -u 6100 -g users -M -c "far_user" -p "" far_user
#
#		1_1_6_2 Create ssh_ssl
#
#
# 		1_1_6_3 Install ssh && settings

apt-get install openssh-client openssh-server -y
cd /etc/ssh
rm -Rf ssh_host_*
#
# #Port 22
#
sudo sed -n -e "s/#Port\s.*$\|Port\s.*$/Port $PORT_SSH/p" sshd_config.tmp >> sshd_config.tmp
#
# #HostKey
#
sudo sed -n -e "s/#HostKey\s.*\|HostKey\s.*/HostKey/p" sshd_config.tmp
#
# #SysLogFacility
#
sudo sed -n -e "s/#SysLogFacility\s.*$\|SysLogFacility\s.*$/SysLogFacility AUTHPRIV/p" sshd_config.tmp
#
# #LogLevel
#
sudo sed -n -e "s/#LogLevel\s.*$\|LogLevel\s.*$/SysLogFacility AUTHPRIV/p" sshd_config.tmp
#
# #LogLevel
#
sudo sed -n -e "s/#LoginGraceTime\s.*$\|LoginGraceTime\s.*$/LoginGraceTime 2m/p" sshd_config.tmp
#
# #PermitRootLogin
#
sudo sed -n -e "s/#PermitRootLogin\s.*$\|PermitRootLogin\s.*$/PermitRootLogin yes/p" sshd_config.tmp
#
# #StrictModes
#
sudo sed -n -e "s/#StrictModes\s.*$\|StrictModes\s.*$/StrictModes no/p" sshd_config.tmp
#
# #MaxAuthTries
#
sudo sed -n -e "s/#MaxAuthTries\s.*$\|MaxAuthTries\s.*$/MaxAuthTries 3/p" sshd_config.tmp
#
# #MaxAuthTries
#
sudo sed -n -e "s/#MaxSessions\s.*$\|MaxSessions\s.*$/MaxSessions 3/p" sshd_config.tmp
#
# #PubkeyAuthentification
#
sudo sed -n -e "s/#PubkeyAuthentification\s.*$\|PubkeyAuthentification\s.*$/PubkeyAuthentification yes/p" sshd_config.tmp
#
# #AuthorizedKeysFile
#
sudo sed -n -e "s/#AuthorizedKeysFile\s.*$\|AuthorizedKeysFile\s.*$/AuthorizedKeysFile \/home\/rootsu\/.ssh\/authorized_keys \/home\/%u\/.ssh\/authorized_keys/p" sshd_config.tmp
#
# #PasswordAuthentication no
#
sudo sed -n -e "s/#PasswordAuthentication\s.*$\|PasswordAuthentication\s.*$/PasswordAuthentication no/p" sshd_config.tmp
#
# #PermitEmptyPasswords no
#
sudo sed -n -e "s/#PermitEmptyPasswords\s.*$\|PermitEmptyPasswords\s.*$/PermitEmptyPasswords no/p" sshd_config.tmp
#
# #ChallengeResponseAuthentification
#
#sudo sed -n -e "s/ChallengeResponseAuthentication.*$\|#ChallengeResponseAuthentication.*$/ChallengeResponseAuthentification yes/p" sshd_config.tmp
sudo sed -i -e "s/ChallengeResponseAuthentication.*$\|#ChallengeResponseAuthentication.*$/ChallengeResponseAuthentification yes/" sshd_config.tmp
#
# #UsePAM yes
#
#sudo sed -n -e "s/#UsePAM\s.*$\|UsePAM\s.*$/UsePAM yes/p" sshd_config.tmp
sudo sed -i -e "s/#UsePAM\s.*$\|UsePAM\s.*$/UsePAM yes/" sshd_config.tmp
#
# #AllowTcpForwarding yes
#
sudo sed -n -e "s/#AllowTcpForwarding\s.*$\|AllowTcpForwarding\s.*$/AllowTcpForwarding yes/p" sshd_config.tmp
#
# #X11Forwarding yes
#
sudo sed -n -e "s/#X11Forwarding\s.*$\|X11Forwarding\s.*$/X11Forwarding yes/p" sshd_config.tmp
#
# #X11DisplayOffset yes
#
sudo sed -n -e "s/#X11DisplayOffset\s.*$\|X11DisplayOffset\s.*$/X11DisplayOffset 10/p" sshd_config.tmp
#
# #PrintMotd no
#
sudo sed -n -e "s/#PrintMotd\s.*$\|PrintMotd\s.*$/PrintMotd yes/p" sshd_config.tmp
#
# # Subsystem 
#
sudo sed -n -e "s/Subsystem\s.*$/# Subsystem\s.*$/p" sshd_config.tmp
#
#
#
# 		1_1_6_4 Add user with script 'cmd.sh'

#		1_1_7 Create SAMBA
#
#


#		1_1_7 Install other soft

#		1_1_7_1 Extended nano

sudo echo -e "y" | apt-get install ntfs-3g;


set +x

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

#ls -la
exit 0;
