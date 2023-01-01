local M = {}
local lib = __Stat__.lib

function M.mode()
  modes = {
    ["n"] = "N", ["no"] = "N", ["nov"] = "N", ["noV"] = "N",
    ["noCTRL-V"] = "N", ["niI"] = "N", ["niR"] = "N", ["niV"] = "N",
    ["nt"] = "N", ["ntT"] = "N", ["v"] = "V", ["vs"] = "V", ["V"] = "V",
    ["Vs"] = "V", ["CTRL-V"] = "V", ["CTRL-Vs"] = "V", ["s"] = "S", ["S"] = "S",
    ["CTRL-S"] = "S", ["i"] = "I", ["ic"] = "I", ["ix"] = "I", ["R"] = "R",
    ["Rc"] = "R", ["Rx"] = "R", ["Rvc"] = "R", ["Rvx"] = "R", ["c"] = "C",
    ["cv"] = "E", ["r"] = "N", ["rm"] = "N", ["r?"] = "N", ["!"] = "N",
    ["t"] = "T"
  }
  mode = modes[vim.api.nvim_get_mode().mode]
  -- return " " .. mode .. " "
  return lib.set_highlight(mode, " " .. mode .. " ")
end

function M.filetype()
  filetype = string.upper(vim.bo.filetype)
  return lib.set_highlight("Filetype", " " .. filetype .. " ")
end

-- This can be a raw string, no need for expression as it is built into vim
function M.file()
  return {
    raw = true,
    value = lib.set_highlight("File", " %f ")
  }
end

return M
