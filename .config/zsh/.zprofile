PATH="$PATH:$HOME/.cabal/bin:$HOME/.ghcup/bin"
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

PATH="$PATH:$HOME/.cargo/bin"
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

command -v go >/dev/null && PATH="$PATH:$(go env GOPATH)/bin"

export RYE_NO_AUTO_INSTALL=1
[ -f "$HOME/.rye/env" ] && source "$HOME/.rye/env"

export PATH

export BROWSER=firefox
export EDITOR=nvim
export VISUAL=nvim

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent
