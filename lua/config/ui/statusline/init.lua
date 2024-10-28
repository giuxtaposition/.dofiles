local utils = require("config.ui.statusline.utils")
local M = {}

function M.setup()
  vim.o.statusline = "%!v:lua.require'config.ui.statusline'.render()"
  M.namespace_id = vim.api.nvim_create_namespace("statusline")
  utils.set_highlights()
end

function M.render()
  local modules = require("config.ui.statusline.modules")

  return table.concat({
    modules.mode(),
    modules.file(),
    modules.diagnostics(),
    "%#StatusLine#%=",
    modules.lsp(),
    modules.git_branch(),
  })
end

-- TODO: add current typed key
-- TODO: add if macro is recording

return M
