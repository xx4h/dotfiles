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

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- Project sessions live under $XDG_STATE_HOME/nvim/sessions/ keyed by CWD,
-- so nothing leaks into project directories. tmux-resurrect restores panes
-- by re-running plain `nvim`; this autocmd then sources the matching state
-- file and hands tracking to vim-obsession for continuous saves.
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.v.this_session ~= "" or vim.fn.argc() > 0 then return end
    vim.fn.system({ "git", "rev-parse", "--is-inside-work-tree" })
    if vim.v.shell_error ~= 0 then return end
    local enc = vim.fn.getcwd():gsub("/", "%%")
    local sess = vim.fn.stdpath("state") .. "/sessions/" .. enc .. ".vim"
    vim.fn.mkdir(vim.fn.fnamemodify(sess, ":h"), "p")
    if vim.fn.filereadable(sess) == 1 then
      vim.cmd("silent! source " .. vim.fn.fnameescape(sess))
    end
    vim.cmd("Obsession " .. vim.fn.fnameescape(sess))
  end,
  nested = true,
})
