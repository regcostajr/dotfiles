#!/bin/bash

# removing old vim
sudo apt-get remove --purge vim vim-runtime gvim
sudo rm -Rf ~/vim /usr/local/share/vim /usr/bin/vim

# vim preferences
mkdir -p ~/.vim
cp -Rf .vim/snips ~/.vim/
cp -Rf .vim/templates ~/.vim/
cp .vimrc ~/.vimrc

git clone https://github.com/vim/vim.git ~/vim || (cd ~/vim; git pull)

# next steps must be inside vim dir
cd ~/vim

# get config path for python 2 and 3
PYTHONARRAY=($(ls -d -1 /usr/lib/python*/config* | grep -v "\.py" | grep "2.7\|3.2\|3.5"))

# building with python support
./configure --with-features=huge --enable-multibyte --enable-rubyinterp=yes --enable-pythoninterp=yes --with-python-config-dir=${PYTHONARRAY[0]} --enable-python3interp=yes --with-python3-config-dir=${PYTHONARRAY[1]} --enable-perlinterp=yes --enable-luainterp=yes --enable-cscope --prefix=/usr/local

sudo make install
make VIMRUNTIMEDIR=/usr/local/share/vim/vim81

sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
sudo update-alternatives --set editor /usr/local/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
sudo update-alternatives --set vi /usr/local/bin/vim
sudo ln -s /usr/local/bin/vim /usr/bin/vim

hash -r

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim || echo "Vundle already installed"

vim +PluginInstall +qall

