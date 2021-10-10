-- auto install packer
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PackerBootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Run PackerCompile when there are changes in plugins.lua
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- Config
require("packer").startup(function()
  -- packer can manage itself
  use "wbthomason/packer.nvim"

  use {
    "neovim/nvim-lspconfig",
    config = function()
      require("lsp-config").config()
    end
  }

  use {
    "nvim-telescope/telescope.nvim",
    requires = {"nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzy-native.nvim"},
    config = function()
      local t = require'telescope'
      t.setup{
        defaults = {
          layout_config = { horizontal = { prompt_position = "top" } },
          layout_strategy = "flex",
          sorting_strategy = "ascending",
          set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
          preview = {
            filesize_limit = 2, -- MB
            timeout = 100, -- ms
            msg_bg_fillchar = " ",
          },
          initial_mode = "normal",
        }
      }
      t.load_extension('fzy_native')
    end
  }

  use {
    "ray-x/lsp_signature.nvim"
  }

  use {
    "lewis6991/gitsigns.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("gitsigns-config").config()
    end,
    event = "BufRead"
  }

  use {
    "akinsho/nvim-bufferline.lua",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("bufferline-config").config()
    end,
  }

  use {
    -- NOTE: call ':TSInstall <tab>' to install language support
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require'nvim-treesitter.configs'.setup {
        highlight = {enable = true},
        indent = { enable = false},
      }
    end
  }

  use "folke/which-key.nvim"

  use "RRethy/vim-illuminate"  -- highlight word under cursor

  use "tpope/vim-commentary"
  use "tpope/vim-repeat"
  use "tpope/vim-surround"

  use {
    "xolox/vim-notes",
    requires = "xolox/vim-misc",
    config = function()
      vim.g.notes_directories = {'~/Nextcloud/Notes'}
      vim.g.notes_suffix = '.md'
      vim.g.notes_unicode_enabled = 0
      -- " make the C-] combination search for @tags:
      -- autocmd FileType markdown inoremap <C-]> <C-o>:SearchNotes<CR>
      -- autocmd FileType markdown nnoremap <C-]> :SearchNotes<CR>
    end
  }

  use {
    "mg979/vim-visual-multi",
    branch = "master"
  }

  use {
    "itchyny/lightline.vim",
    config = function()
      vim.g.lightline = {
        -- colorscheme is configured in settings.lua
        colorscheme = 'everforest',
        enable = { statusline = true, tabline = false },
        active = {
          left = {
            { 'mode', 'spell', 'paste' },
            { 'readonly', 'absolutepath', 'modified', }
          },
          right = {
            { 'percent', 'lineinfo', },
            { 'fileencoding', 'filetype', }
          }
        }
      }
    end
  }

  use "sainnhe/sonokai"
  use "sainnhe/everforest"

  use {
    "SirVer/ultisnips",
    requires = "honza/vim-snippets",
    config = function()
      vim.g.UltiSnipsExpandTrigger='<c-u>'
      vim.g.UltiSnipsJumpForwardTrigger = '<c-j>'
      vim.g.UltiSnipsJumpBackwardTrigger = '<c-k>'
      vim.g.UltiSnipsRemoveSelectModeMappings = 0
    end
  }

  use "purescript-contrib/purescript-vim"

  -- Automatically set up configuration after cloning packer.nvim
  if PackerBootstrap then
    require('packer').sync()
  end
end)
