#! /bin/bash

DOTFILES=$( cd -- "$( dirname -- "$(realpath "$0")" )" &> /dev/null && pwd )
echo "dotfiles path: ${DOTFILES}"

have_prog() {
	command -v $1 >/dev/null 2>&1
}

OS=$(uname -s)
if [ "$OS" = "Darwin" ]; then
	if ! have_prog brew; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi
	install_pkg() {
		for arg in "$@"; do
			brew install $1
		done
	}
elif [ "$OS" = "Linux" ]; then
	sudo apt-get update
	install_pkg() {
		for arg in "$@"; do
			sudo apt-get install -y $1
		done
	}
elif [ "$OS" = "Windows_NT" ]; then
	echo "Windows is not supported"
	exit -1
else
	echo "Unknown OS ${OS}"
	exit -1
fi

progs=(python3 python3-pip vim neovim tmux)
for prog in "${progs[@]}"; do
	if ! have_prog "${prog}"; then
		install_pkg $prog
	fi
done
if ! have_prog percol; then
	pip3 install percol
fi

if [ ! -d "${HOME}/.oh-my-zsh" ]; then
    git clone https://github.com/ohmyzsh/ohmyzsh.git $HOME/.oh-my-zsh
fi

mkdir -p $HOME/.config
rm -rf $HOME/.vimrc
rm -rf $HOME/.tmux.conf
rm -rf $HOME/.percol.d

ln -s $DOTFILES/vimrc $HOME/.vimrc
ln -s $DOTFILES/tmux.conf $HOME/.tmux.conf
ln -s $DOTFILES/percol.d $HOME/.percol.d

if [ ! -e "${HOME}/.zshrc" ]; then
	cp $HOME/.oh-my-zsh/templates/zshrc.zsh-template $HOME/.zshrc
fi
echo "source ${DOTFILES}/zshrc" >> $HOME/.zshrc

git config --global user.name "Xin Yang"
git config --global user.email "yangxin0@outlook.com"
