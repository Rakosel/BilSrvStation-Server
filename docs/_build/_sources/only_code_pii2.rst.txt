Appendix Code chunck
=========================
Chunck 1
------------
.. code-block:: bash
	:linenos:

	
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
	
Chunck 2
------------
.. code-block:: bash
	:linenos:

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
Chunck 3
------------
.. code-block:: bash
	:linenos:

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
Chunck 4
------------
.. code-block:: bash
	:linenos:

	
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
Chunck 5
------------
.. code-block:: bash
	:linenos:

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
Chunck 6
------------
.. code-block:: bash
	:linenos:

	
	jumpto $start
	
	start:
	
Chunck 7
------------
.. code-block:: bash
	:linenos:

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
Chunck 8
------------
.. code-block:: bash
	:linenos:

	TMPS="0";
	interface_sh:
	
	cd /install/
	if [[ -z $(sed -n -e "s/^\(1_settings_interface_with_wifi\).*/\1/p" steps.txt) ]]; then
Chunck 9
------------
.. code-block:: bash
	:linenos:

	cd /etc/network/
Chunck 10
-------------
.. code-block:: bash
	:linenos:

	if [[ ! -f /etc/network/interfaces ]]; then
		touch interfaces
	fi
Chunck 11
-------------
.. code-block:: bash
	:linenos:

	cp interfaces interfaces.back 
Chunck 12
-------------
.. code-block:: bash
	:linenos:

	COUNT=1;
	NET_EN=""
	
	while [[ -n $( ip addr | sed -n -e "s/.*$COUNT\:\s\(.*\)\:\s<.*/\1/p") ]]
	do
	NET_ARR[COUNT]=$( ip addr | sed -n -e "s/.*$COUNT\:\s\(.*\)\:\s<.*/\1/p");
	echo Counter: $COUNT $NET_EN;
	((COUNT++));
	done
	
	COUNT=0;
Chunck 13
-------------
.. code-block:: bash
	:linenos:

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
Chunck 14
-------------
.. code-block:: bash
	:linenos:

	if [[ -z $( egrep -n '^[a-z] || ^#' interfaces) && $TMPS -eq "0" ]]; then
	reinterfaces
	fi
Chunck 15
-------------
.. code-block:: bash
	:linenos:

	
Chunck 16
-------------
.. code-block:: bash
	:linenos:

	TMPS="1";
Chunck 17
-------------
.. code-block:: bash
	:linenos:

	if [[ $STATE -eq "0" ]]; then
Chunck 18
-------------
.. code-block:: bash
	:linenos:

	if [[ -z $(sed -n -e "s/\(source \/etc\/network\/interfaces/\\).*/\1/p" interfaces) ]]; then
			TMPS="1";
			reinterfaces;
	fi
	
	if [[ -z $(sed -n -e "s/\(auto\slo\).*/\1/p" interfaces) ]]; then
			TMPS="1";
			reinterfaces;
	fi
	sed -i -e "s/\(auto\s\).*/\1$NET_WI $NET_EN/g" interfaces
Chunck 19
-------------
.. code-block:: bash
	:linenos:

	if [[ -z $( sed -n -e "s/\(iface\slo\).*/\1/p" interfaces) ]]; then
			TMPS="1";
			reinterfaces;
	fi
Chunck 20
-------------
.. code-block:: bash
	:linenos:

	sed -i -e "s/iface\slo.*/iface $NET_EN inet dhcp/g" interfaces
Chunck 21
-------------
.. code-block:: bash
	:linenos:

	if [[ -z $( sed -n -e "s/\(allow-hotplug\s\).*/\1/p" interfaces) ]]; then
			TMPS="1";
			reinterfaces;
	fi
	sed -i -e "s/\(allow-hotplug\s\).*/\1$NET_WI/g" interfaces
Chunck 22
-------------
.. code-block:: bash
	:linenos:

	if [[ -z $( sed -n -e "s/\(iface\s\).*/\1/p" interfaces) ]]; then
			TMPS="1";
			reinterfaces;
	fi
Chunck 23
-------------
.. code-block:: bash
	:linenos:

	sed -i -e "$a s/\(iface\s\).*/\1$NET_WI inet dhcp/g" interfaces
Chunck 24
-------------
.. code-block:: bash
	:linenos:

	sed '$a	wpa-conf \/home\/rootsu\/wpa_supplicant.conf' interfaces >> interfaces;
Chunck 25
-------------
.. code-block:: bash
	:linenos:

	systemctl restart wpa_supplicant
Chunck 26
-------------
.. code-block:: bash
	:linenos:

	else
	
	if [[ -z $(sed -n -e "s/\(source \/etc\/network\/interfaces/\\).*/\1/p" interfaces) ]]; then
			TMPS="1";
			reinterfaces;
	fi
Chunck 27
-------------
.. code-block:: bash
	:linenos:

	if [[ -z $(sed -n -e "s/\(auto\slo\).*/\1/p" interfaces) ]]; then
			TMPS="1";
			reinterfaces;
	fi
	sed -i -e "s/\(auto\s\).*/\1$NET_EN/g" interfaces
Chunck 28
-------------
.. code-block:: bash
	:linenos:

	if [[ -z $(sed -n -e "s/\(iface\slo\).*/\1/p" interfaces) ]]; then
			TMPS="1";
			reinterfaces;
	fi
	sed -i -e "s/iface\slo.*/iface $NET_EN inet dhcp/g" interfaces
Chunck 29
-------------
.. code-block:: bash
	:linenos:

	if [[ -z $(sed -n -e "s/\(allow-hotplug\s\).*/\1/p" interfaces) ]]; then
			TMPS="1";
			reinterfaces;
	fi
	sed -i -e "s/\(allow-hotplug\s\).*/\1$NET_EN/g" interfaces
Chunck 30
-------------
.. code-block:: bash
	:linenos:

	if [[ -z $(sed -n -e "s/\(iface\s\).*/\1/p" interfaces) ]]; then
			TMPS="1";
			reinterfaces;
	fi
Chunck 31
-------------
.. code-block:: bash
	:linenos:

	sed -i -e "$a s/\(iface\s\).*/\1$NET_EN inet dhcp/g" interfaces
Chunck 32
-------------
.. code-block:: bash
	:linenos:

	fi
Chunck 33
-------------
.. code-block:: bash
	:linenos:

	
	systemctl restart networking 
	 
	cd /install/
	echo -e "1_settings_interface_with_wifi" >> steps.txt
	fi
Chunck 34
-------------
.. code-block:: bash
	:linenos:

	step_one:
	
	cd /install/
	if [[ -z $(sed -n -e "s/^\(1_src_list\).*/\1/p" steps.txt) ]]; then
	
	cd /etc/apt/
	if [[ -z $( lsb_release -d | sed -n -e 's/.*(\([^\)]\+\))/\1/p') ]]; then
Chunck 35
-------------
.. code-block:: bash
	:linenos:

		DEB_VER=$(cat /etc/os-release | sed -n -e "s/.*(\([^\)].*\))\"$/\1/p");
		DEB_VER=$(echo $DEB_VER | sed -n -e "s/\([a-z]*\)$//p")
	else
		DEB_VER=$( lsb_release -d | sed -n -e 's/.*(\([^\)]\+\))/\1/p')
	fi;
Chunck 36
-------------
.. code-block:: bash
	:linenos:

	if [[ -n $(egrep -n '^[a-z] && ^#' sources.list) && -n $( sed -n -e "s/^deb http:\/\/ftp//p" sources.list) && -n $( sed -n -e "s/^deb-src http:\/\/ftp//p" sources.list) && -n $( sed -n -e "s/^deb http:\/\/deb//p" sources.list) && -n $( sed -n -e "s/^deb-src http:\/\/deb//p" sources.list) ]]; then
	STATE="1";
	rm sources.list;
Chunck 37
-------------
.. code-block:: bash
	:linenos:

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
Chunck 38
-------------
.. code-block:: bash
	:linenos:

	else
Chunck 39
-------------
.. code-block:: bash
	:linenos:

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
	
Chunck 40
-------------
.. code-block:: bash
	:linenos:

	step_two:
	
	cd /install/
	if [[ -z $(sed -n -e "s/^\(2_install_driver\).*/\1/p" steps.txt) ]]; then
	
	if [[ $(lspci | grep VGA | sed -n -e "s/.*\[\(.*\)\/.*/\1/p") == "AMD" ]]; then 
		echo -e "y\n" | apt-get install libdrm-amdgpu1
		echo -e "y\n" | apt-get install xserver-xorg-video-amdgpu
	else
		echo -e "y\n" | apt-get install nvidia-driver firmware-misc-nonfree nvidia-settings
	fi
Chunck 41
-------------
.. code-block:: bash
	:linenos:

	echo -e "y\n" | apt-get install firmware-linux
	
	if [[ $(lspci | grep Ethernet | sed -n -e "s/.*ller:\s\([a-zA-Z]\+\s\).*/\1/p") == "Realtek" ]]; then 
	echo -e "y\n" | apt-get install firmware-realtek
	fi
	echo -e "y\n" | apt-get install firmware-linux-nonfree
	echo -e "y\n" | apt-get install firmware-iwlwifi
	echo -e "y\n" | apt-get install man 
Chunck 42
-------------
.. code-block:: bash
	:linenos:

	echo -e "y\n" | apt-get install acl
	echo -e "y\n" | apt-get install setools policycoreutils selinux-basics selinux-utils selinux-policy-default selinux-policy-mls auditd policycoreutils-python-utils semanage-utils audispd-plugins
	echo -e "y\n" | apt-get install mcstrans
	
	sudo systemctl enable auditd
	sudo systemctl start auditd
Chunck 43
-------------
.. code-block:: bash
	:linenos:

	touch /.autorelabel
	selinux-activate
	
	if [ $? -ne 0 ]; then
	 echo "Error: install driver failed!!!"
	 exit 1
	fi
	
	echo -e "2_install_driver" >> steps.txt
Chunck 44
-------------
.. code-block:: bash
	:linenos:

	reboot
	fi
Chunck 45
-------------
.. code-block:: bash
	:linenos:

	
	if [[ -z $(sed -n -e "s/^\(3_nanorc\).*/\1/p" steps.txt) ]]; then
Chunck 46
-------------
.. code-block:: bash
	:linenos:

	echo -e "y\n" | apt-get install git
	if [ 
	? -ne 0 ]; then
	 echo "Error: error install git!!!"
	 exit 1;
	fi
	cd /install
	git clone git://git.savannah.gnu.org/nano.git; cd nano;./autogen.sh;./configure; make install 
Chunck 47
-------------
.. code-block:: bash
	:linenos:

	find /usr/share/nano -name '*.nanorc' -printf "include %p\n" > ~/.nanorc
Chunck 48
-------------
.. code-block:: bash
	:linenos:

	fi
	echo -e "3_nanorc" >> steps.txt
Chunck 49
-------------
.. code-block:: bash
	:linenos:

	if [[ -z $(sed -n -e "s/^\(4_copy_sh\).*/\1/p" steps.txt) ]]; then
Chunck 50
-------------
.. code-block:: bash
	:linenos:

	cd /install/
	cp -Rf /install/home/* /home/
	cp -Rf /install/home/rootsu/.bashrc ~root 
	cp -Rf /install/home/rootsu/.profile ~root 
	cp -Rf /install/home/rootsu/.cmd_shell.sh ~root
	
	cp -Rf /install/home/rootsu/* ~root
	chmod ug+rwx -Rf ~root
Chunck 51
-------------
.. code-block:: bash
	:linenos:

	echo -e "4_copy_sh" >> steps.txt
	fi
Chunck 52
-------------
.. code-block:: bash
	:linenos:

	if [[ -z $(sed -n -e "s/^\(5_install_util_wd\).*/\1/p" steps.txt) ]]; then
Chunck 53
-------------
.. code-block:: bash
	:linenos:

	echo "y\n" | apt-get install build-essential
	if [ $? -ne 0 ]; then
	 echo "Error: error install gcc-utils!!!"
	 exit 1
	fi
	
	add-apt-repository-get ppa:ubuntu-toolchain-r/test && apt update
Chunck 54
-------------
.. code-block:: bash
	:linenos:

	echo -e "y\n" | apt-get install python
	echo -e "y\n" | apt-get install python3
	echo -e "y\n" | apt-get install tmux;
	echo -e "y\n" | apt-get install net-tools
	echo -e "y\n" | apt-get install manpages-dev;
	echo -e "y\n" | apt-get install wpa_supplicant;
	echo -e "y\n" | apt-get install mc;
	echo -e "y\n" | apt-get install ncdu;
Chunck 55
-------------
.. code-block:: bash
	:linenos:

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
Chunck 56
-------------
.. code-block:: bash
	:linenos:

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
	echo -e "y\n" | apt-get install smartmontools
	echo -e "y\n" | apt-get install python3-sphinx
	echo -e "y\n" | apt-get install nfs-common
	echo -e "y\n" | apt-get install build-essential libssl-dev libffi-dev python3-dev
	echo -e "y\n" | apt-get install python3-venv
	echo -e "y\n" | apt-get install mdadm 
	systemctl enable mdadm
	update-initramfs -u
	
	python3 -m venv env
Chunck 57
-------------
.. code-block:: bash
	:linenos:

	pip install --upgrade myst-parser
	pip install sphinx-autodocgen
	pip install Pygments
	pip install sphinx-intl
	pip install lumache
	pip install django
	pip install django-docs
	pip install sphinxnotes-strike
	pip install sphinx_rtd_theme
Chunck 58
-------------
.. code-block:: bash
	:linenos:

	pip install -U sphinx
	python -m venv .venv
Chunck 59
-------------
.. code-block:: bash
	:linenos:

	systemctl enable cron
Chunck 60
-------------
.. code-block:: bash
	:linenos:

	systemctl enable autofs
Chunck 61
-------------
.. code-block:: bash
	:linenos:

	
	apt-get install openssh-server -y
	if [ $? -ne 0 ]; then
	 echo "Error: error install setup-utils!!!"
	 exit 1
	fi
	
Chunck 62
-------------
.. code-block:: bash
	:linenos:

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
	
Chunck 63
-------------
.. code-block:: bash
	:linenos:

	
	fi
Chunck 64
-------------
.. code-block:: bash
	:linenos:

	step_three:
	
Chunck 65
-------------
.. code-block:: bash
	:linenos:

	step_four:
	cd /install/
	if [[ -z $(sed -n -e "s/^\(7_driver_opt\).*/\1/p" steps.txt) ]]; then
Chunck 66
-------------
.. code-block:: bash
	:linenos:

	
Chunck 67
-------------
.. code-block:: bash
	:linenos:

	
Chunck 68
-------------
.. code-block:: bash
	:linenos:

	
Chunck 69
-------------
.. code-block:: bash
	:linenos:

	
Chunck 70
-------------
.. code-block:: bash
	:linenos:

	
Chunck 71
-------------
.. code-block:: bash
	:linenos:

	cd /install/
	touch fdisk.txt
	fdisk -l | sed -n -e "s/.*\(\/dev\/s[a-z]*[0-9]\).*/\1/p" > fdisk.txt
	
	filename='fdisk.txt'
	n=1
	while read line; do
Chunck 72
-------------
.. code-block:: bash
	:linenos:

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
Chunck 73
-------------
.. code-block:: bash
	:linenos:

	done < $filename
	sudo mount -a
Chunck 74
-------------
.. code-block:: bash
	:linenos:

	echo -e "7_driver_opt" >> steps.txt
	fi
Chunck 75
-------------
.. code-block:: bash
	:linenos:

	cd /install/
Chunck 76
-------------
.. code-block:: bash
	:linenos:

	
Chunck 77
-------------
.. code-block:: bash
	:linenos:

	
Chunck 78
-------------
.. code-block:: bash
	:linenos:

	
	if [[ -z $(sed -n -e "s/^\(9_user_settings\).*/\1/p" steps.txt) ]]; then
	
	STEP_TWO_AFTER:
	
Chunck 79
-------------
.. code-block:: bash
	:linenos:

	 groupadd -g 1000 admins
	 groupadd -g 2000 exp_users
	 groupadd -g 3000 pro_users
	 groupadd -g 4000 moderators
	 groupadd -g 5000 technics
	 groupadd -g 6000 ps_users
	 groupadd -g 7000 others
	 useradd -u 1100 -g admins -c "admin" -s /bin/bash -p $(echo "********" | mkpasswd -s -H MD5) -m admin
	 
	 useradd -u 1200 -g admins -c "admin" -s /bin/bash -p $(echo "********" | mkpasswd -s -H MD5) -m admin_tech
	usermod -aG sudo,technics,root admin
	usermod -aG sudo,technics,root admin_tech
	 
	cp /install/home/rootsu/.bashrc /home/admin/ 
	cp /install/home/rootsu/.profile /home/admin/
	cp /install/home/rootsu/.cmd_shell.sh /home/admin/
	
	 useradd -u 2100 -g exp_users -s /bin/bash -c "far_exp" -p $(echo "********" | mkpasswd -s -H MD5) -m far_exp
	 useradd -u 3100 -g pro_users -s /bin/bash -c "far_pro" -p $(echo "********" | mkpasswd -s -H MD5) -m far_pro
	 useradd -u 4100 -g moderators -s /bin/bash -c "far_moderator" -p $(echo "********" | mkpasswd -s -H MD5) -m far_mod
	 useradd -u 5100 -g technics -d /opt/SAMBA_SHARE/ -s /bin/false -c "technical admin_share" -p $(echo "********" | mkpasswd -s -H MD5) admin_share
	 useradd -u 5200 -g technics -d /opt/SAMBA_SHARE/ -s /bin/false -c "technical pub_share" -p $(echo "********" | mkpasswd -s -H MD5) pub_share
	 useradd -u 6100 -g ps_users -s /bin/bash -c "far_user" -p $(echo "********" | mkpasswd -s -H MD5) -m far_user
Chunck 80
-------------
.. code-block:: bash
	:linenos:

	useradd -g ps_users -c "tom" -s /bin/bash -p $(echo "********" | mkpasswd -s -H MD5) -m tom
Chunck 81
-------------
.. code-block:: bash
	:linenos:

	echo -e "********\n********" | smbpasswd -a admin_share
	echo -e "********\n********" | smbpasswd -a pub_share
	smbpasswd -e admin_share
	smbpasswd -e pub_share
Chunck 82
-------------
.. code-block:: bash
	:linenos:

	
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
Chunck 83
-------------
.. code-block:: bash
	:linenos:

	
Chunck 84
-------------
.. code-block:: bash
	:linenos:

	cd /etc/ssh/
	
	cp sshd_config sshd_config.tmp
Chunck 85
-------------
.. code-block:: bash
	:linenos:

	 sed -i -e "s/#Port\s.*$\|Port\s.*$/Port $PORT_SSH/g" sshd_config
Chunck 86
-------------
.. code-block:: bash
	:linenos:

	 sed -i -e "s/#HostKey/HostKey/g" sshd_config
Chunck 87
-------------
.. code-block:: bash
	:linenos:

	 sed -i -e "s/#PubkeyAuthentication\s.*$\|PubkeyAuthentication\s.*$/PubkeyAuthentication yes/g" sshd_config
Chunck 88
-------------
.. code-block:: bash
	:linenos:

	 sed -i -e "s/#SysLogFacility\s.*$\|SysLogFacility\s.*$/SysLogFacility AUTHPRIV/g" sshd_config
Chunck 89
-------------
.. code-block:: bash
	:linenos:

	 sed -i -e "s/#LogLevel\s.*$\|LogLevel\s.*$/#LogLevel INFO/g" sshd_config
Chunck 90
-------------
.. code-block:: bash
	:linenos:

	 sed -i -e "s/#LoginGraceTime\s.*$\|LoginGraceTime\s.*$/LoginGraceTime 2m/g" sshd_config
Chunck 91
-------------
.. code-block:: bash
	:linenos:

	 sed -i -e "s/#PermitRootLogin\s.*$\|PermitRootLogin\s.*$/PermitRootLogin yes/g" sshd_config
Chunck 92
-------------
.. code-block:: bash
	:linenos:

	 sed -i -e "s/#StrictModes\s.*$\|StrictModes\s.*$/StrictModes no/g" sshd_config
Chunck 93
-------------
.. code-block:: bash
	:linenos:

	 sed -i -e "s/#MaxAuthTries\s.*$\|MaxAuthTries\s.*$/MaxAuthTries 3/g" sshd_config
Chunck 94
-------------
.. code-block:: bash
	:linenos:

	 sed -i -e "s/#MaxSessions\s.*$\|MaxSessions\s.*$/MaxSessions 3/g" sshd_config
Chunck 95
-------------
.. code-block:: bash
	:linenos:

	 sed -i -e "s/#AuthorizedKeysFile\s.*$\|AuthorizedKeysFile\s.*$/AuthorizedKeysFile \/home\/rootsu\/.ssh\/authorized_keys \/home\/%u\/.ssh\/authorized_keys/g" sshd_config
Chunck 96
-------------
.. code-block:: bash
	:linenos:

	 sed -i -e "s/#PasswordAuthentication\s.*$\|PasswordAuthentication\s.*$/PasswordAuthentication no/g" sshd_config
Chunck 97
-------------
.. code-block:: bash
	:linenos:

	 sed -i -e "s/#PermitEmptyPasswords\s.*$\|PermitEmptyPasswords\s.*$/PermitEmptyPasswords no/g" sshd_config
Chunck 98
-------------
.. code-block:: bash
	:linenos:

	 sed -i -e "s/ChallengeResponseAuthentication.*$\|#ChallengeResponseAuthentication.*$/ChallengeResponseAuthentication yes/g" sshd_config
Chunck 99
-------------
.. code-block:: bash
	:linenos:

	 sed -i -e "s/#UsePAM\s.*$\|UsePAM\s.*$/UsePAM yes/g" sshd_config
Chunck 100
--------------
.. code-block:: bash
	:linenos:

	 sed -i -e "s/#AllowTcpForwarding\s.*$\|AllowTcpForwarding\s.*$/AllowTcpForwarding yes/g" sshd_config
Chunck 101
--------------
.. code-block:: bash
	:linenos:

	 sed -i -e "s/#X11Forwarding\s.*$\|X11Forwarding\s.*$/X11Forwarding yes/g" sshd_config
Chunck 102
--------------
.. code-block:: bash
	:linenos:

	 sed -i -e "s/#X11DisplayOffset\s.*$\|X11DisplayOffset\s.*$/X11DisplayOffset 10/g" sshd_config
Chunck 103
--------------
.. code-block:: bash
	:linenos:

	 sed -i -e "s/#PrintMotd\s.*$\|PrintMotd\s.*$/PrintMotd yes/g" sshd_config
Chunck 104
--------------
.. code-block:: bash
	:linenos:

	 sed -i -e "s/Subsystem\s/#Subsystem\s/g" sshd_config
Chunck 105
--------------
.. code-block:: bash
	:linenos:

	systemctl restart ssh
Chunck 106
--------------
.. code-block:: bash
	:linenos:

	sudo bash ~/.cmd_shell.sh --mode "ssh_keygen" --uadd "tom" --gadd "ps_users" --pwd "debian"
	bash ~/.cmd_shell.sh --mode "ssh_keygen" --uadd "admin" --gadd "admins" --pwd "debian"
Chunck 107
--------------
.. code-block:: bash
	:linenos:

	
	mount -v -t cifs //192.168.1.1/SOFT_2TBSEAGREEN//mnt/SMB/SOFT_2TBSEAGREEN -o credentials=/home/rootsu/.smbusers,defcontext="system_u:object_r:samba_share_t:s0";
	mount -v -t cifs //192.168.1.1/SOFT_3TBSEASYAN//mnt/SMB/SOFT_3TBSEASYAN -o credentials=/home/rootsu/.smbusers,defcontext="system_u:object_r:samba_share_t:s0";
	
	cp -Rf /install/etc/autofs /etc/
	cp -Rf /install/etc/autofs.conf /etc/
	cp -Rf /install/etc/samba /etc/
	cp -Rf /install/lib/ /lib/
	chmod 644 -Rf /etc/autofs/
	
	systemctl restart autofs
	systemctl restart smbd
	
Chunck 108
--------------
.. code-block:: bash
	:linenos:

	echo -e "y" | apt-get install ntfs-3g;
Chunck 109
--------------
.. code-block:: bash
	:linenos:

	echo -e "y" | sudo apt install vsftpd
	
	cd /etc/
	sudo cp /etc/vsftpd.conf/etc/vsftpd.conf_default
	
Chunck 110
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "s/listen=.*$/listen=YES/g" vsftpd.conf
Chunck 111
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "s/listen_ipv6=.*$/listen_ipv6=NO/g" vsftpd.conf
Chunck 112
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "s/#anonymous_enable=.*$\|anonymous_enable=.*$/anonymous_enable=NO/g" vsftpd.conf
Chunck 113
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "s/#anon_upload_enable=.*$\|anon_upload_enable=.*$/anon_upload_enable=NO/g" vsftpd.conf
Chunck 114
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "s/anon_mkdir_write_enable=.*$\|#anon_mkdir_write_enable=.*$/anon_mkdir_write_enable=NO/g" vsftpd.conf
Chunck 115
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "s/#write_enable=.*$\|write_enable=.*$/write_enable=YES/g" vsftpd.conf
Chunck 116
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "s/#local_umask=.*$\|local_umask=.*$/local_umask=022/g" vsftpd.conf
Chunck 117
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "s/connect_from_port_20=.*$/connect_from_port_20=NO/g" vsftpd.conf
Chunck 118
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "s/#ascii_upload_enable=.*$\|ascii_upload_enable=.*$/ascii_upload_enable=YES/g" vsftpd.conf
Chunck 119
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "s/#ascii_upload_enable=.*$\|ascii_upload_enable=.*$/ascii_upload_enable=YES/g" vsftpd.conf
Chunck 120
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "s/#ascii_download_enable=.*$\|ascii_download_enable=.*$/ascii_download_enable=YES/g" vsftpd.conf
Chunck 121
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "s/#ftpd_banner=.*$\|ftpd_banner=.*$/ftpd_banner=Welcome to $HOSTNAME!!!/g" vsftpd.conf
Chunck 122
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "0,/#chroot_local_user=.*$\|chroot_local_user=.*$/ s//chroot_local_user=YES/g" vsftpd.conf
Chunck 123
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "s/#ls_recurse_enable=.*$\|ls_recurse_enable=.*$/ls_recurse_enable=YES/g" vsftpd.conf
Chunck 124
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "s/#chroot_list_file=.*$\|chroot_list_file=.*$/chroot_list_file=\/home\/rootsu\/vsftpd.chroot_list/g" vsftpd.conf
Chunck 125
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "s/#utf8_filesystem=.*$\|utf8_filesystem=.*$/utf8_filesystem=YES/g" vsftpd.conf
Chunck 126
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "s/pam_service_name=.*$/#pam_service_name=vsftpd/g" vsftpd.conf
Chunck 127
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "s/rsa_cert_file=.*$\|#rsa_cert_file=.*$/rsa_cert_file=\/etc\/ssl\/certs\/vsftpd.crt/g" vsftpd.conf
Chunck 128
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "s/rsa_private_key_file=.*$\|#rsa_private_key_file=.*$/rsa_private_key_file=\/etc\/ssl\/private\/vsftpd.key/g" vsftpd.conf
Chunck 129
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "s/ssl_enable=.*$\|#ssl_enable=.*$/ssl_enable=YES/g" vsftpd.conf
Chunck 130
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "$ a force_dot_files=YES" vsftpd.conf
Chunck 131
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "$ a allow_anon_ssl=NO" vsftpd.conf
Chunck 132
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "$ a force_local_data_ssl=NO" vsftpd.conf
Chunck 133
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "$ a force_local_logins_ssl=YES" vsftpd.conf
Chunck 134
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "$ a ssl_sslv3=YES" vsftpd.conf
Chunck 135
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "$ a require_ssl_reuse=YES" vsftpd.conf
Chunck 136
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "$ a ssl_ciphers=HIGH" vsftpd.conf
Chunck 137
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "$ a cmds_allowed=ABOR,CWD,RMW,DELE,LIST,MDTM,MKD,NLST,PASS,PASV,PORT,PWD,QUIT,RETR,RMD,RNFR,RNTO,SITE,SIZE,STOR,TYPE,USER,CDUP,HELP,MODE,NOOP,STAT,STOU,STRU" vsftpd.conf
	
Chunck 138
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "$ a userlist_enable=YES" vsftpd.conf
Chunck 139
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "$ a userlist_deny=NO" vsftpd.conf
Chunck 140
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "$ a userlist_enable=YES" vsftpd.conf
Chunck 141
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "$ a userlist_file=/home/rootsu/vsftpd-virtual_user/vsftpd_user" vsftpd.conf
Chunck 142
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "$ a user_config_dir=/home/rootsu/vsftpd-virtual_user/" vsftpd.conf
Chunck 143
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "$ a chown_uploads=YES" vsftpd.conf
Chunck 144
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "$ a chown_username=nobody" vsftpd.conf
Chunck 145
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "$ a tcp_wrappers=YES" vsftpd.conf
Chunck 146
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "$ a max_per_ip=10" vsftpd.conf
Chunck 147
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "$ a userlist_enable=YES" vsftpd.conf
Chunck 148
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "$ a local_enable=YES" vsftpd.conf
Chunck 149
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "$ a virtual_use_local_privs=YES" vsftpd.conf
Chunck 150
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "$ a listen_port=21" vsftpd.conf
Chunck 151
--------------
.. code-block:: bash
	:linenos:

	cd /etc/pam.d/
	sed -i -e "s/auth	required	pam_shells.so.*$\|#auth	required	pam_shells.so.*$/#auth	required	pam_shells.so/g" vsftpd
Chunck 152
--------------
.. code-block:: bash
	:linenos:

	echo -e "RU\nRussia\nSaratov\n$HOSTNAME Ltd.\nWSB-IOT-Embedded\nadmin\nfar1803@ya.ru\n" | openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt
	
	chmod 770 /home/rootsu/vsftpd-virtual_user
	chmod 770 /home/rootsu/vsftpd.chroot_list
	chmod 750 -R /home/rootsu
	
Chunck 153
--------------
.. code-block:: bash
	:linenos:

	iptables -F
	sudo systemctl restart vsftpd
	sudo systemctl enable vsftpd
	iptables –F
Chunck 154
--------------
.. code-block:: bash
	:linenos:

	cp -Rf /home/admin/.ssh/ /media/admin/ssh
	
	cp -Rf /home/tom/.ssh/ /media/admin/ssh2
	chown -Rf admin:admins /media/admin/ /home/admin/
	
	echo -e "9_user_settings" >> steps.txt
	fi
Chunck 155
--------------
.. code-block:: bash
	:linenos:

	
Chunck 156
--------------
.. code-block:: bash
	:linenos:

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
	
Chunck 157
--------------
.. code-block:: bash
	:linenos:

	
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
Chunck 158
--------------
.. code-block:: bash
	:linenos:

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
Chunck 159
--------------
.. code-block:: bash
	:linenos:

	semanage permissive -a boot_t 
Chunck 160
--------------
.. code-block:: bash
	:linenos:

	setsebool -P cron_can_relabel 1
	setsebool -P fcron_crond 1
	setsebool -P cron_userdomain_transition 1
	setsebool -P cron_manage_all_user_content 1
	setsebool -P cron_read_all_user_content 1
	setsebool -P cron_read_generic_user_content 1
	
Chunck 161
--------------
.. code-block:: bash
	:linenos:

	setsebool -P allow_mount_anyfile 1
	setsebool -P webadm_manage_user_files 1
	setsebool -P webadm_read_user_files 1
	
Chunck 162
--------------
.. code-block:: bash
	:linenos:

	setsebool -P samba_export_all_ro 1
	setsebool -P samba_export_all_rw 1
	setsebool -P dhcpc_manage_samba 1
	setsebool -P samba_create_home_dirs 1
	setsebool -P samba_enable_home_dirs 1
	setsebool -P samba_share_fusefs 1
	setsebool -P samba_share_nfs 1
	setsebool -P use_samba_home_dirs 1
Chunck 163
--------------
.. code-block:: bash
	:linenos:

	setsebool -P virt_use_samba 1
	setsebool -P virt_use_nfs 1
	setsebool -P samba_portmapper 1
	setsebool -P systemd_tmpfiles_manage_all 1
	setsebool -P cron_manage_generic_user_content 1
	
Chunck 164
--------------
.. code-block:: bash
	:linenos:

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
Chunck 165
--------------
.. code-block:: bash
	:linenos:

	
	cd /etc/selinux
	
Chunck 166
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "s/SELINUX=permissive\|SELINUX=default/SELINUX=enforcing/g" config
Chunck 167
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "s/%sudo.*$/%sudo	ALL=(root) ROLE=sysadm_r NOPASSWD:ALL/g" /etc/sudoers
	sed -i -e "s/%admins.*$/%admins	ALL=(root) NOPASSWD:ALL/g" /etc/sudoers
	sed -i -e "s/admin.*$/admin	ALL=(root) NOPASSWD:ALL/g" /etc/sudoers
	
	sed -i -e '1 a session	required	pam_selinux.so	close' /etc/pam.d/sshd
	sed -i -e '$a session	required	pam_selinux.so	multiple open' /etc/pam.d/sshd >> /etc/pam.d/sshd
	sed -i -e '$a session	required	pam_access.so' /etc/pam.d/sshd >> /etc/pam.d/sshd
	
	sed -i -e '$a -a exit,always -S open -F auid>=0' /etc/audit/audit.rules
	
	chmod o-x "/etc/systemd/system.conf";
Chunck 168
--------------
.. code-block:: bash
	:linenos:

	chmod o-rwx -R "/boot/";
Chunck 169
--------------
.. code-block:: bash
	:linenos:

	chmod o-rwx -R "/srv/";
	chmod o-rwx -R "/mnt/";
Chunck 170
--------------
.. code-block:: bash
	:linenos:

	semanage fcontext -a -t tmp_t "/tmp(/.*)?"
	chcon -t tmp_t -R "/tmp"
	chmod o-rwx -R "/tmp/";
	chmod o-rwx "/media/";
Chunck 171
--------------
.. code-block:: bash
	:linenos:

	semanage fcontext -a -t system_cron_spool_t "/var/spool/cron(/.*)?"
	chcon -t system_cron_spool_t -Rv /var/spool/cron/
	
	chmod o-r -R "/home/";
	chmod o-x -R "/home/rootsu" "/home/admin/";
Chunck 172
--------------
.. code-block:: bash
	:linenos:

	
	echo "deb https:\\\download.webmin.com\download\repository sarge contrib" >> /etc/apt/sources.list
Chunck 173
--------------
.. code-block:: bash
	:linenos:

	cd ~
Chunck 174
--------------
.. code-block:: bash
	:linenos:

	
	semodule -i loaderlocalv1.pp
	semodule -i loaderlocalv2.pp
	semodule -i loaderlocalv3.pp
	semodule -i loaderlocalv4.pp
	
Chunck 175
--------------
.. code-block:: bash
	:linenos:

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
	semodule -i myapp1.pp
	semanage permissive -a boot_t
	semanage permissive -a crond_t
	semanage permissive -a crontab_t
	semanage permissive -a system_crontab_t
	semanage module -d permissive_boot_t
Chunck 176
--------------
.. code-block:: bash
	:linenos:

	semanage user -m -R "system_r sysadm_r staff_r" -r "s0-s0:c0.c1023" sysadm_u
Chunck 177
--------------
.. code-block:: bash
	:linenos:

	semanage login -a -s sysadm_u -r "s0-s0:c0.c1023" admin
	semanage login -a -s sysadm_u -r "s0-s0:c0.c1023" admin_tech
	semanage login -a -s sysadm_u -r "s0-s0:c0.c1023" %admins
Chunck 178
--------------
.. code-block:: bash
	:linenos:

	semanage login -a -s unconfined_u -r "s0-s0:c0.c1023" %sudo
	semanage login -a -s user_u tom
Chunck 179
--------------
.. code-block:: bash
	:linenos:

	
Chunck 180
--------------
.. code-block:: bash
	:linenos:

	
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
Chunck 181
--------------
.. code-block:: bash
	:linenos:

	semanage port -a -t http_port_t -p tcp 10000
	semanage port -a -t http_port_t -p tcp 20000
	
	systemctl enable webmin
	systemctl start webmin
	
Chunck 182
--------------
.. code-block:: bash
	:linenos:

	echo -e "y\n" | sudo apt-get install transmission
	echo -e "y\n" | sudo apt-get install transmission-cli transmission-common transmission-daemon
Chunck 183
--------------
.. code-block:: bash
	:linenos:

	sudo systemctl enable transmission-daemon.service
Chunck 184
--------------
.. code-block:: bash
	:linenos:

	mkdir -m 775 /opt/SAMBA_SHARE/bittorrent_download_store
	mkdir -m 775 /opt/SAMBA_SHARE/bittorrent_upload
	chown admin_share:technics /opt/SAMBA_SHARE/bittorrent_download_store
	chown :debian-transmission /opt/SAMBA_SHARE/bittorrent_upload
Chunck 185
--------------
.. code-block:: bash
	:linenos:

	sudo usermod -aG debian-transmission admin_share
	sudo usermod -aG debian-transmission admin_share
Chunck 186
--------------
.. code-block:: bash
	:linenos:

	cp -R /etc/transmission-daemon/ /opt/.transmission_config
	chown admin_share:technics -R /opt/.transmission_config
Chunck 187
--------------
.. code-block:: bash
	:linenos:

	chmod -R 775 /opt/.transmission_config
	sed -i -e "s/CONFIG_DIR=.*$/CONFIG_DIR=\"\/opt\/.transmission_config\/settings.json\"/g" /etc/default/transmission-daemon
	semanage port -a -t http_port_t -p tcp 9091
	semanage port -a -t http_port_t -p udp 9091
Chunck 188
--------------
.. code-block:: bash
	:linenos:

	sudo service transmission-daemon stop
	sed -i -e "s/\"rpc-whitelist\"\:.*$/\"rpc-whitelist\"\: \"127.0.0.1,192.168.*.*\",/g" /var/lib/transmission-daemon/info/settings.json
Chunck 189
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "s/\"rpc-username\"\:.*$/\"rpc-username\"\: \"pub_share\",/g" /var/lib/transmission-daemon/info/settings.json
Chunck 190
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "s/\"rpc-password\"\:.*$/\"rpc-password\"\: \"********\",/g" /var/lib/transmission-daemon/info/settings.json
Chunck 191
--------------
.. code-block:: bash
	:linenos:

	sed -i -e "s/\"download-dir\"\:.*$/\"download-dir\"\: \"\/opt\/SAMBA_SHARE\/bittorrent_download_store\",/g" /var/lib/transmission-daemon/info/settings.json
Chunck 192
--------------
.. code-block:: bash
	:linenos:

	service transmission-daemon start
Chunck 193
--------------
.. code-block:: bash
	:linenos:

	mdadm --detail --scan | sudo tee -a /etc/mdadm/mdadm.conf
	update-initramfs -u
Chunck 194
--------------
.. code-block:: bash
	:linenos:

	echo '/dev/md0 /mnt/sde1 ext4 defaults,nofail,discard 1 0' | tee -a /etc/fstab
Chunck 195
--------------
.. code-block:: bash
	:linenos:

	
Chunck 196
--------------
.. code-block:: bash
	:linenos:

	echo -e "\y\n" | apt-get -f install
Chunck 197
--------------
.. code-block:: bash
	:linenos:

	echo -e "y\n" | apt-get autoremove
Chunck 198
--------------
.. code-block:: bash
	:linenos:

	setenforce 1
	echo -e "10_SELinux_settings" >> steps.txt
	fi
	echo "Press ESC key to quit"
Chunck 199
--------------
.. code-block:: bash
	:linenos:

	while read -r -n1 key
	do
Chunck 200
--------------
.. code-block:: bash
	:linenos:

	if [[ $key == $'\e' ]];
	then
	break;
	fi
	done;
Chunck 201
--------------
.. code-block:: bash
	:linenos:

	exit 0;
