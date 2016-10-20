#!/bin/bash

##################################################
# Write here the name of the disk you want to test

DISK="ramdisk"

##################################################


##################################################
# Algorithm

NAMEFILE="/Volumes/$DISK/tstfile"
clear
echo "---------------------"
echo "Running test on: $DISK"
echo "Write Test Running. Please Wait..."
write=$(dd if=/dev/zero bs=1024k of="${NAMEFILE}" count=1024 2>&1 | grep sec | awk '{print $1 / 1024 / 1024 / $5, "MB/sec" }')
#purge
echo ""
echo "Read Test Running. Please Wait..."
read=$(dd if="${NAMEFILE}" bs=1024k of=/dev/null count=1024 2>&1 | grep sec | awk '{print $1 / 1024 / 1024 / $5, "MB/sec" }')
echo ""
echo "Read Speed is: $read"
echo "Write Speed is: $write"
echo "---------------------"
#purge
rm "${NAMEFILE}"
echo ""
exit 0

##################################################
