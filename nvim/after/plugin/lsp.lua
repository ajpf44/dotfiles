local lsp = require('lspconfig')

lsp.clangd.setup({})
lsp.ts_ls.setup({})
lsp.gopls.setup({
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
})

