return {
  {
    "Olical/conjure",
    version = "*",
    ft = { "clojure", "fennel", "lua" },
    lazy = true,
    config = function()
      vim.g["conjure#mapping#doc_word"] = {"<LocalLeader>k"}
    end
  }
}
