return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig", },

  config = function()
    vim.diagnostic.config({
      virtual_text = true,
      virtual_lines = false,
      severity_sort = true,
      jump = {
        float = true,
        severity = vim.diagnostic.severity.ERROR,
      },
      float = { source = "always" },
    })

    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          addonManager = { enable = false, },
          diagnostics = { globals = { 'vim', 'use' } },
        },
      },
    })

    vim.lsp.config('pylsp', {
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
    })
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = { "*.py" },
      callback = function() vim.lsp.buf.format() end,
    })


    vim.lsp.config('rust_analyzer', {})

    -- vim.lsp.inlay_hint.enable()

    vim.lsp.config('ts_ls', {})

    -- vim.lsp.clangd.setup {}

    require("mason").setup()
    require("mason-lspconfig").setup {
      ensure_installed = { "lua_ls" },
      automatic_installation = false,
    }
  end
}
