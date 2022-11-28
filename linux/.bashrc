# Cute shell shortcuts
alias ls='ls --sort=extension --color=auto'
alias ll='ls -lh'
alias la='ls -A'
alias psg='ps -A | grep'
alias l='ls -CF'

# Git Commands
# Add and Commit are used as functions
alias gpo='git push origin master'
alias gp='git pull'
alias gs='git status'
alias gd='git diff'

# Functions to aid git workflow
function gc(){
    git commit -m "$*"
}

function gca(){
    git commit --amend
}

function giveme ()
{
    sudo apt-get install "$@"
}

# Useful unarchiver!
function extract () {
        if [ -f $1 ] ; then
                case $1 in
                        *.tar.bz2)        tar xjf $1                ;;
                        *.tar.gz)        tar xzf $1                ;;
                        *.bz2)                bunzip2 $1                ;;
                        *.rar)                rar x $1                ;;
                        *.gz)                gunzip $1                ;;
                        *.tar)                tar xf $1                ;;
                        *.tbz2)                tar xjf $1                ;;
                        *.tgz)                tar xzf $1                ;;
                        *.zip)                unzip $1                ;;
                        *.Z)                uncompress $1        ;;
                        *)                        echo "'$1' cannot be extracted via extract()" ;;
                esac
        else
                echo "'$1' is not a valid file"
        fi
}

# Because I am a lazy bum, and this is
# surpisingly helpful..
function up()
{
    for i in `seq 1 $1`;
    do
        cd ../
    done;
}