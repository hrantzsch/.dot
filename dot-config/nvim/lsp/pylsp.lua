---@type vim.lsp.Config
return {
  cmd = { "pylsp" },
  root_markers = { ".git", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt" },
  filetypes = { "python" },
  settings = {
    pylsp = {
      plugins = {
        jedi = { enabled = true, environment = vim.fn.getenv('VIRTUAL_ENV'), },
        pycodestyle = { enabled = true, maxLineLength = 100 },
        pylint = { enabled = true, },
        mccabe = { enabled = false, },
        pydocstyle = { enabled = false, },
        -- 3rd party plugins
        -- manually run :PylspInstall pylsp-mypy pyls-isort python-lsp-ruff
        -- TODO: make sure pyproject.toml takes precedence
        mypy = { enabled = true, strict = true, },     -- https://github.com/python-lsp/pylsp-mypy
        ruff = { enabled = true, },                    -- https://github.com/python-lsp/python-lsp-ruff
      },
      signature = { formatter = "ruff" },
    },
  },
}
