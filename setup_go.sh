#!/bin/bash

curl -sL https://dl.google.com/go/go1.10.linux-amd64.tar.gz | sudo tar -C /usr/local -xzv

echo 'export GOROOT=/usr/local/go' | sudo tee -a /etc/profile.d/go.sh
echo 'export PATH=$PATH:$GOROOT/bin' | sudo tee -a /etc/profile.d/go.sh
echo 'export GOPATH=$HOME/environment/go' | sudo tee -a /etc/profile.d/go.sh

