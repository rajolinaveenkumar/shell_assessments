#!/bin/bash

SERVICE=$(systemctl status nginx | grep inactive)

if [ $? -eq 0 ]
then    
    echo "nginx service is inactive"
    systemctl start nginx
else
    echo "nginx service is active"
    exit 1
fi