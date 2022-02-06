-- auto install packer
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PackerBootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Run PackerCompile when there are changes in plugins.lua
-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerCompile
--   augroup end
-- ]])

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
            timeout = 500, -- ms
            msg_bg_fillchar = " ",
          },
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
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'},
    config = function()
      vim.g.bufferline = {
        animation = false,
        -- If set, the letters for each buffer in buffer-pick mode will be
        -- assigned based on their name.
        semantic_letters = false,
        -- New buffer letters are assigned in this order.
        letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
    }
    end
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

  use "tpope/vim-commentary" -- TODO use  numToStr/Comment.nvim instead
  use "tpope/vim-repeat"
  use "tpope/vim-surround"

  use {
    "xolox/vim-notes",
    requires = "xolox/vim-misc",
    config = function()
      vim.g.notes_suffix = '.md'
      vim.g.notes_unicode_enabled = 0
      -- " make the C-] combination search for @tags:
      -- autocmd FileType markdown inoremap <C-]> <C-o>:SearchNotes<CR>
      -- autocmd FileType markdown nnoremap <C-]> :SearchNotes<CR>
    end
  }

  use {
    "mg979/vim-visual-multi",
    config = function()
      vim.g["VM_theme"] = "purplegray"
    end
  }

  use {
    "rose-pine/neovim",
    as = "rose-pine",
    config = function()
      vim.g["rose_pine_variant"] = "moon"
      vim.g["rose_pine_disable_background"] = true
      vim.g["rose_pine_inactive_background"] = true

      vim.cmd("colorscheme rose-pine")

      local palette = require'rose-pine.palette'
      local blend = require'rose-pine.util'.blend
      local searchbg = blend(palette.rose, palette.base, 0.8)
      vim.cmd("hi Search guibg="..searchbg.." guifg="..palette.base)

      local visualbg = blend(palette.iris, palette.base, 0.5)
      vim.cmd("hi Visual guibg="..visualbg)

      -- CursorLine is used by vim-illuminate
      local cursorbg = blend(palette.iris, palette.base, 0.2)
      vim.cmd("hi CursorLine guibg="..cursorbg)

      -- Symbols Outline
      vim.cmd("hi FocusedSymbol guibg="..palette.rose.." guifg="..palette.base)
    end
  }

  use {
    "nvim-lualine/lualine.nvim",
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require("lualine").setup {
        options = {
          theme = 'auto',
          section_separators = { left = '', right = ' ' },
          component_separators = { left = '', right = '' }
        }
      }
    end
  }

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

  use "gabrielpoca/replacer.nvim" -- editable quickfix window

  use {
    "simrat39/symbols-outline.nvim",
    config = function()
      vim.g.symbols_outline = {
        position = 'left',
      }
    end
  }

  -- Automatically set up configuration after cloning packer.nvim
  if PackerBootstrap then
    require('packer').sync()
  end
end)

-- configure outside of packer to allow overriding
vim.g.notes_directories = {'~/Nextcloud/Notes'}
