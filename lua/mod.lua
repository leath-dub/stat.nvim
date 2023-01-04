local M = {}
local lib = __Stat__.lib -- TODO replace with "require call"

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
  return lib.set_highlight(mode, " " .. mode .. " ")
end

function M.filetype()
  filetype = string.upper(vim.bo.filetype)
  if filetype == "" then
    return ""
  end
  return lib.set_highlight("Filetype", " " .. filetype .. " ")
end

-- This can be a raw string, no need for expression as it is built into vim
function M.file()
  return {
    raw = true,
    value = lib.set_highlight("File", " %f ")
  }
end

-- LibLuv seems to always call "onread" with nil data even if there was chunks
-- previously( I assume its when it reaches EOF ). This means to distinguish
-- between "" and that nil that is by checking if we encounter 2 subsequent
-- nil values
local nnil = 0
local function onread(err, data)
  print(nnil)
  if data then
    nnil = 0 -- reset nnil if we get data
    local info = {}
    for n in string.gmatch(data, "(.)	") do
      table.insert(info, n)
    end
    M.git_diff_output = info
  elseif nnil >= 2 then
    M.git_diff_output = {}
  else
    nnil = nnil + 1
  end
end

M.git_diff_output = {}

-- shows insertions and deletions in current worktree file
function M.git_diff()
  local bufname = vim.api.nvim_buf_get_name(0)
  local stdout = vim.loop.new_pipe()
  local handle -- pre declaration neccesary
  handle = vim.loop.spawn("git", {
    args = {"diff", "--numstat", bufname},
    stdio = {nil, stdout, nil}
  },
  function(status)
    stdout:read_stop()
    stdout:close()
    handle:close()
  end)
  vim.loop.read_start(stdout, onread)
  return table.concat(M.git_diff_output, " ")
end

return M
