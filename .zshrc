#	                ██
#	               ░██
#	 ██████  ██████░██      ██████  █████
#	░░░░██  ██░░░░ ░██████ ░░██░░█ ██░░░██
#	   ██  ░░█████ ░██░░░██ ░██ ░ ░██  ░░
#	  ██    ░░░░░██░██  ░██ ░██   ░██   ██
#	 ██████ ██████ ░██  ░██░███   ░░█████
#	░░░░░░ ░░░░░░  ░░   ░░ ░░░     ░░░░░

ZSH=$HOME/dotfiles/.oh-my-zsh # Path to your oh-my-zsh configuration.
ZSH_THEME=powerlevel10k/powerlevel10k

#DEFAULT_USER="bradparbs@bradparbs"
COMPLETION_WAITING_DOTS="true"
DISABLE_AUTO_UPDATE=true
ZSH_CUSTOM=$HOME/.dotfiles/zsh-custom
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')

unsetopt nomatch
setopt APPEND_HISTORY
setopt INTERACTIVE_COMMENTS

plugins=(
	brew
	brew-cask
	git
	git-extras
	github
	lol
	nyan
    node
	osx
	parbs-sites
    rake
    python
    javascript
    bash
	vagrant
	z
	zsh-syntax-highlighting
    docker
    docker-compose
    kubectl
    minikube
    npm
    yarn
    jira
)

source $HOME/.oh-my-zsh/oh-my-zsh.sh
for file in $HOME/.dotfiles/sourced/*; do
   source "$file"
done

if (( $+commands[tag] )); then
	tag() { command tag "$@"; source ${TAG_ALIAS_FILE:-/tmp/tag_aliases} 2>/dev/null }
	alias ag=tag
fi

PATH=${PATH}:/usr/local/bin
PATH=${PATH}:/usr/bin
PATH=${PATH}:/bin
PATH=${PATH}:/usr/sbin
PATH=${PATH}:/sbin
PATH=${PATH}:/usr/local/git/bin
PATH=${PATH}:"$HOME"/.dotfiles/misc
PATH=${PATH}:"$HOME"/.dotfiles/bin
PATH=${PATH}:"$HOME"/.dotfiles/bin/t
PATH=${PATH}:"$HOME"/go/bin
PATH=${PATH}:"$HOME"/.yarn/bin
PATH=${PATH}:"/usr/local/sbin"
PATH=${PATH}:"usr/local/share/npm/bin"

export PATH=${PATH}
