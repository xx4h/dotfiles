require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

-- disable mouse
vim.opt.mouse = ""
-- enable mouseevents
vim.opt.mousemoveevent = true
vim.opt.foldenable = false
vim.opt.foldmethod = "syntax"
vim.opt.listchars = {
  tab = "> ",
  trail = "+",
  -- eol = "$",
  -- extends = "",
  -- precedes = "",
}
