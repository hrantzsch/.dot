# -- Completion --
fpath=($ZDOTDIR/completions $fpath)
autoload -Uz compinit
if [[ -f "$ZDOTDIR/.zcompdump" && $(date +'%j') == $(date -r "$ZDOTDIR/.zcompdump" +'%j' 2>/dev/null) ]]; then
  compinit -C
else
  compinit
fi
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select

# -- History --
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt append_history hist_ignore_dups hist_ignore_space extended_history
unsetopt share_history

# -- Prompt --
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats '%F{blue}git:(%F{red}%b%F{blue})%f '
zstyle ':vcs_info:*' actionformats '%F{blue}git:(%F{red}%b|%a%F{blue})%f '

virtualenv_prompt_info() {
  [[ -n "$VIRTUAL_ENV" ]] && echo "(${VIRTUAL_ENV:t}) "
}

setopt prompt_subst
PROMPT='$(virtualenv_prompt_info)%(?.%B%F{green}➜ .%B%F{red}➜ )%f%b%F{cyan}%c%f ${vcs_info_msg_0_}'

# -- Plugins --
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

export FZF_DEFAULT_COMMAND="fd --unrestricted --exclude .git --exclude bazel-"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# based on rose-pine/fzf
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS"
 --color=fg:#e0def4,bg:#191724,hl:#ea9a97
 --color=fg+:#ebbcba,bg+:#26233a,hl+:#ea9a97
 --color=info:#9ccfd8,prompt:#ebbcba,pointer:#ea9a97
 --color=marker:#ea9a97,spinner:#eb6f92,header:#ea9a97"

# -- Terminal hooks --
set_term_title() {
  print -Pn "\e]0;$1\a"
}

preexec() {
  [[ -n "$1" ]] && set_term_title "$1"
}

precmd() {
  vcs_info
  set_term_title "${PWD/#$HOME/~}: zsh"
  # foot jump to prompt
  print -Pn "\e]133;A\e\\"
}

# -- Colors --
alias ls='ls --color=tty'
alias grep='grep --color=auto'
alias diff='diff --color'

# -- Aliases --
alias zshrc="nvim $ZDOTDIR/.zshrc && source $ZDOTDIR/.zshrc"

alias o="xdg-open"
alias v="nvim"

alias ssh="TERM=xterm-256color ssh"

alias fd="fdfind --hidden --follow"
alias rg="rg -S -M200"

alias d="dirs -v | head -n 10"

alias l="ls -lFh"
alias la="ls -lAFh"
alias ll="ls -l"

alias gst="git status"
alias ga="git add"
alias gapa="git add --patch"
alias gc="git commit"
alias gd="git diff"
alias gdca="git diff --cached"
alias gco="git checkout"
alias gc!="git commit --verbose --amend"
alias gfa="git fetch --all --prune"
alias grba="git rebase --abort"
alias grbc="git rebase --continue"
alias gcpa="git cherry-pick --abort"
alias gcpc="git cherry-pick --continue"
alias ghhh="git fetch && git reset --hard origin/\$(git rev-parse --abbrev-ref HEAD)"

alias wlp="wl-copy -p"

alias ox="openssl x509 -text -noout"

# slightly color man pages
man() {
    LESS_TERMCAP_md=$'\e[01;34m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[04;32m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    command man "$@"
}
export LESS="-iRMj4"

# -- Tool integrations --
eval "$(zoxide init zsh)"

_direnv_hook() {
  trap -- '' SIGINT;
  eval "$("/usr/bin/direnv" export zsh)";
  trap - SIGINT;
}
typeset -ag precmd_functions;
if [[ -z "${precmd_functions[(r)_direnv_hook]+1}" ]]; then
  precmd_functions=( _direnv_hook ${precmd_functions[@]} )
fi
typeset -ag chpwd_functions;
if [[ -z "${chpwd_functions[(r)_direnv_hook]+1}" ]]; then
  chpwd_functions=( _direnv_hook ${chpwd_functions[@]} )
fi

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || PATH="$PATH:$PYENV_ROOT/bin"
eval "$(pyenv init -)"

# -- Keybindings --
bindkey -e  # emacs keymap (overrides EDITOR-based vi default)
bindkey '^ ' autosuggest-accept
