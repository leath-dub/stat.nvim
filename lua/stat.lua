local M = {}

-- global for module
Stat = M

M.themes = require("themes")
M.lib = require("lib")
M.mod = require("mod")
M.___ = { raw = true, value = "%=" }

local ___ = M.___
M.default_config = {
  winbar = {
    ___,
    M.mod.file()
  },
  statusline = {
    ___,
    M.mod.mode,
    M.mod.filetype,
    M.mod.git_diff
  },
  theme = M.themes.gruvbox,
}

function M.setup(config)
  config = config and next(config) and config or M.default_config
  M.lib:create_status_highlight_groups(config.theme)
  if config.statusline then
    vim.opt.statusline = M.lib:parse_config(config.statusline)
  end
  if config.winbar then
    vim.opt.winbar = M.lib:parse_config(config.winbar)
  end
end

return M
