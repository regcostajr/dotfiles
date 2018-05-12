sudo apt-get update

sudo apt-get install -y software-properties-common build-essential git tmux python-dev python3-dev ruby-dev libperl-dev dirmngr libpam-google-authenticator

curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
curl -sL https://dl.google.com/go/go1.10.linux-amd64.tar.gz | sudo tar -C /usr/local -xzv
wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" -qO- http://download.oracle.com/otn-pub/java/jdk/10.0.1+10/fb4372174a714e6b8c52526dc134031e/jdk-10.0.1_linux-x64_bin.tar.gz | sudo tar -C /opt/ -xzv

sudo apt-get update

sudo apt-get install -y nodejs golang-glide cpanminus dh-dist-zilla exuberant-ctags

echo 'export JAVA_HOME=/opt/jdk-10.0.1/' | sudo tee /etc/profile.d/java.sh
echo 'export PATH=$PATH:/opt/jdk-10.0.1/bin' | sudo tee -a /etc/profile.d/java.sh

echo 'export GOROOT=/usr/local/go' | sudo tee -a /etc/profile.d/go.sh
echo 'export PATH=$PATH:$GOROOT/bin' | sudo tee -a /etc/profile.d/go.sh
echo 'export GOPATH=$HOME/environment/go' | sudo tee -a /etc/profile.d/go.sh

# NPM global modules
sudo npm i -g npm
sudo npm i -g ganache-cli
sudo npm i -g truffle
sudo npm i -g solc

source /etc/profile.d/java.sh
source /etc/profile.d/go.sh

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

exit
