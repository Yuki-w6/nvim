-- =========================
--  init.lua (minimal + lazy.nvim)
-- =========================

-- Leader（先に決める）
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 基本設定を分割読み込み
require("config.options")
require("config.keymaps")

-- ---- lazy.nvim bootstrap ----
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ---- lazy.nvim setup ----
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true }, -- 更新チェック（好みでfalseでもOK）
})

