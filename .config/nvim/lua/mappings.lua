require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

--    [";"] = { ":", "enter command mode", opts = { nowait = true } },
--    ["<C-c>"] = { ":set nu! list! <CR>", "Toggle copy mode" },
map("n", "<leader>tt", function()
  require("base46").toggle_transparency()
end, { desc = "toggle transparency"})

map("n", "<leader>ct", function()
  require("base46").toggle_theme()
end, { desc = "toggle theme "})

map("n", "<leader>Rr", ":e <CR>", { desc = "Reload Buffer" })
map("n", "<leader>Rf", ":e! <CR>", { desc = "Reload Buffer (force, drop local changes)" })

map("n", "<leader>wf", function()
  vim.lsp.buf.format()
end, { desc = "LSP Run formatter" })

--map({ "n", "t" }, "<A-i>", function()
--  require("nvchad.term").toggle { pos = "float", id = "floatTerm", width = 0.9, height = 0.9 }
--end, { desc = "Terminal Toggle Floating term xxx" })

