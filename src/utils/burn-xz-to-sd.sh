#!/bin/bash
set -euf -o pipefail

TARGET='/dev/mmcblk0'

if [[ $# -eq 0 ]] ; then
    echo 'Usage: sudo ./'$(basename $0)' my_custom_image.img.xz'
    exit 0
fi

read -p "Are you sure you want to overrite data on $TARGET with contents of $1?" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo
    xz --stdout --decompress $1 | pv -rep -s $(xz --robot --list $1 | awk 'FNR == 2 {print $5}') | dd bs=2M of=$TARGET
fi
