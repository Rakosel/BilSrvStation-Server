#!/bin/bash

echo "This is an error" >&2
echo "This is normal output"

while [ -n "$1" ]
do
case "$1" in
-a) echo "Found the -a option" ;;
-b) echo "Found the -b option";;
-c) echo "Found the -c option" ;;
--)shift 
break ;;
*) echo "$1 is not an option";;
esac
shift
done
count=1
for param in $@
do
echo "Parameter #$count: $param"
count=$(( $count + 1 ))
done


case "$1" in
     start)
          start;;
     stop)
          stop;;
     restart)
          restart;;
     reload)
          reload;;
     status)
          status
          ;;
     *)
          echo "Usage: $0 (start|stop|restart|reload|status)"
          ;;
esac


#while [ "$1" != "" ];
#do
#case $1 in 
#-s ) shift SERVER=$1 ;; 
#-d ) shift DATE=$1 ;; 
#--paramter|p ) shift PARAMETER=$1;; 
#-h|help);;  # выведите сообщение с подсказкой 
#* ) # другие параметры
#esac
#done
#exit 0;
#echo "arg $@ cnt $#\n"
#for i in $@ 
#do
#	echo "$i \n"; 
#done 
exit 0;
