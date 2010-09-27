#!/bin/bash

source config.sh

REPO_DIR=$GRIT_REPO_DIR/$1.git
WWW_DIR=$GIT_WWW_DIR/$1

if [ -z $REPO_DIR ]; then
    echo "Please specify a repository."
    exit 1
fi

if [ ! -d $REPO_DIR ]; then
    echo "Repository does not exist."
    exit 1
fi


echo -n "Are you sure you want to remove this directory? "
read SURE
if [ "$SURE" != "y" ]; then
    exit 1
fi

rm -rf $REPO_DIR

echo "Repo Removed."

rm -rf $WWW_DIR

echo "Document Root Removed."

rm $GRIT_VHOST_DIR/$1.conf

echo "VHost Removed."

sudo /etc/init.d/httpd reload

exit
