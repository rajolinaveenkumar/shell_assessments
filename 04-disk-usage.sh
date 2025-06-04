#!/bin/bash

DISK_USAGE=$(df -Th | grep xfs)
DISK_THRESHOLD=5 
MSG=""

while read -r line
do
    echo "Disk usage on $line"
    USE=$(echo $line | awk -F " " '{print $6f}' | cut -d "%" -f1)
    PARTITION=$(echo $line | awk -F " " '{print $Nf}')
    echo $USE $PARTITION

done <<< $DISK_USAGE