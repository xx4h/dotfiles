return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre' -- uncomment for format on save
    event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = require "configs.nvimtree",
  },

  {
    "hrsh7th/nvim-cmp",
    opts = require "configs.cmp",
  },
  -- These are some examples, uncomment them if you want to see them work!
   {
     "neovim/nvim-lspconfig",
     config = function()
       require("nvchad.configs.lspconfig").defaults()
       require "configs.lspconfig"
     end,
   },

   {
   	"nvim-treesitter/nvim-treesitter",
   	opts = {
   		ensure_installed = {
   			"vim", "lua", "vimdoc",
        "html", "css"
   		},
   	},
   },

  -- Continuous session tracking. Save target is driven by an autocmd in
  -- options.lua so sessions land under $XDG_STATE_HOME, not project dirs.
  {
    "tpope/vim-obsession",
    lazy = false,
  },
}
