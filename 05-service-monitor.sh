#!/bin/bash
USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo -e "ERROR:: You must have sudo access to execute this script"
    exit 1 # other than 0
else 
    echo -e "Script name: $0 is executing....."
fi

mkdir -p "/var/log/service_logs"

LOG_FOLDER="/var/log/service_logs"
LOG_FILE=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOG_FOLDER/$LOG_FILE-$TIMESTAMP.log"

SVCNAME=("nginx" "mysqld")

for service in "${SVCNAME[@]}" 
do
    echo $service
done