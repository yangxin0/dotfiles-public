DOTFILES=$( cd -- "$( dirname -- "$(realpath "$0")" )" &> /dev/null && pwd )
OS=$(uname -s)

alias ll='ls -l'
alias la='ls -a'
alias grep="grep --color=auto"
alias vim=nvim
alias apt-no-cert='apt -o "Acquire::https::Verify-Peer=false"'

export EDITOR=nvim
export GIT_EDITOR=nvim
export GOPROXY="https://goproxy.cn"

# history search with ctrl-r
eval "$(fzf --zsh)"
export FZF_DEFAULT_OPTS="--height 100% --layout=reverse"

# 256 colors for color theme
function print-256-colors()
{
    for i in {0..255}
    do
        print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}
    done
}

# python manager
function source-conda()
{
    FORGE=$HOME/miniforge3
    CONDA="${FORGE}/bin/conda"
    __conda_setup="$($CONDA 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "${FORGE}/etc/profile.d/conda.sh" ]; then
            . "${FORGE}/etc/profile.d/conda.sh"
        else
            export PATH="${FORGE}/bin:$PATH"
        fi
    fi
    unset __conda_setup
}

# bypass firewall mainly for linux
function source-proxy()
{
    if [ -z "$__PS1" ]; then
        export __PS1=$PS1
    fi
    export PS1="(%{$fg[red]%}proxy%{$reset_color%}) ${__PS1}"
    export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890
    export GIT_SSH_COMMAND="ssh -o ProxyCommand='nc -X 5 -x 127.0.0.1:7890 %h %p'"
}

function source-no-proxy()
{
    if [ ! -z "$__PS1" ]; then
        export PS1=$__PS1
        unset __PS1
    fi
    unset https_proxy http_proxy all_proxy
    unset GIT_SSH_COMMAND
}

# nodejs manager
function source-nvm()
{
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

# ruby manager
function source-rvm()
{
    # Make sure this is the last PATH variable change
    export PATH="$PATH:$HOME/.rvm/bin"
}
