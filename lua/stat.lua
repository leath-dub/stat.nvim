local M = {}

-- global for module
Stat = M

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
  theme = {
    ["N"] = { fg = "#2d353b", bg = "#83c092" },
    ["I"] = { fg = "#2d353b", bg = "#7fbbb3" },
    ["V"] = { fg = "#2d353b", bg = "#dbbc7f" },
    ["C"] = { fg = "#2d353b", bg = "#d699b6" },
    ["T"] = { fg = "#2d353b", bg = "#a7c080" },
    ["S"] = { fg = "#2d353b", bg = "#e67e80" },
    ["File"] = { fg = "#d3c6aa", bg = "#343f44" },
    ["Filetype"] = { fg = "#d3c6aa", bg = "#272e33" },
    ["GitDiffDeletion"] = { fg = "#e67e80", bg = "#232a2e" },
    ["GitDiffInsertion"] = { fg = "#a7c080", bg = "#232a2e" }
  }
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
