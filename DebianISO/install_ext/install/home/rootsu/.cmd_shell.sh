#!/bin/bash -xv
#
set -x
#
#			01	User script generator
#   Version 1.1.10a
#
#
# $# - counter arguments
# $@ - listing arguments
# [-z $1] - check string
# rm -rf /tmp/*
# rm -rf /var/cache/apt/
# rm -rf /var/cache/pacman/
# rm -rf /var/cache/man/
# sudo ncdu /var/log/
# rm -rf ~/.local/share/Trash/files/
# sudo apt autoremove
# journalctl --vacuum-size=100M
# cmd -uadd [-iu] XXX -gadd [-ig] XXX 
# cmd -umod [-mu] XXX -umod [-mg] XXX 
#user_exists(){ id "$1" &>/dev/null; }
#set -x
#			01.01	Mode
USER_ADD="";
GROUP_ADD="";
UROUP_ID="";
GROUP_ID="";
SUID="";
SGID="";
SH_MODE="";
HOME_PATH="";
PWD_USER="";
COMMENT_USER="";
PARAMETER="";
#	https://www.golinuxcloud.com/bash-split-string-into-array-linux/
#	https://superuser.com/questions/461981/how-do-i-convert-a-bash-array-variable-to-a-string-delimited-with-newlines
#  username="admin"
#  groups username | sed -n -e "s/^\(.*\)\:.*/\1/p"
# 
#  psarr=$(groups admin | sed -n -e "s/.*\:\s\(.*\).*/\1/p")
#  grarr=($psarr)
# 
# echo "arr: ${grarr[1]}"
#LOG_DIR=/var/log
ROOT_UID=0     # ������ ������������ � $UID 0 ����� ���������� root.
#LINES=50       # ���������� ����������� ����� ��-���������.
#E_XCD=66       # ���������� ������� �������?
#E_NOTROOT=67   # ������� ���������� root-����������.
sign="RSA"
bits="4096"
TMP=""
#useradd	groupadd (iu/ig)	umod gmod (mu/mg) sguid suid stick sbit
cmd_usermod=("uadd" "gadd" "iu" "ig" "umod" "gmod" "mu" "mg" "sg" "su" "sb" "hd" "pwd" "cmt" "r");
cmd_mode=("ssh_keygen" "ressh_host");
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
#
#		1.2.1	Menu SELECT
#
#echo -n "cmd $USER_ADD $GROUP_ADD $3 $4 $5 $6 $7 $8 $9 \n";
while [ -n "$1" ];
do
case $1 in
--mode ) shift 
    SH_MODE=$1 ;;
--uadd ) shift 
    USER_ADD=$1 ;;
--gadd ) shift 
    GROUP_ADD=$1 ;;
#GROUP_ADD=$1 ;;
--iu ) shift 
    UROUP_ID=$1 ;;
--ig ) shift 
    GROUP_ID=$1 ;;
#--su ) shift SUID=$7 ;;
#--sg ) shift SGID=$8 ;;
#--home ) shift 
#  HOME_PATH=$1 ;;
--pwd ) shift 
    PWD_USER=$1 ;;
--cmt ) shift 
    COMMENT_USER=$1 ;;
--paramter|p ) shift 
    PARAMETER=$1 ;;
--h|help ) # �������� ��������� � ����������
	exit;;
* ) # ������ ���������
esac
shift
done

#echo -n "cmd $USER_ADD $GROUP_ADD $UROUP_ID $PWD_USER $COMMENT_USER\n";
#if [ "$GID" -ne "$ROOT_GID" ]
#then
#  echo "��� ������ �������� ��������� ����� root."
#  exit $E_NOTROOT
#fi

#echo $GROUPS
# if [ -z $1 ]; then 
#str = $groups | awk "{print $1}";
#echo $str;
if id -nGz "$USER_ADD" | grep -qzxF "$GROUP_ADD"
then
    echo User \`$USER_ADD\' belongs to group \`$GROUP_ADD\';
else
    echo User \`$USER_ADD\' does not belong to group \`$GROUP_ADD\';
	exit 1;
fi

#if ! id -u "$USER_ADD" >/dev/null 2>&1; then
#echo -e "$USER_ADD not exist"
#exit 1;
#fi

#if ! id -g "$GROUP_ADD" >/dev/null 2>&1; then
#echo -e "$GROUP_ADD not exist"
#exit 1;
#fi

# -f auth_$USER$GROUPS 
if [[ $SH_MODE == ${cmd_mode[0]} ]];
then
if [ ! -d "/home/$USER_ADD/.ssh/" ]; then
	cd /home/$USER_ADD/
	mkdir .ssh
	sudo chown $USER_ADD:$GROUP_ADD .ssh
	sudo chmod 700 /home/$USER_ADD/.ssh/
fi
	cd /home/$USER_ADD/.ssh/
if [ $? -ne 0 ]; then
	echo -e "error: not exist directory"
	exit 1;
fi
	sudo rm -rf auth*
	sudo touch authorized_keys
#	sudo touch auth_$USER_ADD$GROUP_ADD
TMP=$(date +"%m-%d-%Y+%T");
	ssh-keygen -t $sign -b $bits -f /home/$USER_ADD/.ssh/auth_$USER_ADD$GROUP_ADD -N "$PWD_USER" -C "$HOSTNAME $USER_ADD:$GROUP_ADD $TMP"
	sudo chmod 640 authorized_keys
	sudo chmod 600 auth_$USER_ADD$GROUP_ADD
	cat auth_$USER_ADD$GROUP_ADD.pub >> authorized_keys
	sudo chown $USER_ADD:$GROUP_ADD auth*
	sudo chmod 700 auth_$USER_ADD$GROUP_ADD.pub
if [[ $EUID -eq 0 ]]; then
	semanage fcontext -a -t ssh_home_t "/home/$USER_ADD/.ssh(/.*)?"
	chcon -Rv -t ssh_home_t "/home/$USER_ADD/.ssh";
fi

fi

# -f auth_$USER$GROUPS 
if [[ $SH_MODE == ${cmd_mode[1]} ]];
then
	cd /etc/ssh
	sudo rm -rf ssh_host_*
	echo -y | dpkg-reconfigure openssh-server
fi


#elif
#if[[$1 == ${cmd_arr[1]}]];
#then
	
#elif
#if[[$1 == ${cmd_arr[2]}]];
#then
#	echo "2"
#elif
#fi
#set +x
# echo you have entered the text $TEXT
exit 0
