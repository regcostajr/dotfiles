#!/bin/bash

if cat /etc/*-release | grep "VERSION=" | grep 9
then 
    curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
    sudo apt-get install -y nodejs
else
    sudo apt-get install -y nodejs
    sudo npm cache clean -f 
    sudo npm install -g n
    sudo n 8.11.3
    sudo ln -sf /usr/local/n/versions/node/8.11.3/bin/node /usr/bin/node
fi

# NPM global modules
sudo npm i -g npm
sudo npm i -g ganache-cli
sudo npm i -g truffle
sudo npm i -g solc

