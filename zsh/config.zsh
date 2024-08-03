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
    eval "$($HOME/miniforge3/bin/conda shell.zsh hook)"
}

# bypass firewall
function source-proxy()
{
    export PS1="(%{$fg[red]%}proxy%{$reset_color%}) ${PS1}"
    if [[ "$OS" == "Darwin" ]]; then
        export https_proxy=http://127.0.0.1:6152 http_proxy=http://127.0.0.1:6152 all_proxy=socks5://127.0.0.1:6153
        export GIT_SSH_COMMAND="ssh -o ProxyCommand='nc -X 5 -x 127.0.0.1:6153 %h %p'"
    else
        export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890
        export GIT_SSH_COMMAND="ssh -o ProxyCommand='nc -X 5 -x 127.0.0.1:7890 %h %p'"
    fi
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
    export PATH="$PATH:$HOME/.rvm/bin"
}
