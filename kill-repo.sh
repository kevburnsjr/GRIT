#!/bin/bash

REPO=$GRIT_REPO_DIR/$1.git
DOC_ROOT=$GIT_WWW_DIR/$1

if [ -z $REPO ]; then
    echo "Please specify a repository."
    exit 1
fi

if [ ! -d $REPO ]; then
    echo "Repository does not exist."
    exit 1
fi


echo -n "Are you sure you want to remove this directory? "
read SURE
if [ "$SURE" != "y" ]; then
    exit 1
fi

rm -rf $REPO

echo "Repo Removed."

rm -rf $DOC_ROOT

echo "Document Root Removed."

rm $GRIT_VHOST_DIR/$1.conf

echo "VHost Removed."

sudo /etc/init.d/httpd reload

exit
