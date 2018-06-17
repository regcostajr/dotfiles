#!/bin/bash

sudo apt-get install -y libpam-google-authenticator

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

