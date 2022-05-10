#!/bin/bash
#
#	Version 1.1.2a
#
#	- Otsuttvuet dop proverka znachenyi
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
#
#			1.2.1	define parameters
#
USER_ADD="";
GROUP_ADD="";
UROUP_ID="";
GROUP_ID="";
SUID="";
SGID="";
HOME_PATH="";
PWD_USER="";
COMMENT_USER="";
USER_PARAM="";
MODE="";
TEMP="";
COUNT=0;
RANGE_MIN="1000"
RANGE_MAX="10000"
cmd_grp_res=("1000","admin","2000","far_exp","3000","far_pro","4000","far_mod","5000","technical","6000","users");

#LOG_DIR=/var/log
ROOT_UID=0     # Только пользователь с $UID 0 имеет привилегии root.
#LINES=50       # Количество сохраняемых строк по-умолчанию.
#E_XCD=66       # Невозможно сменить каталог?
#E_NOTROOT=67   # Признак отсутствия root-привилегий.
sign="RSA"
bits="4096"
#useradd	groupadd (iu/ig)	umod gmod (mu/mg) sguid suid stick sbit

# cmd -a utest -b gtest -c 1 -d 2 -i 3 -f 3 -g ptest -o "comm" -k "j"
cmd_usermod=("uadd" "gadd" "iu" "ig" "umod" "gmod" "mu" "mg" "sg" "su" "sb" "hd" "pwd" "cmt" "r");
userparam=();
cmd_mode=("XXX");
#
#			1.1.1	Check root privilege
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
#			1.2.1	cmd_adduser && cmd_addgroup
#
#while getopts ":i:n:m:e:" arg; do
#case $arg in
#i) ID=$OPTARG;;
echo -e "arg $USER_ADD $GROUP_ADD $UROUP_ID $GROUP_ID $SUID $SGID $HOME_PATH $PWD_USER $COMMENT_USER\n";
while [ -n "$1" ]
do

case $1 in
-ua ) shift
userparam[0]=$1 ;;
#USER_ADD=$1 ;;
-ga ) shift
userparam[1]=$1 ;;
#GROUP_ADD=$1 ;;
-iu ) shift 
userparam[2]=$1 ;;
#UROUP_ID=$1 ;;
-ig ) shift 
userparam[3]=$1 ;;
#GROUP_ID=$1 ;;
-su ) shift
userparam[4]=$1 ;;
#SUID=$1 ;;
-sg ) shift 
userparam[5]=$1 ;;
#SGID=$1 ;;
-hd ) shift 
userparam[6]=$1 ;;
#HOME_PATH=$1 ;;
#	passwd
-pw ) shift 
userparam[7]=$1 ;;
#PWD_USER=$1 ;;
#	Root CHROOT_DIR
-r ) shift 
userparam[8]=$1 ;;
#SYSTEM_USER=$1 ;;
#	Comment
-cmt ) shift 
userparam[9]=$1 ;;
#	add GROUP1, GROUPN
-G ) shift 
userparam[10]=$1 ;;
#	create-home m/M
-m ) shift 
userparam[11]=$1 ;;
#	groupmod
-chgr ) shift 
userparam[12]=$1 ;;
#	usermod
-chu ) shift 
userparam[13]=$1 ;;
#	chsh
-chsh ) shift 
userparam[14]=$1 ;;
#COMMENT_USER=$1 ;;
--parameter|p ) shift 
USER_PARAM=$1 ;;
-h|help ) break;; # выведите сообщение с подсказкой
* ) ;;# другие параметры
esac
shift
done
#echo -e "arg $1 $2 $3 $4 $5 $6 $7 $8 $9\n";
echo -e "arg ${userparam[@]}\n";

# UserAdd name
USER_ADD=$(echo ${userparam[0]} | sed -e "s/\(^[A-Za-z]*[_]\?[A-Za-z]*\).*/\1/");
# GroupAdd name
GROUP_ADD=$(echo ${userparam[1]} | sed -e "s/\(^[A-Za-z]*[_]\?[A-Za-z]*\).*/\1/");
# uid 
$userparam[2]=$(echo ${userparam[2]} | sed -e "s/\(^[0-9]*\?[0-9]*\).*/\1/");
# gid 
$userparam[3]=$(echo ${userparam[3]} | sed -e "s/\(^[0-9]*\?[0-9]*\).*/\1/");

#	INFO!!!! Proverka guid,uid!!!

#	echo "0423g"| sed -e "s/\(^[0-9]*\?[0-9]*\).*/\1/"

# UID
# TEMP=$userparam[2];
# getent passwd $(grep -oP '^Uid:\s*\K\d+' /proc/$$/status) | cut -d: -f3
# (I only use test for onelines like "test -f file || errorfunction")

if [[ ${userparam[2]} -gt $RANGE_MAX || ${userparam[2]} -lt $RANGE_MIN ]]; then
	echo "ERROR! uid grather or less than set";
fi

cat /etc/passwd | while read line
do
   if test [$(echo $line | cut -d: -f3) -ge $RANGE_MAX]
   then
      TEMP=$(echo $line | cut -d: -f3)
   fi
   # Next line only for debugging
   # echo $TEMP
done

TEMP="";

cat /etc/group | while read line
do
   if test [$(echo $line | cut -d: -f1) -eq ${userparam[1]} ]
   then
      TEMP=$(echo $line | cut -d: -f1)
   fi
   # Next line only for debugging
   # echo $TEMP
done


if [[ -z "$USER_ADD" && -z "$GROUP_ADD" ]]; then
	exit 1;
fi 

if [[ -n "$USER_ADD" && -n "$GROUP_ADD" ]]; then
	sudo useradd -d ${userparam[6]} -s ${userparam[14]} -g $GROUP_ADD -c ${userparam[9]} "-${userparam[11]}" -p "-${userparam[7]}" $USER_ADD 
fi 

if [[ -n "$USER_ADD" || -z "$GROUP_ADD" ]]; then
	sudo groupadd -g ${userparam[3]} $GROUP_ADD
fi 


#if [ "$GID" -ne "$ROOT_GID" ]
#then
#  echo "Для работы сценария требуются права root."
#  exit $E_NOTROOT
#fi

#echo $GROUPS
# if [ -z $1 ]; then 
#str = $groups | awk "{print $1}";
#
#			1.2.2	create ssh_keygen ??? key create or not???
#echo $str;
# -f auth_$USER$GROUPS 
if [[ $1 == ${cmd_mode[0]} ]];
then
if [[ -z ${userparam[7]} ]];
then
	exit 1;
fi
	cd /home/$USER/
	if [ $? -ne 0 ]; then
		exit 1;
	fi 
	sudo rm -Rf auth*
	sudo ssh-keygen -t $sign -b $bits -f /home/$USER/auth_$USER$GROUPS -p ${userparam[7]} -C "$USER $GROUPS"
	sudo touch authorized_keys
	sudo cat auth_$USER$GROUPS.pub >> authorized_keys
	sudo chown $USER:$GROUPS -Rf auth*
	sudo chmod 600 auth_$USER$GROUPS
	sudo chmod 700 auth_$USER$GROUPS.pub authorized_keys
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



# echo you have entered the text $TEXT
exit 0
