source ~/.git-prompt.sh

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
    remotename=${1:-regcostajr}
    forkname=${2:-regcostajr}
    
    REMOTES=`git remote -v`
    REMOTES=($REMOTES)

    UPSTREAM=$(echo "${REMOTES[1]}" | sed -E "s/:(\w+-?\w+)\//:${forkname}\//")

    git remote add ${remotename} ${UPSTREAM}
    git fetch ${remotename}
}

