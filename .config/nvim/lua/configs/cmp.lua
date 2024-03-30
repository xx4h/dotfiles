local cmp = require("cmp")

local options = {
  mapping = {
    ["<C-Space>"] = {},
    ["<C-e>"] = {
      i = function()
        if cmp.visible() then
          cmp.abort()
        else
          cmp.complete()
        end
      end,
    },
  }
}

return options
