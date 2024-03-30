local cmp = require("cmp")

local options = {
  mapping = {
    ["<C-b>"] = cmp.mapping.complete(),
  }
}

return options
