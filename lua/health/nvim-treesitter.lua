local M = {}
function M.check()
  require("nvim-treesitter.health").check()
end
return M
