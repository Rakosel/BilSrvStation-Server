#!/bin/bash
#-xv
#set -x
# https://wiki.debian.org/Microcode
# http://hilite.me/ code->html
#<--! uncomment #639!!!!
#if [[ -z $STATE ]]; then
#	exit 3;
#fi
# user add 
# echo "vkd174asqd" | mkpasswd -s -H MD5
# sudo usermod -p $(echo "" | mkpasswd -s -H MD5) test1
# sudo usermod -p $S test1
# su -p test1
#!-->
# 
#<--!
#			01	AUTO POSTINSTALL
# octanovilca na SSL + po4initb script cmd
# warning!!! do postinstall copy wufu & wpa_supplicant.conf + SAMBA
#
#			01.01	PRE-INSTALL EMV AND SETTINGS
#
#d-i preseed/late_command string mkdir -p /target/install/; cp -R /install/* /target/install/; cp -Rf /install/lib/ /target/lib/;
#
#cd /install/
#tar -xvf wpa_supplicant-0.7.3.tar.gz
#cd ./wpa_supplicant-0.7.3/
#./configure
#./install
#!-->
#<--!
# include this boilerplate
#
#	https://stackoverflow.com/questions/9639103/is-there-a-goto-statement-in-bash
#	# GOTO for bash, based upon https://stackoverflow.com/a/31269848/5353461
#
# rm /install/pii2.sh /etc/init.d/
#update-rc.d -f pii2.sh remove
#!-->

function jumpto
{
    label=$1
    cmd=$(sed -n "/$label:/{:a;n;p;ba};" $0 | grep -v ':$')
    eval "$cmd"
    exit
}
function reinterfaces
{
cd /etc/network/

#<--!
#
#if [[ -n $( egrep -n '^[a-z] || ^#' interfaces) && TMPS=="0" ]]; then
#!-->
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
	allow-hotplug en\n
	iface en inet dhcp\n";
rm interfaces
touch interfaces
echo -e $BUF > interfaces;
}

start=${1:-"start"}
interface_sh=${2:-"interface_sh"}
step_one=${3:-"step_one"}
step_two=${4:-"step_two"}
step_three=${5:-"step_three"}
#<--!
# 		+ install wpa_supplicant-0.7.3.tar.gz
#!-->
export LC_ALL=ru_RU.UTF-8
FILES="steps.txt"
BUF="";
TMPS="";
COUNT=0;
DEB_VER="";
NET_EN="";
NET_WI="";
STATE="0";
PORT_SSH="4103"
NET_ARR=();
#<--!
#			01.02	CHECK ROOT PRIVILEGE
#!-->

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
#<--!
#https://askubuntu.com/questions/1705/how-can-i-create-a-select-menu-in-a-shell-script
#options=("Option 1" "Option 2" "Option 3" "Quit")
#select opt in "${options[@]}"
#!-->
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

#<--!
#  Проверка отдельных переменных окружения.
#  Если переменная, к примеру $USER, не установлена,
#+ то выводится сообщение об ошибке.
#!-->
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
  echo "Сейчас будет установлена postinstall настройка"
  echo

cd /etc/apt/
cp sources.list sources.tmp
#<--!
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
#			01.03	SETTINGS /ETC/NETWORK -> INTERFACES [interface_sh]
#!-->
TMPS="0";
interface_sh:

cd /install/
if [[ -z $(sed -n -e "s/^\(1_settings_interface_with_wifi\).*/\1/p" steps.txt) ]]; then
#<--!
#			01.03.01	SETTINGS NETWORK/INTERFACES
#
#!-->
cd /etc/network/
#<--!
#			01.03.02	SEARCH INTERFACES (WIFI?)
#
#	#2:	number  
#!-->
if [[ ! -f /etc/network/interfaces ]]; then
	touch interfaces
fi
#
cp interfaces interfaces.back 
#<--!
# t.k while 1 step s.b. str !0
#!-->
COUNT=1;
NET_EN=""

while [[ -n $( ip addr | sed -n -e "s/.*$COUNT\:\s\(.*\)\:\s<.*/\1/p") ]]
do
NET_ARR[COUNT]=$( ip addr | sed -n -e "s/.*$COUNT\:\s\(.*\)\:\s<.*/\1/p");
  echo Counter: $COUNT $NET_EN;
  ((COUNT++));
done

COUNT=0;
#<--!
#search index arr for WIFI[COUNT] and NETEN[COUNT]
#!-->
for COUNT in ${NET_ARR[@]}
do
	if [[ -n $(echo $NET_ARR[$COUNT] | sed -n -e 's/en\(.*\).*/\1/p') ]]; then
		NET_EN=$COUNT;
	fi
	if [[ -n $(echo $NET_ARR[$COUNT] | sed -n -e 's/wl\(.*\).*/\1/p') ]]; then
		NET_WI=$COUNT;
	fi
done

COUNT="0";

if [[ -n $NET_EN && -n $NET_WI ]]; then
	STATE="0";
elif [[ -n $NET_EN ]]; then
	STATE="1";
else 
	echo "Error: not search lan interfaces";
	sleep 1;
	exit 2;
fi;
#<--!
# state => "1" add interfaces only en_*!!!
# state => "0" all ok
# interfaces.back - zamenit bez .back
#
# proverka interfaces
#
#	Jump to label interface_sh
#!-->
if [[ -z $( egrep -n '^[a-z] || ^#' interfaces) && $TMPS -eq "0" ]]; then
reinterfaces
fi
#<--!
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
#if [[ $(($( sed -r -e '/[a-z]\/+{1,}\*/{=;q;}' interfaces | sed -n '$=')-1)) == "0" ]]; then

#if [[ $(sed -n -e "$=;" interfaces) == "0" ]]; then
#		TMPS="1";
#		jumpto interface_sh;
#fi
#!-->
TMPS="1";
#<--!
#sed -n -e "s/rsa_cert_file=.*$\|#rsa_cert_file=.*$/rsa_cert_file=\/ssl\/certs\/vsftpd.crt/p" vsftpd.conf
#!-->
if [[ $STATE -eq "0" ]]; then
#<--!
#source /etc/network/interfaces.d/*\n
# str auto $( sed -n -e "s/\(auto\s\).*/\1$NET_ARR[$NET_WI]\s$NET_ARR[$NET_EN]/p"
#!-->
if [[ -z $(sed -n -e "s/\(source \/etc\/network\/interfaces/\\).*/\1/p" interfaces) ]]; then
		TMPS="1";
		reinterfaces;
fi

if [[ -z $(sed -n -e "s/\(auto\slo\).*/\1/p" interfaces) ]]; then
		TMPS="1";
		reinterfaces;
fi
sed -i -e "s/\(auto\s\).*/\1$NET_WI $NET_EN/g" interfaces
#<--!
# str iface NET_EN
#!-->
if [[ -z $( sed -n -e "s/\(iface\slo\).*/\1/p" interfaces) ]]; then
		TMPS="1";
		reinterfaces;
fi
#<--!
#TMPS=$(sed -n -e "/\(iface\slo\).*/{=;q;}" interfaces)
#sed -i -e "$TMPS s/\(iface\s\).*/\1$NET_EN inet dhcp/g" interfaces
#!-->
sed -i -e "s/iface\slo.*/iface $NET_EN inet dhcp/g" interfaces
#<--!
# str allow-hotplug
#!-->
if [[ -z $( sed -n -e "s/\(allow-hotplug\s\).*/\1/p" interfaces) ]]; then
		TMPS="1";
		reinterfaces;
fi
sed -i -e "s/\(allow-hotplug\s\).*/\1$NET_WI/g" interfaces
#<--!
# str iface NET_WI
#!-->
if [[ -z $( sed -n -e "s/\(iface\s\).*/\1/p" interfaces) ]]; then
		TMPS="1";
		reinterfaces;
fi
#<--!
# str auto
#TMPS=$(sed -n -e "/\(iface\s[en]\).*/{=;q;}" interfaces)
#!-->
sed -i -e "$a s/\(iface\s\).*/\1$NET_WI inet dhcp/g" interfaces
#<--!
#sed -n -e "s/\(iface\s[en]\).*/\1$NET_ARR[$NET_WI] inet dhcp/g" interfaces
#!-->
sed '$a	wpa-conf \/home\/rootsu\/wpa_supplicant.conf' interfaces >> interfaces;
#<--!
#if [[-z $( sed -n -e "s/\(auto\s\).*/\1/p" interfaces) ]]; then
#	jumpto interface_sh;
#fi
#systemctl restart wpa_supplicant@$NET_ARR[$NET_WI]
#!-->
systemctl restart wpa_supplicant
#<--!
#sed -n -e "s/\(auto\s\).*/\1$NET_ARR[$NET_WI]\s$NET_ARR[$NET_EN]/g" interfaces
# str iface NET_EN
#if [[-z $( sed -n -e "s/\(iface\s\).*/\1/p" interfaces) ]]; then
#		jumpto interface_sh;
#fi
#sed -n -e "s/\(iface\s\).*/\1$NET_ARR[$NET_WI] inet dhcp/g" interfaces
# str allow-hotplug
#!-->
else

if [[ -z $(sed -n -e "s/\(source \/etc\/network\/interfaces/\\).*/\1/p" interfaces) ]]; then
		TMPS="1";
		reinterfaces;
fi
#<--!
# str auto $( sed -n -e "s/\(auto\s\).*/\1$NET_ARR[$NET_WI]\s$NET_ARR[$NET_EN]/p"
#!-->
if [[ -z $(sed -n -e "s/\(auto\slo\).*/\1/p" interfaces) ]]; then
		TMPS="1";
		reinterfaces;
fi
sed -i -e "s/\(auto\s\).*/\1$NET_EN/g" interfaces
#<--!
# str iface NET_EN
#!-->
if [[ -z $(sed -n -e "s/\(iface\slo\).*/\1/p" interfaces) ]]; then
		TMPS="1";
		reinterfaces;
fi
sed -i -e "s/iface\slo.*/iface $NET_EN inet dhcp/g" interfaces
#<--!
# str allow-hotplug
#!-->
if [[ -z $(sed -n -e "s/\(allow-hotplug\s\).*/\1/p" interfaces) ]]; then
		TMPS="1";
		reinterfaces;
fi
sed -i -e "s/\(allow-hotplug\s\).*/\1$NET_EN/g" interfaces
#<--!
# str iface NET_WI
#!-->
if [[ -z $(sed -n -e "s/\(iface\s\).*/\1/p" interfaces) ]]; then
		TMPS="1";
		reinterfaces;
fi
#<--!
#TMPS=$(sed -n -e "/\(iface\s[en]\).*/{=;q;}" interfaces);
#!-->
sed -i -e "$a s/\(iface\s\).*/\1$NET_EN inet dhcp/g" interfaces
#<--!
#sed -n -e "s/\(iface\s[en]\).*/\1$NET_ARR[$NET_WI] inet dhcp/g" interfaces
#sed '$a	wpa-conf \/home\/rootsu\/wpa_supplicant.conf' interfaces >> interfaces;
#sed -n -e "s/\(allow.*\s\).*/\1$NET_ARR[$NET_WIFI]\sinet\sdhcp/g" interfaces
#
# if [[ $STATE -eq "0" ]]; then fi
#!-->
fi
#<--!
#			01.03.02	restart service
#!-->

systemctl restart networking 
 
cd /install/
echo -e "1_settings_interface_with_wifi" >> steps.txt
fi
#<--!
#			01.04		Update distribution (update && upgrade) [step_one]
#!-->
step_one:

cd /install/
if [[ -z $(sed -n -e "s/^\(1_src_list\).*/\1/p" steps.txt) ]]; then

cd /etc/apt/
if [[ -z $( lsb_release -d | sed -n -e 's/.*(\([^\)]\+\))/\1/p') ]]; then
#<--!
#	echo "Error: not defined version DebianOS, wait 3 sec";
#!-->
	DEB_VER=$(cat /etc/os-release | sed -n -e "s/.*(\([^\)].*\))\"$/\1/p");
	DEB_VER=$(echo $DEB_VER | sed -n -e "s/\([a-z]*\)$//p")
else
	DEB_VER=$( lsb_release -d | sed -n -e 's/.*(\([^\)]\+\))/\1/p')
fi;
#<--!
#cd /etc/apt/;
# rm sources.tmp;
#touch sources.tmp
#
#main, contrib, non-free
#main — здесь находятся пакеты соответствующие DFSG-compliant (Debian Free Software Guidelines) не требуют дополнительное ПО из других источников. Это часть дистрибутива Debian. Полностью свободны для любого использования.
#contrib — смешанные пакеты которые содержат не только свободные пакеты DFSG-compliant но и пакеты из других веток например non-free.
#non-free — не свободное программное обеспечение. Не соответствует DFSG.
#check null string		???? 		dob add usloviya proverki ft http
#
#!-->
if [[ -n $(egrep -n '^[a-z] && ^#' sources.list) && -n $( sed -n -e "s/^deb http:\/\/ftp//p" sources.list) && -n $( sed -n -e "s/^deb-src http:\/\/ftp//p" sources.list) && -n $( sed -n -e "s/^deb http:\/\/deb//p" sources.list) && -n $( sed -n -e "s/^deb-src http:\/\/deb//p" sources.list) ]]; then
STATE="1";
rm sources.list;
#<--!
# touch sources.tmp;
#!-->
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
sleep 1; 
#<--! 
# Waits 5 seconds.
# sed -i '34s/AAA/BBB/' file_name
#!-->
else
#<--! 
#The first part of it is an "address", i.e. the following command only applies to lines matching it. The ! negates the condition, i.e. the command will only be applied to lines not matching the address. So, in other words, Replace Hello by Hello world! on lines that don't contain Hello world!.
# sed -n -e 's/.*bullseye\-[a-z]\(.\)/\1/p' sources.tmp
#The pattern [a-z]* matches zero or more characters in the range a to z (the actual characters are dependent on the current locale). There are zero such characters at the very start of the string 123 abc (i.e. the pattern matches), and also four of them at the start of this is a line.
#If you need at least one match, then use [a-z][a-z]* or [a-z]\{1,\}, or enable extended regular expressions with sed -E and use [a-z]+.
#!-->
 sed -i -e "s/$DEB_VER\s.*$/$DEB_VER main contrib non-free/g" sources.list
 sed -i -e "s/\(\/\s$DEB_VER\-[a-z]*\).*/\1 main contrib non-free/g" sources.list
fi;

echo -e "y\n" | apt-get update;
echo -e "y\n" | apt-get full-upgrade; 
if [ $? -ne 0 ]; then
   echo "Error: full upgrade error!!!"
   exit 1
fi
echo -e "y\ny\ny\ny\n" | apt-get install console-setup;
cd /install/
echo -e "1_src_list" >> steps.txt

fi

#<--!
#			01.05		Install drivers: install non-free firmware && *-nonfree and tools [step_two]
# ??? do make analys 'lspci' and install autochoose driver
#!-->
step_two:

cd /install/
if [[ -z $(sed -n -e "s/^\(2_install_driver\).*/\1/p" steps.txt) ]]; then

if [[ $(lspci | grep VGA | sed -n -e "s/.*\[\(.*\)\/.*/\1/p") == "AMD" ]]; then 
	echo -e "y\n" | apt-get install libdrm-amdgpu1
	echo -e "y\n" | apt-get install xserver-xorg-video-amdgpu
else
	echo -e "y\n" | apt-get install nvidia-driver firmware-misc-nonfree nvidia-settings
fi
#<--!
#apt-get install firmware-linux | apt-get install firmware-linux-nonfree | apt-get install firmware-linux | apt-get install firmware-realtek | apt-get install libdrm-amdgpu1 | apt-get install xserver-xorg-video-amdgpu  | apt-get install man 
#!-->
echo -e "y\n" | apt-get install firmware-linux

if [[ $(lspci | grep Ethernet | sed -n -e "s/.*ller:\s\([a-zA-Z]\+\s\).*/\1/p") == "Realtek" ]]; then 
echo -e "y\n" | apt-get install firmware-realtek
fi
echo -e "y\n" | apt-get install firmware-linux-nonfree
echo -e "y\n" | apt-get install man 
#<--!
#			01.05.01	Install SElinux utils & acl
#!-->
echo -e "y\n" | apt-get install acl
echo -e "y\n" | apt-get install setools policycoreutils selinux-basics selinux-utils selinux-policy-default selinux-policy-mls auditd policycoreutils-python-utils semanage-utils audispd-plugins
echo -e "y\n" | apt-get install mcstrans

sudo systemctl enable auditd
sudo systemctl start auditd
#<--!
#policycoreutils-gui
#!-->
touch /.autorelabel
selinux-activate

if [ $? -ne 0 ]; then
   echo "Error: install driver failed!!!"
   exit 1
fi

echo -e "2_install_driver" >> steps.txt
#<--!
#			01.05.02	Reboot, before activate-SELinux
#!-->
reboot
fi
#<--!
#			01.06		Install git && nanorc [step_three]
#!-->

if [[ -z $(sed -n -e "s/^\(3_nanorc\).*/\1/p" steps.txt) ]]; then
#<--!
# nano /etc/rc.local
#setupcon
#!-->
echo -e "y\n" | apt-get install git
if [ 
? -ne 0 ]; then
   echo "Error: error install git!!!"
   exit 1;
fi
cd /install
git clone git://git.savannah.gnu.org/nano.git; cd nano;./autogen.sh;./configure; make install 
#<--!
#rm -Rf /nano/
#rmdir /nano/
#git clone https://github.com/nanorc/nanorc.git
#cd nanorc
#make install
#exit 1;
# make list all autogen
#cat ~/.nano/syntax/ALL.nanorc
#rm ~/.nanorc
#touch ~/.nanorc
#echo -e 'include ~/.nano/syntax/ALL.nanorc' >> ~/.nanorc
## TeX
#echo -e 'include "/usr/share/nano/patch.nanorc\' >> ~/.nanorc
## POV-Ray
#echo -e 'include "/usr/share/nano/pov.nanorc\' >> ~/.nanorc
## Perl
#echo -e 'include "/usr/share/nano/perl.nanorc\' >> ~/.nanorc
## Nanorc files
#echo -e 'include "/usr/share/nano/nanorc.nanorc\' >> ~/.nanorc
## Python
#echo -e 'include "/usr/share/nano/python.nanorc\' >> ~/.nanorc
## C/C++
#echo -e 'include "/usr/share/nano/c.nanorc\' >> ~/.nanorc
## Groff
#echo -e 'include "/usr/share/nano/groff.nanorc' >> ~/.nanorc
## Assembler
#echo -e 'include "/usr/share/nano/asm.nanorc' >> ~/.nanorc
## Ruby
#echo -e 'include "/usr/share/nano/ruby.nanorc' >> ~/.nanorc
## Manpages
#echo -e 'include "/usr/share/nano/man.nanorc' >> ~/.nanorc
## HTML
#echo -e 'include "/usr/share/nano/html.nanorc' >> ~/.nanorc
## Bourne shell scripts
#echo -e 'include "/usr/share/nano/sh.nanorc' >> ~/.nanorc
## Sun Java
#echo -e 'include "/usr/share/nano/java.nanorc' >> ~/.nanorc
## Sun php
#echo -e 'include "/usr/share/nano/php.nanorc' >> ~/.nanorc
## Sun perl
#echo -e 'include "/usr/share/nano/perl.nanorc' >> ~/.nanorc
## sql
#echo -e 'include "/usr/share/nano/sql.nanorc' >> ~/.nanorc
## asm
#echo -e 'include "/usr/share/nano/asm.nanorc' >> ~/.nanorc
#include "/usr/share/nano/*.nanorc"
#!-->
find /usr/share/nano -name '*.nanorc' -printf "include %p\n" > ~/.nanorc
#<--!
#for i in `ls /usr/share/nano`
#  do
#    echo "include /usr/share/nano/$i" >> ~/.nanorc
#  done
#rm -Rf /nanorc/
#rmdir /nanorc/
#!-->
fi
echo -e "3_nanorc" >> steps.txt
#
#<--!
#			01.07		Copy dir .sh -> in directory home path [step_four]
#!-->
#
if [[ -z $(sed -n -e "s/^\(4_copy_sh\).*/\1/p" steps.txt) ]]; then
#
cd /install/
cp -Rf /install/home/* /home/
cp -Rf /install/home/rootsu/.bashrc ~root 
cp -Rf /install/home/rootsu/.profile ~root 
cp -Rf /install/home/rootsu/.cmd_shell.sh ~root

cp -Rf /install/home/rootsu/* ~root
chmod ug+rwx -Rf ~root
#<--!
# cp -Rf /install/home/admin/.bashrc /root/
#cp /etc/nanorc ~/.nanorc
#!-->
echo -e "4_copy_sh" >> steps.txt
fi
#<--!
#exit 1;
#cp -Rf /install/home/ /home/ # -> rootsu, admin
# https://superuser.com/questions/904001/how-to-install-tar-xz-file-in-ubuntu
#!-->
#<--!
#			01.08		Install utils [step_five]
#!-->
if [[ -z $(sed -n -e "s/^\(5_install_util_wd\).*/\1/p" steps.txt) ]]; then
#
echo "y\n" | apt-get install build-essential
if [ $? -ne 0 ]; then
   echo "Error: error install gcc-utils!!!"
   exit 1
fi

add-apt-repository-get ppa:ubuntu-toolchain-r/test && apt update
#<--!
#https://pcp.io/docs/guide.html
#apt-get install gcc-snapshot && apt-get install gcc-11g++-11
#update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 60 --slave /usr/bin/g++ g++ /usr/bin/g++-9
#!-->
echo -e "y\n" | apt-get install python
echo -e "y\n" | apt-get install python3
echo -e "y\n" | apt-get install tmux;
echo -e "y\n" | apt-get install net-tools
echo -e "y\n" | apt-get install manpages-dev;
echo -e "y\n" | apt-get install wpa_supplicant;
echo -e "y\n" | apt-get install mc;
echo -e "y\n" | apt-get install ncdu;
#echo -e "y\n" | apt-get install monitorix;
echo -e "y\n" | apt-get install netdata;
echo -e "y\n" | apt-get install systat;
echo -e "y\n" | apt-get install iftop;
echo -e "y\n" | apt-get install htop;
echo -e "y\n" | apt-get install sudo;
echo -e "y\n" | apt-get install iptraf;
echo -e "y\n" | apt-get install ntp
systemctl enable ntp;
systemctl enable start;
sudo systemctl unmask samba;
cp /install/etc/sudoers /etc/sudoers
echo -e "y\n" | apt-get install nmon;
echo -e "y\n" | apt-get install nmap;
echo -e "y\n" | apt-get install safe-rm
echo -e "y\n" | apt-get install aptitude
#echo -e "y\n" | apt-get install iptables
iptables –F
echo -e "y\n" | apt-get install cifs-utils
echo -e "y\n" | apt-get install samba
echo -e "y\n" | apt-get install smbfs
echo -e "y\n" | apt-get install whois
echo -e "y\n" | apt-get install lsof
echo -e "y\n" | apt-get install mkpasswd
echo -e "y\n" | apt-get install wget
echo -e "y\n" | apt-get install tree
echo -e "y\n" | apt-get install autofs
echo -e "y\n" | apt-get install gpg
echo -e "y\n" | apt-get install rsync
echo -e "y\n" | apt-get install ca-certificates
echo -e "y\n" | apt-get install shared-mime-info
echo -e "y\n" | apt-get install wget genisoimage xorriso isolinux hwinfo
echo -e "y\n" | apt-get install hddtemp lm-sensors
echo -e "y\n" | apt-get install at
echo -e "y\n" | apt-get install pip
echo -e "y\n" | apt-get install xz-utils
echo -e "y\n" | apt-get install curl
echo -e "y\n" | apt-get install sphinx
echo -e "y\n" | apt-get install python3-sphinx
echo -e "y\n" | sudo apt install -y build-essential libssl-dev libffi-dev python3-dev
echo -e "y\n" | sudo apt install -y python3-venv
python3 -m venv env
#<--!
#pip install mkdocs
#pip install -U mkdocs
#pip install mkdocs-rtd-dropdown
#!-->
pip install --upgrade myst-parser
pip install sphinx-autodocgen
pip install Pygments
pip install sphinx-intl
pip install lumache
pip install django
pip install django-docs
pip install sphinxnotes-strike
pip install sphinx_rtd_theme
# Install Sphinx
pip install -U sphinx
python -m venv .venv
#echo -e "y\n" | apt-get install anacron
systemctl enable cron
#systemctl enable anacron
#echo -e "y\n" | apt-get install postfix
# Nmap Ngrep VnStat Iptraf-ng NetHogs Iotop dd dh netcat
systemctl enable autofs
#systemctl start autofs
#echo -e "y\n" | apt-get install selinux-basics selinux-policy-default auditd
#echo -e "y\n" | apt-get install setools policycoreutils selinux-basics selinux-utils selinux-policy-default selinux-policy-mls  auditd policycoreutils-python-utils semanage-utils 
#setroubleshoot selinux-policy-targeted

apt-get install openssh-server -y
if [ $? -ne 0 ]; then
   echo "Error: error install setup-utils!!!"
   exit 1
fi

#exit 1;
#
#	Update settings LOCALE
#
#	locale -a
update-locale LC_TIME=ru_RU.UTF-8;
update-locale LC_ALL=ru_RU.UTF-8;
update-locale LANG=ru_RU.UTF-8;
sed -n -e "s/\(=\).*/\1\"$ru_RU.UTF-8\"/p" /etc/default/locale
update-locale;

cp -Rf /install/etc/* /etc
if [ $? -ne 0 ]; then
   echo "Error: copy install to etc"
   exit 1
fi
cd /install/
echo -e "5_install_util_wd" >> steps.txt

#exit 1;
#
#echo "Press ESC key to quit and reboot"
# read a single character
#while read -r -n1 key
#do
# if input == ESC key
#if [[ $key == $'\e' ]];
#then
#	reboot;
#fi
#done

fi
#dpkg -i xz-utils_5.2.4-1_amd64.deb
#tar -xvf wpa_supplicant-0.7.3.tar.gz
#cd ./wpa_supplicant-0.7.3/
#mv /install/.config /install/wpa_supplicant-0.7.3/wpa_supplicant/
#bash make
#exit 1;
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

#Search 
# add-apt-repository ppa:un-brice/ppa
# apt-get update
# apt-get install shake-fs
#<--!
#			01.09		Install driver opt and acc [step_six]
#!-->
step_four:
cd /install/
if [[ -z $(sed -n -e "s/^\(7_driver_opt\).*/\1/p" steps.txt) ]]; then
#<--!
#			01.09.01	create disk /opt/
#
#			01.09.02	search /dev/s**
#
#touch fdiskhdd.txt;
#fdisk -l > fdiskhdd.txt
#STATE=$(sed -n -e "s/.*\(\/dev\/s[a-z]*[0-9]\).*/\1/p" fdiskhdd.txt);
#if [[ -z $(sed -n -e "s/.*\(\/dev\/s[a-z]*\).*/\1/p" fdiskhdd.txt) ]]; then
#	STATE=$(sed -n -e "s/.*\(\/dev\/s[a-z]*\).*/\1/p" fdiskhdd.txt);
#fi
#
#	OPTIONS: g , w
#
#echo "\ng\nn\n1\n2048\n\nw" |  fdisk $STATE --wipe AUTO 

#
#	Create fs
#
#mkfs.ext4 $STATE /opt
#!-->
#<--!
#			01.09.03	mount /dev/s**
#!-->
#mount -t ext4 $(sudo fdisk -l | sed -n -e "s/.*\(\/dev\/s[a-z]*[0-9]\).*/\1/p") /opt

#shd=$(sudo fdisk -l | sed -n -e "s/.*\(\/dev\/s[a-z]*[0-9]\).*/\1/p" | sed 's/\//\\\//g')

#S1=$(sudo blkid | sed -n -e "s/$shd:\s\(.*\).*/\1/p" | sed -n -e "s/$shd:\s\([\=a-zA-Z_]*\)/\1/p;s/UUID=\(.*\)\sB.*/\1/p" | sed 's/\"/\\"/g')

#S1=$(sudo blkid | sed -n -e "s/$shd:\s\(.*\).*/\1/p" | sed -n -e "s/UUID=\(.*\)\sB.*/\1/p" | sed 's/\"/\\"/g')

#sed -i -e "$ a UUID\=$S1	\/opt\/	ext4	defaults	0	2" /etc/fstab
cd /install/
touch fdisk.txt
fdisk -l | sed -n -e "s/.*\(\/dev\/s[a-z]*[0-9]\).*/\1/p" > fdisk.txt

filename='fdisk.txt'
n=1
while read line; do
# reading each line
shd=$(echo $line | sed 's/\//\\\//g')
S1=$(blkid | sed -n -e "s/$shd:\s\(.*\).*/\1/p" | sed -n -e "s/.*UUID=\(.*\)\sB.*/\1/p" | sed 's/\"/\\"/g')
TMPS=$(echo $line | sed -n -e "s/^\/dev\/\([a-z]*[0-9]\).*/\1/p")
chown admin_share:technics -Rf "/mnt/$TMPS"
chmod ugo+rwx -Rf "/mnt/$TMPS"
semanage fcontext -a -t public_content_rw_t "/mnt/$TMPS(/.*)?"; 
chcon -Rv -t public_content_rw_t "/mnt/$TMPS";
setfacl -m u:admin_share:rwx,u:admin:rwx,u:pub_share:rwx -R "/mnt/$TMPS";
setfacl -m g:admins:rw,g:technics:rw -R "/mnt/$TMPS";
chmod go+rwx -R "/mnt/$TMPS";
if [[ -n $S1 ]]; then
	sed -i -e "$ a UUID\=$S1	\/mnt\/$TMPS	ext4	defaults	0	2" /etc/fstab
fi

sed -i -e "s/^UUID=\"b90071b5-8949-4a72-b836-63756e4c7b1d\".*$/#/g" /etc/fstab
done < $filename
sudo mount -a
#if [[ -z $STATE ]]; then
#	exit 3;
#fi
#		1_1_3_2 create disk /dev/s**
#
# https://www.computerhope.com/unix/fdisk.htm
# https://superuser.com/questions/332252/how-to-create-and-format-a-partition-using-a-bash-script
#
echo -e "7_driver_opt" >> steps.txt
fi
#
cd /install/
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
#cp /install/pii2.sh /etc/init.d/
#chkconfig --add pii2.sh
#update-rc.d pii2.sh defaults
#
#touch /install/step_two.txt
#
#	Posle del!!!
# https://serverfault.com/questions/32438/disable-a-service-from-starting-at-all-runlevels

#
#	Jump to label interface_sh
#
#<--!
#			01.10		Create users and groups, settings netutils: ssh,ftp,smbd etc... [step_seven]
#!-->

if [[ -z $(sed -n -e "s/^\(9_user_settings\).*/\1/p" steps.txt) ]]; then

STEP_TWO_AFTER:

#
#	 cp sources.tmp sources.list;
#<--!
#			01.10.01		Create users and groups
#!-->
#cp -Rf /install/home/rootsu/.cmd_shell.sh ~/.cmd_shell.sh
#cp -Rf /install/home/rootsu/.bashrc ~/.bashrc
#cp -Rf /install/home/rootsu/.bashrc /home/admin/
#cp -Rf /install/home/rootsu/.cmd_shell.sh /home/admin/
#В
 groupadd -g 1000 admins
 groupadd -g 2000 exp_users
 groupadd -g 3000 pro_users
 groupadd -g 4000 moderators
 groupadd -g 5000 technics
 groupadd -g 6000 ps_users
 groupadd -g 7000 others
 useradd -u 1100 -g admins -c "admin" -s /bin/bash -p $(echo "vkd174asqd" | mkpasswd -s -H MD5) -m admin
 
 useradd -u 1200 -g admins -c "admin" -s /bin/bash -p $(echo "vkd174asqd" | mkpasswd -s -H MD5) -m admin_tech
usermod -aG sudo,technics,root admin
usermod -aG sudo,technics,root admin_tech
 
cp /install/home/rootsu/.bashrc /home/admin/ 
cp /install/home/rootsu/.profile /home/admin/
cp /install/home/rootsu/.cmd_shell.sh /home/admin/

 useradd -u 2100 -g exp_users -s /bin/bash -c "far_exp" -p $(echo "vkd174asqd" | mkpasswd -s -H MD5) -m far_exp
 useradd -u 3100 -g pro_users -s /bin/bash -c "far_pro" -p $(echo "vkd174asqd" | mkpasswd -s -H MD5) -m far_pro
 useradd -u 4100 -g moderators -s /bin/bash -c "far_moderator" -p $(echo "vkd174asqd" | mkpasswd -s -H MD5) -m far_mod
 useradd -u 5100 -g technics -d /opt/SAMBA_SHARE/ -s /bin/false -c "technical admin_share" -p $(echo "vkd174" | mkpasswd -s -H MD5) admin_share
 useradd -u 5200 -g technics -d /opt/SAMBA_SHARE/ -s /bin/false -c "technical pub_share" -p $(echo "vkd174" | mkpasswd -s -H MD5) pub_share
 useradd -u 6100 -g ps_users -s /bin/bash -c "far_user" -p $(echo "vkd174asqd" | mkpasswd -s -H MD5) -m far_user
# useradd -u 6100 -g users -s /bin/bash -c "test" -p "" -m test
useradd -g ps_users -c "tom" -s /bin/bash -p $(echo "vkd174" | mkpasswd -s -H MD5) -m tom
#smbpasswd -a -w "" admin_share
echo -e "vkd174\nvkd174" | smbpasswd -a admin_share
echo -e "vkd174\nvkd174" | smbpasswd -a pub_share
smbpasswd -e admin_share
smbpasswd -e pub_share
#smbpasswd -a -w "" pub_share
#if [ $? -ne 0 ]; thenvkd174asqd
#	
#fi

mkdir /opt/SAMBA_SHARE
mkdir /mnt/SMB
mkdir /mnt/SMB/SOFT_2TBSEAGREEN
mkdir /mnt/SMB/SOFT_3TBSEASYAN
mkdir /media/admin
chown admin:admins /media/admin
chown -R :technics /opt/ /opt/SAMBA_SHARE /mnt/SMB
chown -R admin_share:technics /opt/ /opt/SAMBA_SHARE /mnt/SMB
chmod ug+rw /opt/ /opt/SAMBA_SHARE /mnt/SMB
setfacl -m u:pub_share:rwx,u:admin_share:rwx -R "/mnt/SMB";
#chown -R admin_share:technics,pub_share:technics /mnt/SMB

#<--!
#			01.10.02		Create ssh_ssl
#!-->
#		https://www.cyberciti.biz/tips/checking-openssh-sshd-configuration-syntax-errors.html
#<--!
#			01.10.03	Install ssh settings
#!-->
cd /etc/ssh/

cp sshd_config sshd_config.tmp
#
# #Port 22
#
 sed -i -e "s/#Port\s.*$\|Port\s.*$/Port $PORT_SSH/g" sshd_config
#
# HostKey
#
 sed -i -e "s/#HostKey/HostKey/g" sshd_config
#
# PubkeyAuthentification
#
 sed -i -e "s/#PubkeyAuthentication\s.*$\|PubkeyAuthentication\s.*$/PubkeyAuthentication yes/g" sshd_config
#
# #SysLogFacility
#
 sed -i -e "s/#SysLogFacility\s.*$\|SysLogFacility\s.*$/SysLogFacility AUTHPRIV/g" sshd_config
#
# #LogLevel
#
 sed -i -e "s/#LogLevel\s.*$\|LogLevel\s.*$/#LogLevel INFO/g" sshd_config
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
 sed -i -e "s/ChallengeResponseAuthentication.*$\|#ChallengeResponseAuthentication.*$/ChallengeResponseAuthentication yes/g" sshd_config
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
 sed -i -e "s/Subsystem\s/#Subsystem\s/g" sshd_config
#
#
systemctl restart ssh
#<--!
#			01.10.04	Create users ssh
#!-->
#
sudo bash ~/.cmd_shell.sh --mode "ssh_keygen" --uadd "tom" --gadd "ps_users" --pwd "debian"
bash ~/.cmd_shell.sh --mode "ssh_keygen" --uadd "admin" --gadd "admins" --pwd "debian"
#
#<--!
#			01.10.05	Create SAMBA
#!-->
#
#

mount -v -t cifs //192.168.1.1/SOFT_2TBSEAGREEN/  /mnt/SMB/SOFT_2TBSEAGREEN -o credentials=/home/rootsu/.smbusers,defcontext="system_u:object_r:samba_share_t:s0";
mount -v -t cifs //192.168.1.1/SOFT_3TBSEASYAN/  /mnt/SMB/SOFT_3TBSEASYAN -o credentials=/home/rootsu/.smbusers,defcontext="system_u:object_r:samba_share_t:s0";

cp -Rf /install/etc/autofs /etc/
cp -Rf /install/etc/autofs.conf /etc/
cp -Rf /install/etc/samba /etc/
cp -Rf /install/lib/ /lib/
chmod 644 -Rf /etc/autofs/

systemctl restart autofs
systemctl restart smbd

#<--!
#			01.10.06	Install and settings firewall ?
#!-->
#<--!
#			01.10.07	Install other soft
#!-->
#<--!
#			01.10.08	Extended nano (non autosettings)
#cp /install/nanorc /etc/nanorc
#<--!
#
#<--!
#			01.10.09	cp ers (non autosettings)
#cp /install/ers /etc/ers
#!-->
echo -e "y" | apt-get install ntfs-3g;
#exit 1;
#<--!
#			01.10.10	Install vsftp
#!-->
echo -e "y" | sudo apt install vsftpd

cd /etc/
sudo cp /etc/vsftpd.conf  /etc/vsftpd.conf_default

# Listen=YES
sed -i -e "s/listen=.*$/listen=YES/g" vsftpd.conf
# listen_ipv6=
sed -i -e "s/listen_ipv6=.*$/listen_ipv6=NO/g" vsftpd.conf
# annonymous_enable=NO
sed -i -e "s/#anonymous_enable=.*$\|anonymous_enable=.*$/anonymous_enable=NO/g" vsftpd.conf
# anon_upload_enable=NO
sed -i -e "s/#anon_upload_enable=.*$\|anon_upload_enable=.*$/anon_upload_enable=NO/g" vsftpd.conf
# anon_mkdir_write_enable=NOanon_mkdir_write_enable=YES
sed -i -e "s/anon_mkdir_write_enable=.*$\|#anon_mkdir_write_enable=.*$/anon_mkdir_write_enable=NO/g" vsftpd.conf
# write_enable=YES
sed -i -e "s/#write_enable=.*$\|write_enable=.*$/write_enable=YES/g" vsftpd.conf
# local_umask=022
sed -i -e "s/#local_umask=.*$\|local_umask=.*$/local_umask=022/g" vsftpd.conf
# connect_from_port 20
sed -i -e "s/connect_from_port_20=.*$/connect_from_port_20=NO/g" vsftpd.conf
# local_umask=022
sed -i -e "s/#ascii_upload_enable=.*$\|ascii_upload_enable=.*$/ascii_upload_enable=YES/g" vsftpd.conf
# ascii_upload_enable=YES
sed -i -e "s/#ascii_upload_enable=.*$\|ascii_upload_enable=.*$/ascii_upload_enable=YES/g" vsftpd.conf
# ascii_download_enable=YES
sed -i -e "s/#ascii_download_enable=.*$\|ascii_download_enable=.*$/ascii_download_enable=YES/g" vsftpd.conf
# ftpd_banner=
sed -i -e "s/#ftpd_banner=.*$\|ftpd_banner=.*$/ftpd_banner=Welcome to $HOSTNAME!!!/g" vsftpd.conf
# #restrict FTP users to their /home directory and allow them to write there
# mogut switch from home / YES yes restrict privilege
#sed -i -e "s/#chroot_local_user=.*$\|chroot_local_user=.*$/chroot_local_user=YES/g" vsftpd.conf
sed -i -e "0,/#chroot_local_user=.*$\|chroot_local_user=.*$/ s//chroot_local_user=YES/g" vsftpd.conf
# is_recurse_enable -R
sed -i -e "s/#ls_recurse_enable=.*$\|ls_recurse_enable=.*$/ls_recurse_enable=YES/g" vsftpd.conf
# chroot_list_file=/etc/vsftpd.chroot_list/
sed -i -e "s/#chroot_list_file=.*$\|chroot_list_file=.*$/chroot_list_file=\/home\/rootsu\/vsftpd.chroot_list/g" vsftpd.conf
# ut8 fs
sed -i -e "s/#utf8_filesystem=.*$\|utf8_filesystem=.*$/utf8_filesystem=YES/g" vsftpd.conf
# pam_service_name off
sed -i -e "s/pam_service_name=.*$/#pam_service_name=vsftpd/g" vsftpd.conf
# rsa_cert_file=/
sed -i -e "s/rsa_cert_file=.*$\|#rsa_cert_file=.*$/rsa_cert_file=\/etc\/ssl\/certs\/vsftpd.crt/g" vsftpd.conf
# This option specifies the location of the RSA certificate to use for SSL
# encrypted connections.
#rsa_private_key_file=
sed -i -e "s/rsa_private_key_file=.*$\|#rsa_private_key_file=.*$/rsa_private_key_file=\/etc\/ssl\/private\/vsftpd.key/g" vsftpd.conf
#ssl_enable=NO
sed -i -e "s/ssl_enable=.*$\|#ssl_enable=.*$/ssl_enable=YES/g" vsftpd.conf
#force_dot_files=YES
sed -i -e "$ a force_dot_files=YES" vsftpd.conf
#background=YES
#pasv_port
#sed -i -e "$ a pasv_min_port=49000" vsftpd.conf
#sed -i -e "$ a pasv_max_port=55000" vsftpd.conf
#	allow_anon_ssl=NO
sed -i -e "$ a allow_anon_ssl=NO" vsftpd.conf
#	force_local_data_ssl=YES
sed -i -e "$ a force_local_data_ssl=NO" vsftpd.conf
#	force_local_logins_ssl=YES
sed -i -e "$ a force_local_logins_ssl=YES" vsftpd.conf
#	ssl_tlsv1_1=YES
#sed -i -e "$ a ssl_tlsv1_1=YES" vsftpd.conf
#	ssl_tlsv1_2=YES
sed -i -e "$ a ssl_sslv3=YES" vsftpd.conf
#ssl_tlsv1_1=NO
#ssl_tlsv1_2=YES
#ssl_tlsv1=NO
#ssl_sslv2=NO
#ssl_sslv3=NO
#	ssl_tlsv1=NO
#sed -i -e "$ a ssl_tlsv1=NO" vsftpd.conf
#	ssl_tlsv2=NO
#sed -i -e "$ a ssl_sslv2=NO" vsftpd.conf
#	ssl_sslv3=NO
#sed -i -e "$ a ssl_sslv3=NO" vsftpd.conf
#	require_ssl_reuse=YES
sed -i -e "$ a require_ssl_reuse=YES" vsftpd.conf
#	ssl_ciphers=HIGH
sed -i -e "$ a ssl_ciphers=HIGH" vsftpd.conf
####Problems have been reported with EPSV. The only way to disable EPSV mode in vsftpd appears to be to disallow the EPSV and EPRT commands, so that a client will recieve a "550 Permission Denied" response to any EPSV command and hopefully drop back to regular PASV. Unfortunately the "cmds_denied" blacklisting option was only introduced in vsftpd 2.1. We therefore have to take a whitelisting approach using the "cmds_allowed" option. The list below basicly includes everything except the commands needed for EPSV.
sed -i -e "$ a cmds_allowed=ABOR,CWD,RMW,DELE,LIST,MDTM,MKD,NLST,PASS,PASV,PORT,PWD,QUIT,RETR,RMD,RNFR,RNTO,SITE,SIZE,STOR,TYPE,USER,CDUP,HELP,MODE,NOOP,STAT,STOU,STRU" vsftpd.conf

#	USERLIST
sed -i -e "$ a userlist_enable=YES" vsftpd.conf
#	userlist_deny
sed -i -e "$ a userlist_deny=NO" vsftpd.conf
#	userlist_enable
sed -i -e "$ a userlist_enable=YES" vsftpd.conf
#	userlist_file=/home/rootsu/vsftpd-virtual_user/vsftpd_user
sed -i -e "$ a userlist_file=/home/rootsu/vsftpd-virtual_user/vsftpd_user" vsftpd.conf
# user_config_dir=/
sed -i -e "$ a user_config_dir=/home/rootsu/vsftpd-virtual_user/" vsftpd.conf
#	chown_uploads=YES
sed -i -e "$ a chown_uploads=YES" vsftpd.conf
#	chown_username=nobody
sed -i -e "$ a chown_username=nobody" vsftpd.conf
# Запретить /etc/vsftpd.userlist вход в список пользователей
#userlist_enable=YES
#userlist_deny=YES
#userlist_file=/etc/vsftpd.user_list
# set it to YES to turn on TCP wappers
sed -i -e "$ a tcp_wrappers=YES" vsftpd.conf
#set maximum allowed connections per single IP address (0 = no limits)
sed -i -e "$ a max_per_ip=10" vsftpd.conf
# Enable the userlist 
sed -i -e "$ a userlist_enable=YES" vsftpd.conf
# Allow the local users to login to the FTP (if they're in the userlist)
sed -i -e "$ a local_enable=YES" vsftpd.conf
# Allow virtual users to use the same privileges as local users
sed -i -e "$ a virtual_use_local_privs=YES" vsftpd.conf
# Allow virtual users to use the same privileges as local users
#sed -i -e "$ a pam_service_name=vsftpd" vsftpd.conf
# FTP port 21
sed -i -e "$ a listen_port=21" vsftpd.conf
# PAM SHell off
cd /etc/pam.d/
sed -i -e "s/auth	required	pam_shells.so.*$\|#auth	required	pam_shells.so.*$/#auth	required	pam_shells.so/g" vsftpd
#echo -e "RU\nRussia\nSaratov\n$HOSTNAME Ltd.\n\nadmin\n\n" | openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt
# bag 500 OOPS: priv_sock_get_int.
# echo 'seccomp_sandbox=NO' >> /etc/vsftpd/vsftpd.conf
#$ sudo openssl req -x509 -nodes -days 365 -newkey rsa:4095 -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem
echo -e "RU\nRussia\nSaratov\n$HOSTNAME Ltd.\nWSB-IOT-Embedded\nadmin\nfar1803@ya.ru\n" | openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt

chmod 770 /home/rootsu/vsftpd-virtual_user
chmod 770 /home/rootsu/vsftpd.chroot_list
chmod 750 -R /home/rootsu

# List of FTP commands
#
# ABOR - Abort an active file transfer.
# ACCT - Account information.
# ADAT - Authentication/Security Data (RFC 2228)
# ALLO - Allocate sufficient disk space to receive a file.
# APPE - Append.
# AUTH - Authentication/Security Mechanism (RFC 2228)
# CCC  - Clear Command Channel (RFC 2228)
# CDUP - Change to Parent Directory.
# CONF - Confidentiality Protection Command (RFC 697)
# CWD  - Change working directory.
# DELE - Delete file.
# ENC  - Privacy Protected Channel (RFC 2228)
# EPRT - Specifies an extended address and port to which the server should connect. (RFC 2428)
# EPSV - Enter extended passive mode. (RFC 2428)
# FEAT - Get the feature list implemented by the server. (RFC 2389)
# HELP - Returns usage documentation on a command if specified, else a general help document is returned.
# LAND - Language Negotiation (RFC 2640)
# LIST - Returns information of a file or directory if specified, else information of the current working directory is returned.
# LPRT - Specifies a long address and port to which the server should connect. (RFC 1639)
# LPSV - Enter long passive mode. (RFC 1639)
# MDTM - Return the last-modified time of a specified file. (RFC 3659)
# MIC  - Integrity Protected Command (RFC 2228)
# MKD  - Make directory.
# MLST - Lists the contents of a directory if a directory is named. (RFC 3659)
# MODE - Sets the transfer mode (Stream, Block, or Compressed).
# NLST - Returns a list of file names in a specified directory.
# NOOP - No operation (dummy packet; used mostly on keepalives).
# OPTS - Select options for a feature. (RFC 2389)
# PASS - Authentication password.
# PASV - Enter passive mode.
# PBSZ - Protection Buffer Size (RFC 2228)
# PORT - Specifies an address and port to which the server should connect.
# PWD  - Print working directory. Returns the current directory of the host.
# QUIT - Disconnect.
# REIN - Re initializes the connection.
# REST - Restart transfer from the specified point.
# RETR - Retrieve (download) a remote file.
# RMD  - Remove a directory.
# RNFR - Rename from.
# RNTO - Rename to.
# SITE - Sends site specific commands to remote server.
# SIZE - Return the size of a file. (RFC 3659)
# SMNT - Mount file structure.
# STAT - Returns the current status.
# STOR - Store (upload) a file.
# STOU - Store file uniquely.
# STRU - Set file transfer structure.
# SYST - Return system type.
# TYPE - Sets the transfer mode (ASCII/Binary).
# USER - Authentication username. 
iptables -F
sudo systemctl restart vsftpd
sudo systemctl enable vsftpd
iptables –F
#sudo ufw allow 20/tcp
#sudo ufw allow 21/tcp
cp -Rf /home/admin/.ssh/ /media/admin/ssh

cp -Rf /home/tom/.ssh/ /media/admin/ssh2
chown -Rf admin:admins /media/admin/ /home/admin/

echo -e "9_user_settings" >> steps.txt
fi
#rm /install/steps.txt

#<--!
#			01.11	Settings permissive SELinux
#!-->
# seinfo -t
if [[ -z $(sed -n -e "s/^\(10_SELinux_settings\).*/\1/p" steps.txt) ]]; then

semanage fcontext -a -s system_u "/home/rootsu(/.*)?";
semanage fcontext -a -t user_home_dir_t "/home/rootsu(/.*)?";
chcon -Rv -u system_u -t user_home_dir_t "/home/rootsu/";

semanage fcontext -a -t ftpd_etc_t "/home/rootsu/vsftpd-virtual_user";
chcon -Rv -t ftpd_etc_t "/home/rootsu/vsftpd-virtual_user";
semanage fcontext -a -t ftpd_etc_t "/home/rootsu/vsftpd.chroot_list(/.*)?";
chcon -Rv -t ftpd_etc_t "/home/rootsu/vsftpd.chroot_list";
semanage fcontext -a -t samba_etc_t "/home/rootsu/smbuser.conf";
chcon -Rv -t samba_etc_t "/home/rootsu/smbuser.conf";
semanage fcontext -a -t samba_etc_t "/home/rootsu/.smbusers";
chcon -Rv -t samba_etc_t "/home/rootsu/.smbusers";
semanage fcontext -a -u system_u "/home(/.*)?";
chcon -Rv -u system_u "/home/";

#semanage fcontext -a -t user_home_dir_t "/home/admin(/.*)?";
#chcon -Rv -t user_home_dir_t "/home/admin";

chcon -Rv -t public_content_rw_t "/media/admin";
semanage fcontext -a -t public_content_rw_t "/media/admin(/.*)?";

setfacl -m u:admin:rwx,u:admin_share:rwx -R "/media/admin";
setfacl -m g:admins:rw -R "/media/admin";
chmod go-rwx -R "/media/admin";

semanage fcontext -a -t public_content_rw_t "/opt(/.*)?"
chcon -Rv -t public_content_rw_t "/opt/";
chmod o-rwx -R "/opt/SAMBA_SHARE/";
setfacl -m g:technics:rwx -R "/opt/SAMBA_SHARE/";
setfacl -m u:pub_share:rwx,u:admin_share:rwx -R "/opt/SAMBA_SHARE/";

setsebool -P ssh_sysadm_login on
#setsebool -P allow_use_cifs on
#setsebool -P allow_use_nfs on
setsebool -P httpd_use_cifs on
setsebool -P allow_ftpd_use_nfs 1
setsebool -P allow_ftpd_use_cifs 1
setsebool -P ftpd_connect_db 1

setsebool -P ftp_home_dir on
setsebool -P allow_ftpd_full_access on
setsebool -P ftpd_use_passive_mode on

semanage port -a -t ssh_port_t -p tcp 4103
semanage port -a -t smbd_port_t -p tcp 445
semanage port -a -t ftp_port_t -p tcp 21

cd ~
semodule -i mountlocv1v2.pp

COUNT=1;
ip addr | sed -n -e "s/.*1\:\s\(.*\)\:\s<.*/\1/p"
while [[ -n $( ip addr | sed -n -e "s/.*$COUNT\:\s\(.*\)\:\s<.*/\1/p") ]]
do
semanage interface -a -t netif_t -r s0-s0:c0.c1023 $( ip addr | sed -n -e "s/.*$COUNT\:\s\(.*\)\:\s<.*/\1/p")
  ((COUNT++));
done
# danger!!! Set this is Settings to SELinux *boot_t* permissive for disabled boot DebianOS!!!
#semanage permissive -a sshd_t 
semanage permissive -a boot_t 
#setsebool -P allow_execmem 1
#setsebool -P allow_execheap 1
#setsebool -P allow_user_mysql_connect 1
setsebool -P cron_can_relabel 1
setsebool -P fcron_crond 1
setsebool -P cron_userdomain_transition 1
setsebool -P cron_manage_all_user_content 1
setsebool -P cron_read_all_user_content 1
setsebool -P cron_read_generic_user_content 1

#setsebool -P samba_run_unconfined 1
setsebool -P allow_mount_anyfile 1
setsebool -P webadm_manage_user_files 1
setsebool -P webadm_read_user_files 1

#setsebool -P use_nfs_home_dirs 1
setsebool -P samba_export_all_ro 1
setsebool -P samba_export_all_rw 1
setsebool -P dhcpc_manage_samba 1
setsebool -P samba_create_home_dirs 1
setsebool -P samba_enable_home_dirs 1
setsebool -P samba_share_fusefs 1
setsebool -P samba_share_nfs 1
setsebool -P use_samba_home_dirs 1
#setsebool -P use_samba_nfs_dirs 1
setsebool -P virt_use_samba 1
setsebool -P virt_use_nfs 1
setsebool -P samba_portmapper 1
setsebool -P systemd_tmpfiles_manage_all 1
setsebool -P cron_manage_generic_user_content 1

#setsebool -P nscd_use_shm 1
setsebool -P use_nfs_home_dirs 1

setsebool -P sudo_all_tcp_connect_http_port 1
setsebool -P git_cgi_enable_homedirs 1
setsebool -P git_cgi_use_cifs 1
setsebool -P git_cgi_use_nfs 1
setsebool -P git_session_bind_all_unreserved_ports 1
setsebool -P git_session_send_syslog_msg 1
setsebool -P git_session_users 1
setsebool -P git_system_enable_homedirs 1
setsebool -P git_system_use_cifs 1
setsebool -P git_system_use_nfs 1

systemctl enable mcstrans
systemctl start mcstrans
systemctl reenable fstrim.timer
systemctl reenable fstrim.timer
systemctl start fstrim.service
systemctl start fstrim.timer
#setenforce 0

cd /etc/selinux

#	systemctl disable auditd
sed -i -e "s/SELINUX=permissive\|SELINUX=default/SELINUX=enforcing/g" config
# ROLE=sysadm_r 
# TYPE=sysadm_sudo_t ROLE=sysadm_r 
sed -i -e "s/%sudo.*$/%sudo	ALL=(root) ROLE=sysadm_r NOPASSWD:ALL/g" /etc/sudoers
sed -i -e "s/%admins.*$/%admins	ALL=(root) NOPASSWD:ALL/g" /etc/sudoers
sed -i -e "s/admin.*$/admin	ALL=(root) NOPASSWD:ALL/g" /etc/sudoers

sed -i -e '1 a session	required	pam_selinux.so	close' /etc/pam.d/sshd
sed -i -e '$a session	required	pam_selinux.so	multiple open' /etc/pam.d/sshd >> /etc/pam.d/sshd
sed -i -e '$a session	required	pam_access.so' /etc/pam.d/sshd >> /etc/pam.d/sshd

sed -i -e '$a -a exit,always -S open -F auid>=0' /etc/audit/audit.rules

chmod o-x "/etc/systemd/system.conf";
#rm /install/pii2.sh /etc/init.d/
#update-rc.d -f pii2.sh remove
#chmod o-rw -R "/etc/";
chmod o-rwx -R "/boot/";
#chmod o-rwx "/var/";
#chmod o-rwx "/sys/";
chmod o-rwx -R "/srv/";
chmod o-rwx -R "/mnt/";
#chmod o-rwx "/proc/";
semanage fcontext -a -t tmp_t "/tmp(/.*)?"
chcon -t tmp_t -R "/tmp"
chmod o-rwx -R "/tmp/";
chmod o-rwx "/media/";
#chmod o-rw "/dev/";
#chmod o+r "/etc/profile";
#chmod o+rx -R "/etc/profile.d/";
#chmod o+rx "/etc/bash.bashrc";
#chmod o+r "/etc/nanorc";
#chmod o+r "/etc/passwd";
#chmod o+r "/etc/passwd-";
#chmod o+r "/etc/group";
#chmod o+r "/etc/hostname";
#chmod o+rx "/etc/console-setup";
semanage fcontext -a -t system_cron_spool_t "/var/spool/cron(/.*)?"
chcon -t system_cron_spool_t -Rv /var/spool/cron/

chmod o-r -R "/home/";
chmod o-x -R "/home/rootsu" "/home/admin/";
#chmod o-r "/usr/bin/";

echo "deb https:\\\download.webmin.com\download\repository sarge contrib" >> /etc/apt/sources.list
#nvidia-uninstall
cd ~
#grep AVC /var/log/audit/audit.log | audit2allow -m loaderlocalv4 > loaderlocalv4.te
#grep AVC altlog.log | audit2allow -m loaderlocalv4 > loaderlocalv4.te
#checkmodule -M -m -o loaderlocalv1.mod loaderlocalv1.te
#semodule_package -o loaderlocalv1.pp -m loaderlocalv1.mod

semodule -i loaderlocalv1.pp
semodule -i loaderlocalv2.pp
semodule -i loaderlocalv3.pp
semodule -i loaderlocalv4.pp

#sudo apt-get install
#sudo apt-get automount
semodule -i sudotev1.pp
semodule -i sudotev2.pp
semodule -i sudotev3.pp
semodule -i sudotev4.pp
semodule -i sudotev5.pp
semodule -i sudotevb1.pp
semodule -i sudotevb2.pp
semodule -i sudotev70522v21.pp
semodule -i sudotevcrondv1.pp
semodule -i sphinxtev1.pp
semanage permissive -a boot_t
semanage permissive -a crond_t
semanage permissive -a crontab_t
semanage permissive -a system_crontab_t
semanage module -d permissive_boot_t
#semanage module -r permissive_boot_t
semanage user -m -R "system_r sysadm_r staff_r" -r "s0-s0:c0.c1023" sysadm_u
#semanage user -m -R "system_r" -r "s0-s0:c0.c1023" system_u
semanage login -a -s sysadm_u -r "s0-s0:c0.c1023" admin
semanage login -a -s sysadm_u -r "s0-s0:c0.c1023" admin_tech
semanage login -a -s sysadm_u -r "s0-s0:c0.c1023" %admins
#semanage login -m -s sysadm_u -r "s0-s0:c0.c1023" root
#semanage login -a -s sysadm_u -r "s0-s0:c0.c1023" %root
semanage login -a -s unconfined_u -r "s0-s0:c0.c1023" %sudo
semanage login -a -s user_u tom
#touch log.log
#journalctl -xe >> log.log
#grep AVC log.log | audit2allow -m sudotev1 > sudotev1.te
#checkmodule -M -m -o sudotev1.mod sudotev1.te
#semodule_package -o sudotev1.pp -m sudotev1.mod

#semodule -i sudotev1.pp

update-initramfs -k all -u
update-grub

echo -e "y\n" | apt-get install apt-transport-https
echo -e "y\n" | apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python unzip
cd /root
wget https://download.webmin.com/jcameron-key.asc
cat jcameron-key.asc | gpg --dearmor >/usr/share/keyrings/jcameron-key.gpg
cd /install/
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.991_all.deb
dpkg --install webmin_1.991_all.deb
mkdir /var/webmin/.webmin
chmod 755 /var/webmin/.webmin
semanage fcontext -a -t tmp_t "/var/webmin/.webmin";
chcon -Rv -t tmp_t "/var/webmin/.webmin";
#echo -e "y\n" | apt-get install apt-transport-https
#echo -e "y\n" | apt-get update
#echo -e "y\n" | apt-get install webmin
semanage port -a -t http_port_t -p tcp 10000
semanage port -a -t http_port_t -p tcp 20000

systemctl enable webmin
systemctl start webmin

#<--!
#			01.12	Optional soft
#!-->
#sudo chmod o-rwx -R "/etc/";
#sudo chmod o-rwx -R "/boot/";
#sudo chmod o-rwx -R "/var/";
#sudo chmod o+rwx "/sys/";
#sudo chmod o+rwx -R "/srv/";
#sudo chmod o+rwx -R "/mnt/";
#sudo chmod o+rwx "/proc/";
#sudo chmod o+rwx -R "/tmp/";
#sudo chmod o+rwx "/media/";
#sudo chmod o+rwx "/dev/";
#chmod o+rx "/etc/profile";
#chmod o+rx "/etc/bash.bashrc";
#chmod o+rx "/etc/nanorc";
#chmod o+rx "/etc/passwd";
#apt-get update
#
# Install transmitter & transmitter gui
#
# https://trendoceans.com/how-to-install-transmission-bittorrent-client-on-linux/
# https://pimylifeup.com/raspberry-pi-transmission/
# https://help.ubuntu.com/community/TransmissionHowTo
# https://fostips.com/remote-control-transmission-debian/
# https://habr.com/ru/post/658463/
#
#	sudo nano /etc/init.d/transmission-daemon
#	sudo nano /etc/init/transmission-daemon.conf
#
echo -e "y\n" | sudo apt-get install transmission transmission-daemon
echo -e "y\n" | sudo apt-get install transmission-cli transmission-common transmission-daemon
# enable transmission-daemon.service
sudo systemctl enable transmission-daemon.service
# create catalogue bittorrent_download_store, bittorrent_upload
mkdir -m 775 /opt/SAMBA_SHARE/bittorrent_download_store
mkdir -m 775 /opt/SAMBA_SHARE/bittorrent_upload
chown admin_share:technics /opt/SAMBA_SHARE/bittorrent_download_store
chown :debian-transmission /opt/SAMBA_SHARE/bittorrent_upload
#gpasswd --add pub_share debian-transmission
#gpasswd --add admin_share debian-transmission
sudo usermod -aG debian-transmission admin_share
sudo usermod -aG debian-transmission admin_share
# create catalogue .transmission_config for config
cp -R /etc/transmission-daemon/ /opt/.transmission_config
chown admin_share:technics -R /opt/.transmission_config
# settings ext config ???
chmod -R 775 /opt/.transmission_config
sed -i -e "s/CONFIG_DIR=.*$/CONFIG_DIR=\"\/opt\/.transmission_config\/settings.json\"/g" /etc/default/transmission-daemon
semanage port -a -t http_port_t -p tcp 9091
semanage port -a -t http_port_t -p udp 9091
#/etc/init.d/transmission-daemon in individual USER
#NAME=transmission-daemon
#DAEMON=/usr/bin/$NAME
#USER=server
#STOP_TIMEOUT=30
#sudo systemctl edit transmission-daemon.service
#
sudo service transmission-daemon stop
sed -i -e "s/\"rpc-whitelist\"\:.*$/\"rpc-whitelist\"\: \"127.0.0.1,192.168.*.*\",/g" /var/lib/transmission-daemon/info/settings.json
#sed -i -e "s/^\"rpc-whitelist\"\:.*$/\"rpc-whitelist\"\: \"127.0.0.1,192.168.*.*\",/g" /opt/.transmission_config/settings.json
sed -i -e "s/\"rpc-username\"\:.*$/\"rpc-username\"\: \"pub_share\",/g" /var/lib/transmission-daemon/info/settings.json
#sed -i -e "s/^\"rpc-\"\:.*$/\"rpc-username\"\: \"pub_share\",/g" /opt/.transmission_config/settings.json
sed -i -e "s/\"rpc-password\"\:.*$/\"rpc-password\"\: \"vkd174\",/g" /var/lib/transmission-daemon/info/settings.json
#sed -i -e "s/^\"rpc-\"\:.*$/\"rpc-password\"\: \"vkd174\",/g" /opt/.transmission_config/settings.json
sed -i -e "s/\"download-dir\"\:.*$/\"download-dir\"\: \"\/opt\/SAMBA_SHARE\/bittorrent_download_store\",/g" /var/lib/transmission-daemon/info/settings.json
#		"watch-dir-enabled": true,
#		"watch-dir": "/home/server/torrents"
#sudo usermod -a -G debian-transmission technics
#sudo service transmission-daemon reload
sudo service transmission-daemon start
#
#
#
#dpkg --configure -a
#apt-get dist-upgrade
echo -e "\y\n" | apt-get -f install
#echo -e "y\n" | apt-get remove nvidia-*
echo -e "y\n" | apt-get autoremove
#	Display manager: gdm3 sddm
#	GDM KDM LightDM LXDM МДМ SLIM XDM
#
#	sudo systemctl disable mdm.service 
#	sudo systemctl enable sddm.service
#
#	kde-full
#	
#	sudo tasksel install kde-desktop
setenforce 1
echo -e "10_SELinux_settings" >> steps.txt
fi
echo "Press ESC key to quit"
# read a single character
while read -r -n1 key
do
# if input == ESC key
if [[ $key == $'\e' ]];
then
break;
fi
done;
#set +x
#ls -la
exit 0;
#<==---END---==>