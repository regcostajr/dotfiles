#!/bin/bash

export ETHEREUM_VERSION=1.8.11-dea1ce05
export ETHEREUM_URL="https://gethstore.blob.core.windows.net/builds/geth-linux-amd64-$ETHEREUM_VERSION.tar.gz"

export BITCOIN_VERSION=0.16.1
export BITCOIN_URL="https://bitcoin.org/bin/bitcoin-core-$BITCOIN_VERSION/bitcoin-$BITCOIN_VERSION-x86_64-linux-gnu.tar.gz"

sudo mkdir /opt/bitcoin && wget -qO- $BITCOIN_URL | sudo tar xvz -C /opt/bitcoin --strip-components 1
sudo mkdir /opt/ethereum && wget -qO- $ETHEREUM_URL | sudo tar xvz -C /opt/ethereum --strip-components 1

echo 'export PATH=$PATH:/opt/bitcoin/bin' | sudo tee -a /etc/profile.d/bitcoin.sh 
echo 'export PATH=$PATH:/opt/ethereum' | sudo tee -a /etc/profile.d/ethereum.sh 

source /etc/profile.d/bitcoin.sh
source /etc/profile.d/ethereum.sh
