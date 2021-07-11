" ------------------------------------------------------------------------------
call plug#begin('~/.config/nvim/plugged')
" ------------------------------------------------------------------------------

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'mhinz/vim-signify'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'dyng/ctrlsf.vim'

Plug 'machakann/vim-highlightedyank'

Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

Plug 'jacoborus/tender.vim'

Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'

" ------------------------------------------------------------------------------
call plug#end()
" ------------------------------------------------------------------------------

set nocompatible

let mapleader = ","
nnoremap <Space> :

" ------------------------------------------------------------------------------
"  Plugin configs
" ------------------------------------------------------------------------------

" yank highlight
let g:highlightedyank_highlight_duration = 250

" fzf
nnoremap <leader><leader> :Buffers<CR>
nnoremap <leader>m :Marks<CR>
nnoremap <leader>n :Files<CR>
nnoremap <Leader>T :Tags <C-R><C-W><CR>
nnoremap <leader>v :Tags<CR>

" CtrlSF
let g:ctrlsf_default_view_mode = 'compact'
let g:ctrlsf_ackprg = 'rg'
" CtrlSF word under cursor
nnoremap <leader>a :CtrlSF<CR>

" snippets and completion
set completeopt=noinsert,menuone,noselect
set shortmess+=c

inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

let g:deoplete#enable_at_startup = 1

" c-j c-k for moving in snippet
" imap <c-u> <C-o> <Plug>(ultisnips_expand)
let g:UltiSnipsExpandTrigger="<c-u>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
" let g:UltiSnipsRemoveSelectModeMappings = 0

" CtrlSF
let g:ctrlsf_default_view_mode = 'compact'
let g:ctrlsf_ackprg = 'rg'
" CtrlSF word under cursor
nnoremap <leader>a :CtrlSF<CR>

" notes
let g:notes_directories = ['~/Nextcloud/Notes/Zettel']
let g:notes_suffix = '.md'
let g:notes_unicode_enabled = 0
" make the C-] combination search for @tags:
autocmd FileType markdown inoremap <C-]> <C-o>:SearchNotes<CR>
autocmd FileType markdown nnoremap <C-]> :SearchNotes<CR>


" markdown preview
let vim_markdown_preview_github=1
let vim_markdown_preview_toggle=2
"   markdown-preview for all file types
let g:mkdp_command_for_global = 1


" ------------------------------------------------------------------------------
"  Key mappings
" ------------------------------------------------------------------------------

nmap <silent> <F2> :!g++ -fdiagnostics-color=never --std=c++17 % && ./a.out<CR>

nnoremap <leader>s :%s/
vnoremap <leader>s :s/

" emulate 'modern' ctrl-c in normal and visual
nnoremap <C-c> "+yy
vnoremap <C-c> "+y
" paste in insert mode
inoremap <C-v> <Esc>pa

" clear line
nnoremap X 0d$

" visual selection to search
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" navigation
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
nnoremap <A-S-h> <C-w>H
nnoremap <A-S-j> <C-w>J
nnoremap <A-S-k> <C-w>K
nnoremap <A-S-l> <C-w>L
" terminal: escape and move
tnoremap <C-e> <C-\><C-n>:bn<CR>
tnoremap <C-q> <C-\><C-n>:bN<CR>
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l

" navigate buffers
noremap <C-e> :bn<CR>
noremap <C-q> :bN<CR>
noremap <leader>. <C-^>
" close buffer but not split
nnoremap <leader>d :b#<bar>bd#<CR>

nnoremap <C-n> *N

nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprev<CR>
nnoremap <C-l> :cc<CR>

" show unsaved changes
nnoremap <silent> <leader>w :w !diff % -<CR>

" nohlsearch
nnoremap <silent> <leader>h :nohlsearch<CR>

" spell checking
nnoremap <F5> :setlocal spell! spelllang=en_us<CR>

" word highlight
nnoremap <F4> :CWordHlActivate<CR>

" edit config
nnoremap <leader>ce :e $MYVIMRC<CR>
" reload config
nnoremap <leader>cr :so $MYVIMRC<CR>

" ------------------------------------------------------------------------------
"  Utils
" ------------------------------------------------------------------------------

" 'Prose Mode' -- spellcheck, wrap and no tw
function! s:proseMode()
    set tw=0
    set wrap
    setlocal spell! spelllang=en_us
endfunction
function! s:endProseMode()
    set tw=80
    set nowrap
    setlocal spell! spelllang=en_us
endfunction
:command! Prose :call s:proseMode()
:command! NoProse :call s:endProseMode()

" Highlight word under cursor
"   stripped the essential parts of the much more powerful t9md/vim-quickhl
"   see also https://www.vim.org/scripts/script.php?script_id=3692
let g:cword_hl_enable_on_startup = 1
let g:cword_hl_command = 'Cword guibg=#0e4547'

let s:cwordhl = { "enabled": g:cword_hl_enable_on_startup }
let s:metachar = '\/~ .*^[''$'
function! s:cwordhl.escape(pattern)
  return escape(a:pattern, s:metachar)
endfunction

function! s:cwordhl.init_highlight()
  exe "highlight ". escape(g:cword_hl_command, '!|')
endfunction

function! s:cwordhl.refresh()
  silent! 2match none
  if !self.enabled | return | endif
  let pattern = s:cwordhl.escape(expand('<cword>'))
  exe "2match Cword /\\\<". pattern . "\\\>/"
endfunction

function! s:cwordhl.enable()
  let s:cwordhl.enabled = 1
  augroup CWord
    autocmd!
    autocmd! CursorMoved <buffer> call s:cwordhl.refresh()
    autocmd! ColorScheme * call s:cwordhl.init_highlight()
  augroup END
  call s:cwordhl.init_highlight()
  call s:cwordhl.refresh()
endfunction

function! s:cwordhl.disable()
  let s:cwordhl.enabled = 0
  augroup CWord
    autocmd!
  augroup END
  autocmd! CWord
  call s:cwordhl.refresh()
endfunction

:command! CWordHlActivate :call s:cwordhl.enable()
:command! CWordHlDeactivate :call s:cwordhl.disable()

autocmd BufNew * if g:cword_hl_enable_on_startup |
  \ call s:cwordhl.enable() | endif

" ------------------------------------------------------------------------------
"  Basic Settings
" ------------------------------------------------------------------------------

set hidden             " allow unsafed buffers
set nobackup           " keep a backup file (restore to previous version)
set undofile           " keep an undo file (undo changes after closing)
set ruler              " show the cursor position all the time
set tw=80
set colorcolumn=+1     " show a ruler after column 80

set signcolumn=yes     " always draw the signcolumn

set showcmd            " display incomplete commands
set cmdheight=1
set scrolloff=3        " keep n lines above/below the cursor

set number
set nowrap

set ignorecase
set smartcase
set smarttab
set smartindent
set autoindent
set softtabstop=4
set shiftwidth=4
set expandtab
set incsearch
set inccommand=split
set mouse=a
set history=1000

set virtualedit=block
set nojoinspaces       " insert only one space after '.' when joining lines

set tags=./.tags;

set list listchars=tab:»·,trail:·   " show trailing tabs and spaces
autocmd BufWritePre * %s/\s\+$//e   " remove trailing tabs and spaces

" ------------------------------------------------------------------------------
"  Theming
" ------------------------------------------------------------------------------

set termguicolors
set background=dark

syntax enable

colorscheme tender

let g:lightline = {
  \ 'colorscheme': 'tender',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'tabline': {
  \   'left': [ ['buffers'] ]
  \ },
  \ 'component_expand': {
  \   'buffers': 'lightline#bufferline#buffers'
  \ },
  \ 'component_type': {
  \   'buffers': 'tabsel'
  \ }
  \ }
set showtabline=2

hi Comment cterm=italic
