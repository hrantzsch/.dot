return {
  {
    "Olical/conjure",
    ft = { "clojure", "fennel", "lua", "python" },
    lazy = true,
    config = function()
      vim.g["conjure#mapping#doc_word"] = false
    end
  }
}
