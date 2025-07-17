local lspconfig = require("lspconfig")
local util = require("lspconfig.util")
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.eslint.setup({
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})

lspconfig.vtsls.setup({
  capabilities = lsp_capabilities,
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx", },
  settings = {
    complete_function_calls = true,
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = {
        maxInlayHintLength = 30,
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
    typescript = {
      updateImportsOnFileMove = { enabled = "always" },
      suggest = {
        completeFunctionCalls = true,
      },
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = false },
      },
    },
  },
})

lspconfig.ruff.setup {
  capabilities = lsp_capabilities,
  on_attach = function(client)
    if client.name == 'ruff' then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end
  end
}
lspconfig.pyright.setup({
  capabilities = lsp_capabilities,
  settings = {
    pyright = {
      -- Using Ruff's import organizer
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        -- Ignore all files for analysis to exclusively use Ruff for linting
        ignore = { '*' },
      },
    },
  },
})
lspconfig.lua_ls.setup({
  capabilities = lsp_capabilities,
})
lspconfig.ccls.setup({
  capabilities = lsp_capabilities,
})
lspconfig.emmet_ls.setup({
  capabilities = lsp_capabilities,
})
lspconfig.eslint.setup({
  capabilities = lsp_capabilities,
})
