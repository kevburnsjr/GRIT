#!/bin/bash

source `dirname $0`/config.sh

REPO_DIR=$GRIT_REPO_DIR/$1.git
WWW_DIR=$GRIT_WWW_DIR/$1
DOC_ROOT=$WWW_DIR/dev

if [ -z $1 ]; then
    echo "Please specify a repository."
    exit 1
fi
if [ -d $REPO_DIR ]; then
    echo "Repository already exists."
    exit 1
fi

function process_tpl {
    cp $1 $2
    sed "s@DOC_ROOT@$DOC_ROOT@" $2 -i
    sed "s@WWW_DIR@$WWW_DIR@"   $2 -i
    sed "s@REPO_NAME@$1@"       $2 -i
    sed "s@HOST@$GRIT_HOST@"    $2 -i
    chmod 775 $2
}

# ==============================================================================
# Create Repository
# ==============================================================================
# - /var/git/REPONAME.git

mkdir $REPO_DIR
cd $REPO_DIR
git --bare init

# ==============================================================================
# Create Document Root
# ==============================================================================
# - /var/www/REPONAME

mkdir $WWW_DIR
mkdir $WWW_DIR/logs
mkdir $WWW_DIR/dev

cd $WWW_DIR/dev
git init
git remote add origin $REPO_DIR

# ==============================================================================
# Create Hooks
# ==============================================================================

process_tpl $GRIT_SCRIPT_DIR/tpl/post-receive  $REPO_DIR/hooks/post-receive
process_tpl $GRIT_SCRIPT_DIR/tpl/pull.sh       $WWW_DIR/pull.sh

# ==============================================================================
# Create VHost
# ==============================================================================
# - /var/www/vhosts/REPONAME.conf

process_tpl $GRIT_SCRIPT_DIR/tpl/vhost.conf    $GRIT_VHOST_DIR/$1.conf

sudo /etc/init.d/httpd reload

# ==============================================================================
# Complete
# ==============================================================================
# - ssh://user@host.tld/var/git/REPONAME.git
# - http://REPONAME.host.tld

echo "Repo Created!"
echo "- ssh://$GRIT_USER@$GRIT_HOST:$GRIT_PORT$REPO_DIR"
echo "- http://$1.$GRIT_HOST"
echo "TIME TO GET SHIT DONE!"

exit
