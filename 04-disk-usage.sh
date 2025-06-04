#!/bin/bash

DISK_USAGE=$(df -Th | grep xfs)
DISK_THRESHOLD=5 
MSG=""

while read -r line
do
    echo "Disk usage on $line"

done <<< $DISK_USAGE