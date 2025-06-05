#!/bin/bash
USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo -e "ERROR:: $UL You must have sudo access to execute this script $N"
    exit 1 # other than 0
else 
    echo -e "$G Script name: $0 is executing..... $N"
fi

SERVICE=$(systemctl status nginx | grep inactive)

if [ $? -eq 0 ]
then    
    echo "nginx service is inactive"
    systemctl start nginx
else
    echo "nginx service is active"
    exit 1
fi