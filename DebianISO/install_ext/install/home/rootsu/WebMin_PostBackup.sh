#!/bin/bash 
#-xv
#set -x
# Pre backup
# cd /mnt/sdd1/Backup/Debian_PC_BACKUP/;touch $PWD/Debian10_BilSrv.tar.gz;chmod 660 $PWD/Debian10_BilSrv.tar.gz;
filename='fdir.txt'
declare -A arr=()
#declare -A arr1i=()
#declare -A arr2i=()
#declare -A arr3i=()
#arr=()
#https://stackoverflow.com/questions/16487258/how-to-declare-2d-array-in-bash

#if time use
# https://stackoverflow.com/questions/11144408/convert-string-to-date-in-bash?answertab=modifieddesc#tab-top

cd /mnt/sdd1/Backup/Debian_PC_BACKUP/
#DD=$(date "+%d_%M_%Y_%H_%m")
date_now=$(date "+%Y%m%d")
backvar=1;
# write all files backup to list file
ls -rat --ignore='.' --ignore='..' > fdir.txt
cnt=0;j=0;i=0;
n=0;var="";data_cnt=0;tmpstr="";
# read all list files and relocale basename on header files
sed -i '$d' fdir.txt
#n=$(sed -n '$=' fdir.txt)
n=$(grep -c ".*" fdir.txt)
echo "start"
while IFS= read -r line;
do
#echo $line
# search backver?  arr[0,i]
	var=$(echo $line | sed -n -e "s/.*VER_\([0-9]*\).*/\1/p")
		if [[ "" -ne $var ]]; then
			arr[0,$cnt]=$var
			#echo ${arr0i[cnt]}
		fi
# search date? arr[1,i]
	var=$(echo $line | sed -n -e "s/^[A-Za-z_]*\([0-9]*\)_VER_.*/\1/p")
		if [[ "" -ne $var  ]]; then
			arr[1,$cnt]=$var
			#echo ${arr1i[cnt]}
		fi
# count find files
		if [[ "" -ne ${arr[0,$cnt]} && "" -ne ${arr[1,$cnt]}  ]];  then
# full name file
			arr[2,$cnt]=$line
			arr[3,$cnt]=$(date -d ${arr[1,$cnt]} +'%Y')
			let "cnt++";
		fi
let i+=1;
done < $filename

#echo "rezx $cnt"

#while [[ $i<$cnt ]]
#do
#	echo "massivbe: $i ${arr[0,$i]} ${arr[1,$i]} ${arr[2,$i]} ${arr[3,$i]}"
#let i+=1;
#done

# if 1 mounth backup, then math date/1 backup
# then 12 mount - 12 backup, 1 and 12 not deleted
# but (6) mouth deleted 6 backup
# year is end, then 6+6=12 backup, deleted -> 6 backup
# when 1 year = 6 backup && 1 and 6 back not deleted!!!
# backup number is great 12 mouth - 12 number backup
i=1;
#echo $cnt
# search 'max' element for backvar
# if 'max' > 12, but backvar = 1
if [[ $cnt>0 ]]; then
	max=${arr[0,0]};
	min=${arr[0,0]};
fi
while [[ $cnt>$i ]]
do
	if [[ ${arr[0,$i]} > $max ]]; then
		max=${arr[0,$i]};
	else
		min=${arr[0,$i]};
	fi
	let i+=1;
done
#let max+=1;
# join too uslovie!!!
if [[ $max -gt 12 ]]; then
	backver="1";
else
    let max=$max+1;
	backver=$max;
fi

# cut count webmin
if [[ $cnt -gt 12 ]]; then
i=2;
while [[ $i<($cnt-1) ]] 
do
	rm -Rf ${arr[3,$i]}
done
fi
# search 'year' and count 'date_cnt'
#
i=0;j=0

#for i in ${arr[@]}
#do
#echo $i
#echo "${arr[0,i]} ${arr[1,i]} ${arr[2,i]} ${arr[3,i]} ${arr[4,i]} $data_cnt $min $max"
#done
# Rezult: data_cnt - count fileds for data arr[4,j]
#	  arr[4,j] - count backups files/year

#echo "data_cnt"
#
#echo "bv: $backver"
# via goto
# part 3 build

var="WebBack_ $HOSTNAME _ $date_now _VER_ $backver";
var=${var//[[:space:]]/};
if [ ! -f "Debian10_BilSrv.tar.gz" ]; then
	touch Debian10_BilSrv.tar.gz
	chmod ugo+rwx Debian10_BilSrv.tar.gz
fi
#echo $var
mv /mnt/sdd1/Backup/Debian_PC_BACKUP/Debian10_BilSrv.tar.gz /mnt/sdd1/Backup/Debian_PC_BACKUP/$var.tar.gz;
chown admin:admins /mnt/sdd1/Backup/Debian_PC_BACKUP/$var.tar.gz
setfacl -m u:admin_share:rwx,u:admin:rwx,u:pub_share:rwx -R $PWD;
#find $PWD -name "WebBack_*"  | sed "s/.*\///"

exit;
