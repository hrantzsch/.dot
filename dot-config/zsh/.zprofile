source <(dircolors -b)

export BROWSER=firefox
export EDITOR=nvim
export VISUAL=nvim

PATH="$PATH:$HOME/bin:$HOME/.local/bin"
PATH="$PATH:$HOME/Code/bits:$HOME/Code/bits-private"

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

export PATH
