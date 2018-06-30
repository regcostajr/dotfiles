# ------------------------------------------------------------------------------------------------------------
#
# PERSONAL $HOME/.bash_profile
# By Raunak Kathuria
#
# This file is normally read by interactive shells only.
# Here is the place to define your aliases, functions and
# other interactive features like your prompt.
#
# ------------------------------------------------------------------------------------------------------------

#
# To __git_ps1 set we need to setup git-prompt.sh
# You can do this by
# curl -o ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
#
source ~/.git-prompt.sh

# Default interaction prompt
# 0 [06:22] root@debian-wheezy /home/git/organization/repo (branch) #
export PS1='$? \[\033[01;32m\][$(date +%H:%M)]\[\033[00m\] \[\033[01;31m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\]\[\033[01;35m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '

# git grep for multiple repos
# go to parent directory where all repo are located then ggrep "search"
# you can also pass flags like ggrep -i "search" (for case insensitive search)
# -----------------------------------------
#
# go to /home/git then do ggrep "InvalidToken"
#
# Output:
#
# /home/git/org/repo1
# /home/git/org/repo2
# /home/git/org/repo3
# /home/git/org/repo3
# lib/v3/Utility.pm:59:            code              => 'InvalidToken',
# lib/v3/Utility.pm:142:            code              => "InvalidToken",
#
# -----------------------------------------
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

# git

# addgitremote regcostajr

addgitremote() {
    REMOTES=`git remote -v`
    REMOTES=($REMOTES)

    UPSTREAM=$(echo "${REMOTES[1]}" | sed -E "s/:(\w+)\//:${1}\//")

    git remote add $1 ${UPSTREAM}
}

# java

# mvnnewapp groupID artifactID

mvnnewapp(){
    mvn -B archetype:generate \
        -DarchetypeGroupId=org.apache.maven.archetypes \
        -DarchetypeVersion=1.3 \
        -DgroupId=com.$1 \
        -DartifactId=$2
}

# go 

setgopath(){
    GOPATH=$(pwd)
}

