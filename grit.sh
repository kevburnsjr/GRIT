#!/bin/bash

if [ $1 = "create" ]; then
    source grit-create.sh $2
    exit 1
fi
if [ $1 = "remove" ]; then
    source grit-remove.sh $2
    exit 1
fi

echo "Usage: grit (create|remove) [REPO_NAME]"
exit 1
