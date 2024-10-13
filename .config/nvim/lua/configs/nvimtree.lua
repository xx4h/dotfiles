local options = {
-- git support in nvimtree
  git = {
    enable = true,
    ignore = false,
  },

  view = {
    adaptive_size = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return options
