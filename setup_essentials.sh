#!/bin/bash

sudo apt-get update
sudo apt-get install -y \
    software-properties-common \
    build-essential \
    libperl-dev \
    cpanminus \
    dh-dist-zilla \
    libtest-perl-critic-perl \
    exuberant-ctags \
    git \
    python-dev \
    python3-dev \
    ruby-dev \
    lua5.1 \
    liblua5.1-dev \
    dirmngr \
    postgresql-client-9.6 \
    nginx \
    jq \
    cmake

curl -o ~/.git-prompt.sh https://raw.githubusercontent.com/git//git/master/contrib/completion/git-prompt.sh
cp .bash_profile ~/.bash_profile

git config --global user.name regcostajr
git config --global user.email regcostajr@gmail.com
git config --global color.ui true
git config --global color.status true
git config --global color.diff true
git config --global core.pager "less -r"
