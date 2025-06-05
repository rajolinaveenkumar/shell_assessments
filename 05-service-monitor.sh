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


while read -r line
do
    SERVICE=$(systemctl status $line) &>>$LOG_FILE_NAME
    echo $line


done <<< $SVCNAME









# if [ $? -eq 0 ]
# then    
#     echo "nginx service is inactive"
#     systemctl start nginx
# else
#     echo "nginx service is active"
#     exit 1
# fi