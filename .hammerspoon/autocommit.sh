#!/bin/bash

directory=$1

git_args="--git-dir=$1.git --work-tree=$1"

changed_files=$(git $git_args status --porcelain | wc -l)
timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
if [ $changed_files -gt 0 ] ;then
    git $git_args commit -am "Sync commit $timestamp"
else 
    echo "Nothing to do"
fi