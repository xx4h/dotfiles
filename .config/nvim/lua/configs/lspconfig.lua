-- EXAMPLE 
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- TODO: find way to share this variable with ../plugins/init.lua
-- Don't forget to also modify ../plugins/init.lua
local servers = { "html", "cssls", "markdown_oxide", "bashls", "golangci_lint_ls", "pylsp" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- typescript
---lspconfig.tsserver.setup {
lspconfig.ts_ls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

lspconfig.gopls.setup {
  settings = {
    gopls = {
      gofumpt = true
    }
  }
}
