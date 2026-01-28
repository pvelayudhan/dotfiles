-- Define LSP keymaps in a function
local on_attach = function(client, bufnr)
  local buf_map = function(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  -- Common LSP mappings
  buf_map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
  buf_map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
  buf_map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
  buf_map("n", "gr", vim.lsp.buf.references, { desc = "Go to References" })
  buf_map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
  buf_map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
  buf_map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
  buf_map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
  buf_map("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
  buf_map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
  buf_map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Quickfix List" })
end

return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      lspconfig.clangd.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }
    end,
  }
}
