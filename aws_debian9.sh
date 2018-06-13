#!/bin/bash

sudo apt-get update

sudo apt-get install -y software-properties-common build-essential

curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
curl -sL https://dl.google.com/go/go1.10.linux-amd64.tar.gz | sudo tar -C /usr/local -xzv

wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" -qO- http://download.oracle.com/otn-pub/java/jdk/8u172-b11/a58eab1ec242421181065cdc37240b08/jdk-8u172-linux-x64.tar.gz | sudo tar -C /opt/ -xzv
wget -qO- www-us.apache.org/dist/maven/maven-3/3.5.3/binaries/apache-maven-3.5.3-bin.tar.gz | sudo tar -C /opt/ -xzv

sudo apt-get update

sudo apt-get install -y nodejs golang-glide cpanminus dh-dist-zilla exuberant-ctags git tmux python-dev python3-dev ruby-dev libperl-dev lua5.1 liblua5.1-dev dirmngr libpam-google-authenticator postgresql-client-9.6

export ETHEREUM_VERSION=1.8.3-329ac18e
export ETHEREUM_URL="https://gethstore.blob.core.windows.net/builds/geth-linux-amd64-$ETHEREUM_VERSION.tar.gz"

export BITCOIN_VERSION=0.16.0
export BITCOIN_URL="https://bitcoin.org/bin/bitcoin-core-$BITCOIN_VERSION/bitcoin-$BITCOIN_VERSION-x86_64-linux-gnu.tar.gz"

sudo mkdir /opt/bitcoin && wget -qO- $BITCOIN_URL | sudo tar xvz -C /opt/bitcoin --strip-components 1
sudo mkdir /opt/ethereum && wget -qO- $ETHEREUM_URL | sudo tar xvz -C /opt/ethereum --strip-components 1

echo 'export JAVA_HOME=/opt/jdk1.8.0_172/' | sudo tee /etc/profile.d/java.sh
echo 'export PATH=$PATH:/opt/jdk1.8.0_172/bin' | sudo tee -a /etc/profile.d/java.sh
echo 'export M2_HOME=/opt/apache-maven-3.5.3/' | sudo tee -a /etc/profile.d/java.sh
echo 'export PATH=$PATH:/opt/apache-maven-3.5.3/bin'| sudo tee -a /etc/profile.d/java.sh

echo 'export GOROOT=/usr/local/go' | sudo tee -a /etc/profile.d/go.sh
echo 'export PATH=$PATH:$GOROOT/bin' | sudo tee -a /etc/profile.d/go.sh
echo 'export GOPATH=$HOME/environment/go' | sudo tee -a /etc/profile.d/go.sh

echo 'export PATH=$PATH:/opt/bitcoin/bin' | sudo tee -a /etc/profile.d/bitcoin.sh 
echo 'export PATH=$PATH:/opt/ethereum' | sudo tee -a /etc/profile.d/ethereum.sh 

# NPM global modules
sudo npm i -g npm
sudo npm i -g ganache-cli
sudo npm i -g truffle
sudo npm i -g solc

# building vim from source
sudo rm -Rf ~/vim
git clone https://github.com/vim/vim.git ~/vim
cd ~/vim
./configure --with-features=huge \
    --enable-multibyte \
    --enable-rubyinterp=yes \
    --enable-pythoninterp=yes \
    --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
    --enable-python3interp=yes \
    --with-python3-config-dir=/usr/lib/python3.5/config-x86_64-linux-gnu \
    --enable-perlinterp=yes \
    --enable-luainterp=yes \
    --enable-cscope \
    --prefix=/usr/local

sudo make install
make VIMRUNTIMEDIR=/usr/local/share/vim/vim81
sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
sudo update-alternatives --set editor /usr/local/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
sudo update-alternatives --set vi /usr/local/bin/vim

hash -r

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim && wget -O ~/.vimrc https://raw.githubusercontent.com/regcostajr/dotfiles/master/.vimrc && wget -O ~/.bash_profile https://raw.githubusercontent.com/regcostajr/dotfiles/master/.bash_profile && curl -o ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh

vim +PluginInstall +qall

sudo mkdir /var/lib/google-auth
sudo chmod 755 /var/lib/google-auth

google-authenticator

sudo mv .google_authenticator /var/lib/google-auth/admin
sudo chown root:root /var/lib/google-auth/admin
sudo chmod 400 /var/lib/google-auth/admin

sudo sed -i 's/@include common-auth/auth required pam_google_authenticator.so nullok secret=\/var\/lib\/google-auth\/${USER} user=root/g' /etc/pam.d/sshd

sudo sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config
sudo sed -i 's/PubkeyAuthentication yes/PubkeyAuthentication no/g' /etc/ssh/sshd_config
sudo echo 'AuthenticationMethods keyboard-interactive' | sudo tee -a /etc/ssh/sshd_config

sudo service sshd restart

