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

# =========== Create Repository ===========

mkdir $REPO_DIR
cd $REPO_DIR
git --bare init

echo "Repo Created."

# =========== Create Hooks ===========

cp $GRIT_SCRIPT_DIR/tpl/post-receive $REPO_DIR/hooks/post-receive
sed -i "s@DOC_ROOT@$DOC_ROOT@" $REPO_DIR/hooks/post-receive
chmod 755 $REPO_DIR/hooks/post-receive

echo "Repo Hooks Created."

# =========== Create Document Root ===========

mkdir $WWW_DIR

cp $GRIT_SCRIPT_DIR/tpl/pull.sh $WWW_DIR/pull.sh
sed "s@DOC_ROOT@$DOC_ROOT@" $WWW_DIR/pull.sh -i

mkdir $WWW_DIR/logs
mkdir $WWW_DIR/dev
cd $WWW_DIR/dev
git init
git remote add origin $REPO_DIR

echo "Document Root Created."

# =========== Create VHost ===========

cp $GRIT_SCRIPT_DIR/tpl/vhost.conf $GRIT_VHOST_DIR/$1.conf
sed "s@REPO_NAME@$1@"       $GRIT_VHOST_DIR/$1.conf -i
sed "s@DOC_ROOT@$DOC_ROOT@" $GRIT_VHOST_DIR/$1.conf -i
sed "s@WWW_DIR@$WWW_DIR@"   $GRIT_VHOST_DIR/$1.conf -i
sed "s@HOST@$GRIT_HOST@"    $GRIT_VHOST_DIR/$1.conf -i


sudo /etc/init.d/httpd reload

echo "- --- -"
echo "ssh://$GRIT_USER@$GRIT_HOST:$GRIT_PORT$REPO_DIR"

exit
