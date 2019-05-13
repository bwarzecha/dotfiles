#!/bin/bash
set -E

directory=$1

git_args="--git-dir=$1.git --work-tree=$1"

git $git_args pull -r || exit 1
git $git_args push || exit 1


