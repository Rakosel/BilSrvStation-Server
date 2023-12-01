#!/bin/bash
#trap "echo Goodbye..." EXIT

sudo groupadd -g admin
err="$?"
echo -e "$err"


a=(1 2 3 4)
echo "${!a}"
echo $1 'id'
printf 'ab\n'

if [ "i" = "$1" ] ; then 
     echo "I love you madly, $someuser"
fi

count=1
while [ $count -le 5 ]
do
#echo "Loop #$count"
sleep 10
count=$(( $count + 1 ))
done

