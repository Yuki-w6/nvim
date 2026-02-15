return {
  {
    -- 依存なしでNeovim標準のフォーマットを使う
    "neovim/nvim-lspconfig",
    optional = true,
    config = function()
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.rs",
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end,
  },
}
