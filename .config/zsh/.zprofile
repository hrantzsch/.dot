export BROWSER=firefox
export EDITOR=nvim
export VISUAL=nvim

PATH="$PATH:$HOME/bin:$HOME/.local/bin"

PATH="$PATH:$HOME/.cabal/bin:$HOME/.ghcup/bin"
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

PATH="$PATH:$HOME/.cargo/bin"
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

PATH="$PATH:$HOME/Code/bits:$HOME/Code/bits-private"

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent
