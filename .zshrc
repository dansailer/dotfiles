#	                ██
#	               ░██
#	 ██████  ██████░██      ██████  █████
#	░░░░██  ██░░░░ ░██████ ░░██░░█ ██░░░██
#	   ██  ░░█████ ░██░░░██ ░██ ░ ░██  ░░
#	  ██    ░░░░░██░██  ░██ ░██   ░██   ██
#	 ██████ ██████ ░██  ░██░███   ░░█████
#	░░░░░░ ░░░░░░  ░░   ░░ ░░░     ░░░░░

ZSH=$HOME/.oh-my-zsh # Path to your oh-my-zsh configuration.
ZSH_THEME=powerlevel10k/powerlevel10k

COMPLETION_WAITING_DOTS="true"
DISABLE_AUTO_UPDATE=true
ZSH_CUSTOM=$HOME/.dotfiles/zsh-custom
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')

unsetopt nomatch
setopt APPEND_HISTORY
setopt INTERACTIVE_COMMENTS

plugins=(
    git
    git-extras
#    github
#    node
    osx
    rake
#    python
    zsh-syntax-highlighting
    docker
#    docker-compose
#    npm
    yarn
#    jira
    zsh-completions
)
eval "$(jenv init -)"

source $HOME/.oh-my-zsh/oh-my-zsh.sh
source $HOME/.dotfiles/sourced/aliases
source $HOME/.dotfiles/sourced/exports
#for file in $HOME/.dotfiles/sourced/*; do
#   source "$file"
#done

autoload -U compinit && compinit


# Minishift
which minishift &>/dev/null
if [[ $? == 0 ]]; then
  eval "$(minishift completion $(basename $SHELL))"
  eval $(minishift oc-env)
  eval "$(oc completion $(basename $SHELL))"
fi

#if (( $+commands[tag] )); then
#	tag() { command tag "$@"; source ${TAG_ALIAS_FILE:-/tmp/tag_aliases} 2>/dev/null }
#	alias ag=tag
#fi

PATH=${PATH}:/usr/local/git/bin
PATH=${PATH}:"$HOME"/.dotfiles/misc
PATH=${PATH}:"$HOME"/.dotfiles/bin
PATH=${PATH}:"$HOME"/go/bin
PATH=${PATH}:"$HOME"/.yarn/bin
PATH=${PATH}:"usr/local/share/npm/bin"
PATH="${PATH}:~/.minishift/cache/oc/v3.11.0/darwin"

export PATH=${PATH}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

for file in ~/.ssh/*.sh; do
    source "$file"
done

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/mc mc
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
