--[[
auto install packer
from ChristianChiarulli/LunarVim
]]

local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  vim.api.nvim_command("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  vim.api.nvim_command "packadd packer.nvim"
end

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
  return
end

packer.init {
  compile_path = vim.fn.stdpath('data')..'/site/pack/loader/start/packer.nvim/plugin/packer_compiled.vim',
  git = {
    clone_timeout = 300
  },
  display = {
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
  },
}

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

require("packer").startup(function()
  -- packer can manage itself after that
  use "wbthomason/packer.nvim"

  use {
    "neovim/nvim-lspconfig",
    config = function()
      require("lsp-config").config()
    end
  }
  use "glepnir/lspsaga.nvim"

  use {
    "nvim-telescope/telescope.nvim",
    requires = {"nvim-lua/popup.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzy-native.nvim"},
    config = function()
      local t = require'telescope'
      t.setup{
        defaults = {
          layout_config = { horizontal = { prompt_position = "top" } },
          layout_strategy = "flex",
          sorting_strategy = "ascending",
          set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
        }
      }
      t.load_extension('fzy_native')
    end
  }

  use {
    "hrsh7th/nvim-compe",
    config = function()
      require("compe-config").config()
    end
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

  use "romgrk/nvim-treesitter-context"

  use "folke/which-key.nvim"

  use "RRethy/vim-illuminate"  -- highlight word under cursor

  use "tpope/vim-commentary"
  use "tpope/vim-repeat"
  use "tpope/vim-surround"

  use "xolox/vim-misc"
  use "xolox/vim-notes"

  use {
    "mg979/vim-visual-multi",
    branch = "master"
  }

  use "itchyny/lightline.vim"
  use "sainnhe/sonokai"
  use "sainnhe/everforest"

  use {
    "SirVer/ultisnips",
    requires = "honza/vim-snippets"
  }

  use "stevearc/aerial.nvim"

  use "purescript-contrib/purescript-vim"

  --[[
  use { "camspiers/snap", rocks = {"fzy"}}
  ]]

end)

--[[
configuration for non-lua plugins
]]

-- itchyny/lightline
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

-- xolox/vim-notes
vim.g.notes_directories = {'~/Nextcloud/Notes'}
vim.g.notes_suffix = '.md'
vim.g.notes_unicode_enabled = 0
-- " make the C-] combination search for @tags:
-- autocmd FileType markdown inoremap <C-]> <C-o>:SearchNotes<CR>
-- autocmd FileType markdown nnoremap <C-]> :SearchNotes<CR>

-- stevearc/aerial
vim.g.aerial_min_width = 20

-- SirVer/ultisnips
vim.g.UltiSnipsExpandTrigger='<c-u>'
vim.g.UltiSnipsJumpForwardTrigger = '<c-j>'
vim.g.UltiSnipsJumpBackwardTrigger = '<c-k>'
vim.g.UltiSnipsRemoveSelectModeMappings = 0
