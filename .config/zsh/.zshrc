# -- oh-my-zsh --

ZSH=/usr/share/oh-my-zsh/

ZSH_THEME="robbyrussell"  # See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

COMPLETION_WAITING_DOTS="true"
DISABLE_AUTO_TITLE="true"
DISABLE_AUTO_UPDATE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HYPHEN_INSENSITIVE="true"

# -- Plugins --

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Externally installed:
#   - oh-my-zsh-plugin-autosuggestions
plugins=(fd fzf git ssh-agent)

export FZF_DEFAULT_COMMAND="fd --unrestricted --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# based on rose-pine/fzf
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS"
 --color=fg:#e0def4,bg:#191724,hl:#ea9a97
 --color=fg+:#ebbcba,bg+:#26233a,hl+:#ea9a97
 --color=info:#9ccfd8,prompt:#ebbcba,pointer:#ea9a97
 --color=marker:#ea9a97,spinner:#eb6f92,header:#ea9a97"

zstyle :omz:plugins:ssh-agent quiet yes

# -- User configuration --

# Path
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

alias o=xdg-open
alias v=nvim

# -- oh-my-zsh --

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh
