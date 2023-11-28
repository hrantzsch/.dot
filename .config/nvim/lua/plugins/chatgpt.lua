return {
  "jackMort/ChatGPT.nvim",
  lazy = true,
  opts = {
    api_key_cmd = "pass show openai_api_key",
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim"
  }
}
