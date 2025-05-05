local autocmd = vim.api.nvim_create_autocmd


-- Highlight on yank
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 1000,
    })
  end,
})

-- Remove whitespace on save
autocmd("BufWritePre", {
  pattern = "*",
  command = ":%s/\\s\\+$//e",
})

-- Auto format on save
autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- Don"t auto comment new lines
autocmd("BufEnter", {
  pattern = "*",
  command = "set fo-=c fo-=r fo-=o",
})

autocmd("Filetype", {
  pattern = { "xml", "html", "xhtml", "css", "scss", "javascript", "typescript", "yaml", "lua", "nix" },
  command = "setlocal shiftwidth=2 tabstop=2",
})

-- Set colorcolumn
autocmd("Filetype", {
  pattern = { "python", "rst", "c", "cpp", "lua" },
  command = "set colorcolumn=120",
})

autocmd("Filetype", {
  pattern = { "gitcommit", "markdown", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

autocmd('LspAttach', {
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = { buffer = true }
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Displays hover information about the symbol under the cursor
    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

    -- Jump to the definition
    bufmap('n', 'gd', '<cmd>Telescope lsp_definitions<cr>')

    -- Jump to declaration
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

    -- Lists all the implementations for the symbol under the cursor
    bufmap('n', 'gi', '<cmd>Telescope lsp_implementations<cr>')

    -- Jumps to the definition of the type symbol
    bufmap('n', 'go', '<cmd>Telescope lsp_type_definitions<cr>')

    -- Lists all the references
    bufmap('n', 'gr', '<cmd>Telescope lsp_references<cr>')

    -- Displays a function's signature information
    bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

    -- Renames all references to the symbol under the cursor
    bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

    -- Selects a code action available at the current cursor position
    bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')

    -- Show diagnostics in a floating window
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

    -- Move to the previous diagnostic
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

    -- Move to the next diagnostic
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  end
})
