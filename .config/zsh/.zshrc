# -- oh-my-zsh --

ZSH=/usr/share/oh-my-zsh

ZSH_THEME="robbyrussell"  # See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

COMPLETION_WAITING_DOTS="true"
DISABLE_AUTO_TITLE="true"
DISABLE_AUTO_UPDATE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HYPHEN_INSENSITIVE="true"

# -- Plugins --
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(fzf git)

export FZF_DEFAULT_COMMAND="fd --unrestricted --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# based on rose-pine/fzf
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS"
 --color=fg:#e0def4,bg:#191724,hl:#ea9a97
 --color=fg+:#ebbcba,bg+:#26233a,hl+:#ea9a97
 --color=info:#9ccfd8,prompt:#ebbcba,pointer:#ea9a97
 --color=marker:#ea9a97,spinner:#eb6f92,header:#ea9a97"

# -- terminal escape sequences --
set_term_title() {
  print -Pn "\e]0;$1\a"
}

preexec() {
  [[ -n "$1" ]] && set_term_title "$1"
}

precmd() {
  set_term_title "${PWD/#$HOME/~}: zsh"  # Show shell and working directory
  # foot jump to prompt
  print -Pn "\e]133;A\e\\"
}


# -- User configuration --
#
# -- PATHs --
# -> put into $ZDOTDIR/.zprofile!

alias zshrc="$EDITOR $ZDOTDIR/.zshrc && source $ZDOTDIR/.zshrc"

alias o="xdg-open"
alias v="nvim"


# -- oh-my-zsh --

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

unsetopt share_history  # disable shared history

eval "$(zoxide init zsh)"
