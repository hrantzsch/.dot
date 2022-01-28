if status is-interactive
    # environment
    set -gx PATH $PATH ~/bin
    set -gx EDITOR "/usr/bin/nvim --noplugin"
    set -gx VISUAL "/usr/bin/nvim --noplugin"
    set -gx BROWSER firefox
    set -gx TERMINAL alacritty

    # fish
    # disable greeting
    set fish_greeting

    # initialize gpg-agent
    set -gx GPG_TTY (tty)
    set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
    gpgconf --launch gpg-agent

    # fzf
    # note: key bindings are configured in `conf.d/fzf-key-bindings.fish`
    set -gx FZF_DEFAULT_COMMAND "fd --type f --hidden --follow --exclude .git"
    set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
    set -gx FZF_ALT_C_COMMAND "$FZF_DEFAULT_COMMAND"
    set -gx FZF_DEFAULT_OPTS "-m --color info:108,prompt:109,spinner:108,pointer:168,marker:168"
end
