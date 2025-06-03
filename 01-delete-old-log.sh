#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
UL="\e[4m"

mkdir -p "/var/log/shell_logs"

LOG_FOLDER="/var/log/shell_logs"
LOG_FILE=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOG_FOLDER/$LOG_FILE-$TIMESTAMP.log"

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$R  $2 is ............FAILURE $N"
        exit 1
    else
        echo -e "$G $2 is ............SUCCESS $N"
    fi
}


CHECK_USER(){
    if [ $USERID -ne 0 ]
    then
        echo -e "ERROR:: $UL You must have sudo access to execute this script $N"
        exit 1 # other than 0
    else 
        echo -e "$G Script name: $0 is executing..... $N"
    fi
}

CHECK_USER
echo "$0 Script started executing at: $TIMESTAMP" &>>$LOG_FILE_NAME

FOLDER="/home/ec2-user/log"
FILES_TO_DELETE=$(find . -name "*.log" -mtime +14)
echo "Delete files are : $FILES_TO_DELETE"
