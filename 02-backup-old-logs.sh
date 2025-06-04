#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
UL="\e[4m"

SOURCE_DIR=$1
DESTINATION_DIR=$2
DAYS=${3:-14} # if user is not providing number of days, we are taking 14 as default

LOGS_FOLDER="/home/ec2-user/shellscript-logs"
LOG_FILE=$(echo $0 | awk -F "." '{print $1}')
# LOG_FILE=$(echo $0 |awk -F "/" '{print $NF}' | cut -d "." -f1)
TIMESTAMP=$(date +%d-%m-%Y-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

# Note:
# 1. awk is a powerful text-processing tool used to process and manipulate data in a stream (or file). It processes input line by line.
# 2. The -F option in awk sets the field separator to /, which means awk will split the input string at every / character.
#     For example, given the string /home/user/file.txt, awk will split it into these parts:
#       /home
#        user
#        file.txt
# 3. {print $NF} tells awk to print the last field from the split string.
# 4. $NF is a special variable in awk that holds the value of the last field (regardless of how many fields are in the input)

if [ $# -lt 2 ] # The expression "Evaluates whether the number of arguments ($#) is less than 2"
then 
    echo -e "$R USEAGE: $N sh script_name <SOURCE_DIR> <DEST_DIR> <DAYS(Optional)>"
    exit 1
fi

mkdir -p /home/ec2-user/shellscript-logs

if [ ! -d $SOURCE_DIR ] # !=-ve, -d=checking the directory($SOURCE_DIR), 
then
    echo "source directory not exist"
    exit 1
else 
    echo "source directory exist"
fi

  #NOTE:- 
  # !=(-ve ) If the condition inside the brackets ([ ]) is true, the ! makes it false, and vice versa.
  # -d $SOURCE_DIR returns true if the path stored in $SOURCE_DIR exists and is a directory.
  # If $SOURCE_DIR does not exist or is not a directory (e.g., a file or symbolic link), it returns false.

if [ ! -d $DESTINATION_DIR ]
then
    echo "destinantion directory not exist"
    exit 1 
else
    echo "destination directory exist"
fi

echo "Script started executing at: $TIMESTAMP"


FILES=$(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)
#NOTE: -type f =Ensures only regular files are included in the results(ignores directories, symbolic links, etc.).

if [ -n "$FILES" ] # true if there are files to zip
then 
    echo "Files to zip are:$FILES"
    ZIP_FILES="$DESTINATION_DIR/backuplogs-$TIMESTAMP.zip"
    find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS | zip -@ "$ZIP_FILES"
else
    echo "no files found older than $DAYS days to delete"
    exit 1
fi

ZIP_FILES="$DESTINATION_DIR/backuplogs-$TIMESTAMP.zip"
find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS | zip -@ "$ZIP_FILES"

if [ -f "$ZIP_FILES" ] #The -f operator checks if the specified path is a regular file (not a directory, symlink, or other types of file)
then 
    echo "Successfully created zip file for files older than $DAYS"
else 
    echo "zipping error"
    exit 1
fi

while read -r filepath # here filepath is the variable name, you can give any name
do
    echo "Deleting file: $filepath" &>>$LOG_FILE_NAME
    rm -rf $filepath
    echo "Deleted file: $filepath"
done <<< $FILES