#!/bin/bash

source config.sh

REPO_DIR=$GRIT_REPO_DIR/$1.git
WWW_DIR=$GRIT_WWW_DIR/$1

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

rm hooks/post-receive
cp $GRIT_SCRIPT_DIR/tpl/post-receive hooks/post-receive
sed "s/DOC_ROOT/$WWW_DIR\/dev/" hooks/post-receive -i
chmod 755 hooks/post-receive

echo "Repo Hooks Created."

# =========== Create Document Root ===========

cp $GRIT_SCRIPT_DIR/pull.sh $WWW_DIR
sed "s/DOC_ROOT/$WWW_DIR\/dev/" $WWW_DIR/pull.sh -i

mkdir $WWW_DIR/dev
cd $WWW_DIR/dev
git init
git remote add origin $REPO

echo "Document Root Created."

# =========== Create VHost ===========

cp $GRIT_SCRIPT_DIR/tpl/vhost.conf $GRIT_VHOST_DIR/$1.conf
sed "s/REPO_NAME/$1/" $GRIT_VHOST_DIR/$1.conf -i
sed "s/DOC_ROOT/$WWW_DIR\/dev/" $GRIT_VHOST_DIR/$1.conf -i
sed "s/HOST/$GRIT_HOST/" $GRIT_VHOST_DIR/$1.conf -i

sudo /etc/init.d/httpd reload

echo "- --- -"
echo "ssh://$GRIT_USER@$GRIT_HOST:$GRIT_PORT$REPO"

exit
