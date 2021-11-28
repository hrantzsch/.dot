# Dotfiles

Use GNU Stow to deploy: `stow -v .`

To add new files to the stow simply move them here, then deploy again to create the symlinks.

## Why not `stow --dotfiles`?

Due to [a bug in stow](https://github.com/aspiers/stow/issues/33) that doesn't seem to get fixed anytime soon the `--dotfiles` option doesn't work. I'll have to live with hidden directories for now.

## Troubleshooting

### File Exists

```sh
$ stow -v .
[...]
WARNING! stowing . would cause conflicts:
  * existing target is neither a link nor a directory: .config/fish/config.fish
  * existing target is neither a link nor a directory: .config/fish/fish_variables
All operations aborted.`
```

Fish has already created the config directory on its first run. Delete ~/.config/fish and stow again.
