return {
  {
    "Olical/conjure",
    version = "*",
    ft = { "clojure", "fennel", "lua" },
    lazy = true,
    config = function()
      vim.g["conjure#mapping#doc_word"] = {"<LocalLeader>k"}
      vim.g["conjure#log#hud#width"] = 0.8
      vim.g["conjure#log#hud#height"] = 0.4
      vim.g["conjure#log#hud#open_when"] = "log-win-not-visible"
      vim.g["conjure#highlight#enabled"] = true
      vim.g["conjure#highlight#timeout"] = 300
    end
  }
}
