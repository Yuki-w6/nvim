return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local function root_dir(bufnr)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        return vim.fs.root(fname, { "Cargo.toml", ".git" }) or vim.fn.getcwd()
      end

      local function start_ra(bufnr)
        for _, c in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
          if c.name == "rust_analyzer" then return end
        end

        vim.lsp.start({
          name = "rust_analyzer",
          cmd = { "rust-analyzer" },
          root_dir = root_dir(bufnr),
          capabilities = capabilities,
          settings = {
            ["rust-analyzer"] = {
              cargo = { allFeatures = true },
              checkOnSave = true,
              check = { command = "check" }, -- 開発寄り
            },
          },
        }, { bufnr = bufnr })
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "rust",
        callback = function(args) start_ra(args.buf) end,
      })

      -- よく使うLSPキー
      local map = vim.keymap.set
      map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
      map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
      map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
    end,
  },
}
