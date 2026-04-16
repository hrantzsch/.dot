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
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#9893a5"
for _zsh_as in /usr/share/{,zsh/plugins}/zsh-autosuggestions/zsh-autosuggestions.zsh; do
  [[ -f "$_zsh_as" ]] && source "$_zsh_as" && break
done
unset _zsh_as
for _fzf_dir in /usr/share/{fzf,doc/fzf/examples}; do
  [[ -f "$_fzf_dir/key-bindings.zsh" ]] && source "$_fzf_dir/key-bindings.zsh"
  [[ -f "$_fzf_dir/completion.zsh" ]] && source "$_fzf_dir/completion.zsh"
done
unset _fzf_dir

export _fd_cmd=${commands[fd]:-${commands[fdfind]}}
export FZF_DEFAULT_COMMAND="$_fd_cmd --unrestricted --exclude .git --exclude bazel-"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
source "$ZDOTDIR/fzf-rose-pine-dawn.sh"


# -- Terminal hooks --
# slightly color man pages
man() {
    LESS_TERMCAP_md=$'\e[01;34m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[04;32m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    command man "$@"
}
export LESS="-iRMSj4"

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

umask 0027

alias zshrc="$EDITOR $ZDOTDIR/.zshrc && source $ZDOTDIR/.zshrc"

alias lg="lazygit"
alias lgl="lazygit log"
alias lgs="lazygit status"

alias o="xdg-open"
alias v="nvim"
alias y="yazi"
alias zath="zathura"

alias ssh="TERM=xterm-256color ssh"

alias fd="$_fd_cmd --hidden --follow"
alias rg="rg -S -M200"

alias ..="cd .."
alias ...="cd ../.."
alias d="dirs -v | head -n 10"

alias l="ls -lFh"
alias la="ls -lAFh"
alias ll="ls -l"

alias g="git"
alias ga="git add"
alias gapa="git add --patch"
alias gau="git add --update"
alias gb="git branch"
alias gba="git branch -a"
alias gc!="git commit --verbose --amend"
alias gcan="git commit --amend --no-edit"
alias gc="git commit --verbose"
alias gco="git checkout"
alias gcpa="git cherry-pick"
alias gcpa="git cherry-pick --abort"
alias gcpc="git cherry-pick --continue"
alias gd="git diff"
alias gdca="git diff --cached"
alias gfa="git fetch --all --prune"
alias ghh="git fetch && git reset --hard origin/\$(git rev-parse --abbrev-ref HEAD)"
alias grba="git rebase --abort"
alias grbc="git rebase --continue"
alias gst="git status"

alias md="mkdir -p"
function take() {
  mkdir -p "$1" && cd "$1"
}

alias wlp="wl-copy -p"

alias ox="openssl x509 -text -noout"

# -- Tool integrations --
eval "$(zoxide init zsh)"

# -- Keybindings --
bindkey -e  # emacs keymap (overrides EDITOR-based vi default)
bindkey '^ ' autosuggest-accept
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line
