return {
  "RRethy/vim-illuminate",
  config = function()
    require("illuminate").configure({
      providers = { 'regex', },
      delay = 50, -- ms
    })
  end
}
