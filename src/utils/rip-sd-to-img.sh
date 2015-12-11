#!/bin/bash
set -euf -o pipefail

SOURCE='/dev/mmcblk0'

if [[ $# -eq 0 ]] ; then
    echo 'Usage: sudo ./'$(basename $0)' output_image.img'
    exit 0
fi

read -p "Are you sure you want to read data from $SOURCE and create $1?" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # do dangerous stuff
    echo
    SECTORSIZE=$(fdisk -l /dev/mmcblk0 | awk '/^Sector size/ { print $4}')
    ENDBLOCK=$(fdisk -l $SOURCE | awk 'END {print $3}')
    echo Sector Size = $SECTORSIZE, End Block = $ENDBLOCK
    dd bs=$SECTORSIZE count=$(($ENDBLOCK+1)) if=/dev/mmcblk0 | pv -rep -s $(($SECTORSIZE * ($ENDBLOCK + 1))) | dd of=$1
fi
