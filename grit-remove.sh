#!/bin/bash

source `dirname $0`/config.sh

REPO_DIR=$GRIT_REPO_DIR/$1.git
WWW_DIR=$GRIT_WWW_DIR/$1

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

# ==============================================================================
# Remove Repository
# ==============================================================================
# - /var/git/REPONAME.git

rm -rf $REPO_DIR

# ==============================================================================
# Remove Document Root
# ==============================================================================
# - /var/www/REPONAME

rm -rf $WWW_DIR

# ==============================================================================
# Remove VHost
# ==============================================================================
# - /var/www/vhosts/REPONAME.conf

rm $GRIT_VHOST_DIR/$1.conf

sudo /etc/init.d/httpd reload

# ==============================================================================
# Complete
# ==============================================================================

echo "Repo Removed."

exit
