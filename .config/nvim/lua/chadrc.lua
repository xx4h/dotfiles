---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "highlights"

M.base46 = {
  theme = "gatekeeper",
  theme_toggle = { "onedark", "gatekeeper", "bearded-arc" },

  hl_override = highlights.override,
  hl_add = highlights.add,

  statusline = {
    theme = "vscode_colored"
  },

}

M.term = {
  float = {
    relative = "editor",
    row = 0.05,
    col = 0.1,
    width = 0.8,
    height = 0.8,
    border = "single",
  },
}

M.ui = {
  tabufline = {
    order = { "treeOffset", "buffers", "tabs", "btns"},
    -- order = { "treeOffset", "buffers", "tabs", "btns", 'abc'},
    -- modules = {
    -- abc = function()
    --  return "hi"
    -- }
  }

}

M.plugins = "plugins"

-- check core.mappings for table structure
-- M.mappings = require "mappings"

return M
