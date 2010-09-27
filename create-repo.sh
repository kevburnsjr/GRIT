#!/bin/bash

GIT_DIR=$GRIT_REPO_DIR/$1.git
DOC_ROOT=$GRIT_WWW_DIR/$1

if [ -z $1 ]; then
    echo "Please specify a repository."
    exit 1
fi
if [ -d $GRIT_REPO_DIR/$1.git ]; then
    echo "Repository already exists."
    exit 1
fi

mkdir $GIT_DIR
cd $GIT_DIR
git --bare init

echo "Repo Created."

rm hooks/post-receive
cp $GRIT_SCRIPT_DIR/post-receive.tpl hooks/post-receive
sed "s/REPO_NAME/$1/" hooks/post-receive -i
chmod 755 hooks/post-receive

echo "Repo Hooks Created."

cp -R $GRIT_SCRIPT_DIR/pull.sh $DOC_ROOT
sed "s/REPO_NAME/$1/" $DOC_ROOT/pull.sh -i
mkdir $DOC_ROOT/dev
cd $DOC_ROOT/dev
git init
git remote add origin $GRIT_REPO_DIR/$1.git

echo "Document Root Created."

VHOST_DIR=GRIT_VHOST_DIR
cp $VHOST_DIR/vhost.tpl $VHOST_DIR/$1.conf
sed "s/REPO_NAME/$1/" $VHOST_DIR/$1.conf -i

sudo /etc/init.d/httpd reload

echo "- --- -"
echo "ssh://kev@defiance:30010/var/git/$1.git"

exit
