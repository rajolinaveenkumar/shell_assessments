#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
UL="\e[4m"

DISK_USAGE=$(df -Th | grep xfs)
DISK_THRESHOLD=5 
MSG=""

while read -r line
do
    # echo "Disk usage on $line"
    USAGE=$(echo $line | awk -F " " '{print $6f}' | cut -d "%" -f1)
    PARTITION=$(echo $line | awk -F " " '{print $7f}')
    # echo -e "Disk Partition is: $G $PARTITION $N and Usage is : $G $USAGE $N"
    if [ $USAGE -gt $DISK_THRESHOLD ]
    then 
        MSG+="High Disk usage on partition: ${R} $PARTITION ${N} Usage is: ${R}$USAGE ${N} \n"
    fi

done <<< $DISK_USAGE

Hello=$(echo -e "Message: $MSG" \n)

echo "$Hello" | mutt -s "High Disk Usage" naveenrajoli04@gmail.com

echo $Hello