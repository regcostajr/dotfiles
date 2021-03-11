source ~/.git-prompt.sh

# copied from https://github.com/raunakkathuria/dotfiles/blob/master/.bash_profile
################################################################################
export PS1='$? \[\033[01;32m\][$(date +%H:%M)]\[\033[00m\] \[\033[01;31m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\]\[\033[01;35m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '

ggrep() {
    find . -type d -name .git | while read line; do
        (
        cd $line/..
        cwd=$(pwd)
        echo "$(tput setaf 2)$cwd$(tput sgr0)"
        git grep -n "$@"
        )
    done
}

addgitremote() {
    REMOTES=`git remote -v`
    REMOTES=($REMOTES)

    UPSTREAM=$(echo "${REMOTES[1]}" | sed -E "s/:(\w+-?\w+)\//:${2}\//")

    git remote add $1 ${UPSTREAM}
}
################################################################################

run_ctags() {
    ctags --languages=perl,javascript,vim,sql --recurse=yes -f ~/.vim/tags
}

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
