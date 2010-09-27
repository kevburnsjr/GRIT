#!/bin/bash

GIT_DIR=~/$1.git
DOC_ROOT=/var/www/$1
VHOST_DIR=/var/www/vhosts

if [ -z $GIT_DIR ]; then
    echo "Please specify a repository."
    exit 1
fi

if [ ! -d $GIT_DIR ]; then
    echo "Repository does not exist."
    exit 1
fi


echo -n "Are you sure you want to remove this directory? "
read SURE
if [ "$SURE" != "y" ]; then
    exit 1
fi

rm -rf $GIT_DIR

echo "Repo Removed."

rm -rf $DOC_ROOT

echo "Document Root Removed."

rm $VHOST_DIR/$1.conf

echo "VHost Removed."

sudo /etc/init.d/httpd reload

exit
