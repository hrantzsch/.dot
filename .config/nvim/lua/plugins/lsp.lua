return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig", },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup {
      ensure_installed = { "lua_ls" },
      automatic_installation = false,
    }
    local lspconf = require("lspconfig")

    lspconf.lua_ls.setup {
      settings = {
        Lua = {
          addonManager = { enable = false, },
          diagnostics = { globals = { 'vim', 'use' } },
        },
      },
    }

    lspconf.pylsp.setup {
      settings = {
        pylsp = {
          plugins = {
            jedi = {
              environment = vim.fn.getenv('VIRTUAL_ENV'),
            },
            mccabe = { enabled = false, },
            pydocstyle = { enabled = false, },
            pycodestyle = { enabled = true, maxLineLength = 100 },
            pylint = { enabled = true, },
            -- 3rd party plugins
            -- manually run :PylspInstall pylsp-mypy pyls-isort python-lsp-black python-lsp-ruff
            black = { enabled = false, line_length = 100, }, -- https://github.com/python-lsp/python-lsp-black
            -- TODO: make sure pyproject.toml takes precedence
            mypy = { enabled = true, strict = true, },       -- https://github.com/python-lsp/pylsp-mypy
            ruff = { enabled = true, },                      -- https://github.com/python-lsp/python-lsp-ruff
          },
        },
      },
    }

    lspconf.rust_analyzer.setup {}

    vim.lsp.inlay_hint.enable()
  end
}
