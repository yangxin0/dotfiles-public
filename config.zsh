# Editor setup
alias vim=nvim
export EDITOR=nvim
export GIT_EDITOR=nvim

# Percol
function exists { which $1 &> /dev/null }

if exists percol; then
    function percol_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N percol_select_history
    bindkey '^R' percol_select_history
fi

# Golang
if [[ `uname` == "Darwin" ]]; then
    export GOROOT=/opt/go
else
    export GOROOT=/usr/local/go
fi
export GOPROXY="https://goproxy.cn"
export PATH=$PATH:$GOROOT/bin
export GOPATH=$HOME/go

function print-256-colors () {
    for i in {0..255}
    do
        print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}
    done
}
