#!/bin/bash


# Get current date in 
bakdate=$(date +"%d.%m.%Y-%H.%M.%S")

# Exeute main startup script and create log file
mkdir "./logs"
./script.sh 2>&1 | tee -a "./logs/${bakdate}.log"

# Inform user where logfile was created
echo "Created log file at: /logs/${bakdate}.log"
