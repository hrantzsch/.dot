vim.cmd "autocmd VimEnter * if expand('%:p:h') =~ '/home/hannes/Nextcloud/Notes' | Copilot disable | endif"
return {
  "github/copilot.vim",
}
