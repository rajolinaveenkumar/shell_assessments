#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
UL="\e[4m"

LOG_SOURCE_DIR="/var/log/shell_logs"
LOG_FILE=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOG_SOURCE_DIR/$LOG_FILE-$TIMESTAMP.log"


if [ $USERID -ne 0 ]
then
    echo -e "ERROR:: $UL You must have sudo access to execute this script $N"
    exit 1 # other than 0
else 
    echo -e "$G Script name: $0 is executing..... at $TIMESTAMP $N"
fi

USEAGE(){
    echo -e "${R} USEAGE: $N sh script_name <SOURCE_DIR> <DEST_DIR> <DAYS(Optional)>"
    exit 1
}

mkdir -p "/var/log/shell_logs" # This is only to redirect the logs or track the history

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}

if [ $# -lt 2 ]
then
    USEAGE
fi

if [ ! -d $SOURCE_DIR ]
then
    echo "SOURCE_DIR not found"
    exit 1
else
    echo "SOURCE_DIR found"
fi

if [ ! -d $DEST_DIR ]
then
    echo "DEST_DIR  not found"
    exit 1
else
    echo "DEST_DIR found"
fi

FILES=$(find /var/log/old/source/ -mtime +14 -name "*.log")


if [ -n "$FILES" ]
then 
    echo "Files to zip are:$FILES"
else
    echo "no files to zip"
    exit 1
fi

ZIPFILES="$DEST_DIR/backup-logs-$LOG_FILE-$TIMESTAMP.zip"
$FILES | zip -@ "$ZIPFILES"


