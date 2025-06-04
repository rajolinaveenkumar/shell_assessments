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
    USE=$(echo $line | awk -F " " '{print $6f}' | cut -d "%" -f1)
    PARTITION=$(echo $line | awk -F " " '{print $7f}')
    echo -e "Disk Partition is: $G $PARTITION $N and Usage is : $G $USE $N"
    

done <<< $DISK_USAGE