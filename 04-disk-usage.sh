#!/bin/bash

DISK_USAGE=$(df -Th | grep xfs)
DISK_THRESHOLD=5 
MSG=""

while read -r line
do
    # echo "Disk usage on $line"
    USE=$(echo $line | awk -F " " '{print $6f}')
    echo $USE

done <<< $DISK_USAGE