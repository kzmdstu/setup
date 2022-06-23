#!/bin/bash
set -e

if [ -z "$1" ]
then
	echo "usage: $0 [DEST] [USER]"
	exit 1
fi

if [ -z "$2" ]
then
	echo "usage: $0 [DEST] [USER]"
	exit 1
fi

FROM=$1
USER=$2

echo "getting $USER setting from $DEST"

rsync -avh $FROM:/home/$USER/.config /home/$USER/
rsync -avh $FROM:/home/$USER/.mozilla /home/$USER/
rsync -avh --ignore-missing-args $FROM:/home/$USER/maya /home/$USER/

echo "done"
