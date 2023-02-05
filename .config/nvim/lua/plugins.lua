-- auto install packer
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PackerBootstrap = vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
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
    requires = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzy-native.nvim" },
    config = function()
      require("telescope").setup {
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
          mappings = {
            n = {
              ["<c-b>"] = "delete_buffer",
            },
          },
        }
      }
    end
  }

  use {
    "AckslD/nvim-neoclip.lua",
    requires = "nvim-telescope/telescope.nvim",
    config = function()
      require("neoclip").setup {
        history = 50,
      }
      require("telescope").load_extension("neoclip")
    end,
  }

  use {
    "ray-x/lsp_signature.nvim"
  }

  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup {}
    end,
    requires = "nvim-lua/plenary.nvim",
    event = "BufRead"
  }

  use {
    "lewis6991/spellsitter.nvim",
    config = function()
      require("spellsitter").setup {
        enable = true,
      }
    end
  }

  use {
    'romgrk/barbar.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require("bufferline").setup {
        animation = false,
        semantic_letters = false,
        letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
      }
    end,
  }

  use {
    -- NOTE: call ':TSInstall <tab>' to install language support
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        highlight = { enable = true },
        indent = { enable = false },
      }
    end
  }

  use {
    "nvim-treesitter/nvim-treesitter-context",
    requires = "nvim-treesitter/nvim-treesitter"
  }

  use "folke/which-key.nvim"

  use {
    "RRethy/vim-illuminate", -- highlight word under cursor
    config = function()
      require("illuminate").configure({
        providers = { 'regex', },
        delay = 50, -- ms
      })
    end
  }

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
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end
  }

  use {
    "mg979/vim-visual-multi",
    config = function()
      vim.g["VM_theme"] = "purplegray"
    end
  }

  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup {
        show_current_context = true,
        show_current_context_start = false,
      }
    end
  }

  use {
    "rose-pine/neovim",
    as = "rose-pine",
    config = function()
      require("rose-pine").setup {
        dark_variant = "moon",
        disable_background = false,
        dim_nc_background = true,
      }
      vim.cmd("colorscheme rose-pine")

      local palette = require("rose-pine.palette")
      local blend = require("rose-pine.util").blend
      local searchbg = blend(palette.love, palette.base, 0.8)
      vim.cmd("hi Search guibg=" .. searchbg .. " guifg=" .. palette.base)

      vim.cmd("hi IncSearch gui=bold guifg=" .. palette.love .. " guibg=" .. palette.base)

      -- Symbols Outline
      vim.cmd("hi FocusedSymbol guibg=" .. palette.rose .. " guifg=" .. palette.base)

      -- floating windows (lspconfig)
      vim.cmd("hi NormalFloat guibg=" .. palette.base)
      vim.cmd("hi FloatBorder guifg=" .. palette.rose .. " guibg=" .. palette.base)

      -- indent-blankline.nvim
      local indentColor = blend(palette.iris, palette.base, 0.05)
      vim.cmd("hi IndentBlanklineChar guifg=" .. indentColor .. " gui=nocombine")

      -- nvim-treesitter-context
      vim.cmd("hi TreesitterContext guibg=" .. blend(palette.rose, palette.base, 0.1))
    end
  }

  use {
    "nvim-lualine/lualine.nvim",
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require("lualine").setup {
        options = {
          theme = 'rose-pine-alt',
          component_separators = { left = ' ', right = ' ' }
        },
        sections = {
          lualine_a = { 'branch' },
          lualine_b = { { 'filename', path = 1 } },
          lualine_c = { 'diagnostics' },
          lualine_x = { 'lsp_progress', 'filetype', 'encoding', 'fileformat' },
          lualine_y = { 'location' },
          lualine_z = { 'mode' }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { { 'filename', path = 1 } },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {}
        },
      }
    end
  }

  use {
    'arkav/lualine-lsp-progress',
    requires = { "nvim-lualine/lualine.nvim" }
  }

  use "purescript-contrib/purescript-vim"

  use "gabrielpoca/replacer.nvim" -- editable quickfix window

  use {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup {}
    end
  }

  use {
    "petertriho/nvim-scrollbar",
    config = function()
      local palette = require("rose-pine.palette")
      require("scrollbar").setup({
        handle = {
          color = palette.highlight_high,
        }
      })
    end
  }

  use {
    "L3MON4D3/LuaSnip",
    tag = "v1.*",
    requires = "honza/vim-snippets",
    config = function()
      require("luasnip").filetype_extend("all", { "_" }) -- honza/vim-snippets global snippets
      require("luasnip.loaders.from_snipmate").lazy_load()
    end
  }

  -- Automatically set up configuration after cloning packer.nvim
  if PackerBootstrap then
    require("packer").sync()
  end
end)

-- configure outside of packer to allow overriding
vim.g.notes_directories = { '~/Nextcloud/Notes' }
