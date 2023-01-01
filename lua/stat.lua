local M = {}

M.lib = require("lib")
M.mod = require("mod")
M.___ = { raw = true, value = "%=" }

local ___ = M.___
local default_config = {
  winbar = {
    M.lib.file
  },
  statusline = {
    ___,
    M.lib.mode,
    M.lib.filetype
  },
  theme = {
    ["N"] = { fg = "bg", bg = "#83c092" },
    ["I"] = { fg = "bg", bg = "#7fbbb3" },
    ["V"] = { fg = "bg", bg = "#dbbc7f" },
    ["C"] = { fg = "bg", bg = "#d699b6" },
    ["T"] = { fg = "bg", bg = "#a7c080" },
    ["S"] = { fg = "bg", bg = "#e67e80" },
    ["File"] = { fg = "#d3c6aa", bg = "#343f44" },
    ["Filetype"] = { fg = "#d3c6aa", bg = "#232a2e" }
  }
}

function M.setup(config)
  local config = default_config
  M.lib.create_status_highlight_groups(config.theme)
  M.config.statusline = M.lib:parse_config(config.statusline)
  M.config.winbar = M.lib:parse_config(config.winbar)

  -- set the statusline and winbar
  vim.opt.statusline = M.config.statusline
  vim.opt.winbar = M.config.winbar
end

return M
