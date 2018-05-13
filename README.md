# dotfiles
bash, tmux, vim and other configuration files

---

#### Importing configuration

##### Debian 9

```
wget https://raw.githubusercontent.com/regcostajr/dotfiles/master/aws_debian9.sh && sh ./aws_debian9.sh
```
##### Simple (no software installation)

```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim && wget -O ~/.vimrc https://raw.githubusercontent.com/regcostajr/dotfiles/master/.vimrc && wget -O ~/.bash_profile https://raw.githubusercontent.com/regcostajr/dotfiles/master/.bash_profile && curl -o ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
```
