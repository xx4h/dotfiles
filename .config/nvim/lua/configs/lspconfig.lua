-- EXAMPLE 
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- TODO: find way to share this variable with ../plugins/init.lua
-- Don't forget to also modify ../plugins/init.lua
local servers = { "html", "cssls", "markdown_oxide", "bash-language-server", "golangci_lint_ls", "pylsp", "ts_ls", "nixd" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  vim.lsp.config[lsp] = {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
  vim.lsp.enable(lsp)
end

-- typescript
---lspconfig.tsserver.setup {
vim.lsp.config["ts_ls"] = {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

vim.lsp.enable("ts_ls")

vim.lsp.config["gopls"] = {
  settings = {
    gopls = {
      gofumpt = true
    }
  }
}

vim.lsp.enable("gopls")
