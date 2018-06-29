#!/bin/bash

sudo apt-get update
sudo apt-get install -y software-properties-common build-essential cpanminus dh-dist-zilla exuberant-ctags git tmux python-dev python3-dev ruby-dev libperl-dev lua5.1 liblua5.1-dev dirmngr postgresql-client-9.6

curl -o ~/.git-prompt.sh https://raw.githubusercontent.com/git//git/master/contrib/completion/git-prompt.sh
cp .bash_profile ~/.bash_profile
source ~/.bash_profile

git config --global user.name regcostajr
git config --global user.email regcostajr@gmail.com
git config --global color.ui true
git config --global color.status true
git config --global color.diff true
git config --global core.pager "less -r"
