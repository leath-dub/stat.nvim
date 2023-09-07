local M = {}

-- We store any anded' highlight groups here so that we don't keep creating redundant highlight groups at runtime

local hl_prefix = "__Stat__"
local hl_anon_id = 0

function M.get_hl_abs(name) -- return absolute highlight name
  return hl_prefix .. name
end

function M.set_hl(name)
  return ("%%#%s%s#"):format(hl_prefix, name)
end

function M.set_hl_abs(name)
  return ("%%#%s#"):format(name)
end

function M.unset_hl()
  return M.set_hl_abs("Normal")
end

function M.get_hl_val_abs(name)
  return vim.api.nvim_get_hl(0, { name = name })
end

local function hl_val_equal(hl_a, hl_b)
  if #hl_a ~= #hl_b then
    return false
  end

  for k, v in pairs(hl_a) do
    if hl_b[k] ~= v then
      return false
    end
  end

  return true
end

function M.add_margin(s, sz)
  local mg_right = ""
  local mg_left = ""

  if type(sz) == "table" then
    mg_left = (" "):rep(sz.left)
    mg_right = (" "):rep(sz.right)
  else
    mg_left = (" "):rep(sz)
    mg_right = (" "):rep(sz)
  end

  return mg_left .. s .. mg_right
end

local cached_hl_groups = {}
function M.set_hl_val_abs(val)
  local hl = {}

  -- Check if an identical highlight group
  for _, v in pairs(cached_hl_groups) do
    if hl_val_equal(v.val, val) then
      return v.name
    end
  end

  hl.name = hl_prefix .. "Anonymous" .. tostring(hl_anon_id)
  hl_anon_id = hl_anon_id + 1
  hl.val = val
  table.insert(cached_hl_groups, hl)

  vim.api.nvim_set_hl(0, hl.name, hl.val)

  return hl.name
end

-- Adds highlight group infront of s
function M.set_highlight(name, s, reset)
  if reset then
    return M.set_hl(name) .. s .. M.set_hl_abs("Normal")
  end
  return M.set_hl(name) .. s
end

M.lookup = {}
M.lookup._items = 1

function M.lookup._get(i)
  return M.lookup[i]
end

function M:create_status_item(fn)
  local item
  if not (type(fn) == "function") then
    item = function() return fn end
  else
    item = fn
  end
  self.lookup[self.lookup._items] = item
  self.lookup._items = self.lookup._items + 1
  return "%{%v:lua.Stat.lib.lookup._get(" .. string.format("%d", self.lookup._items - 1) .. ")()%}"
end

function M.create_status_highlight_group(name, val)
  vim.api.nvim_set_hl(0, "__Stat__" .. name, val)
end

function M:create_status_highlight_groups(groups)
  for k, v in pairs(groups) do
    self.create_status_highlight_group(k, v)
  end
end

function M:parse_config(config)
  local result = "%#Normal#"
  for _, v in pairs(config) do
    if type(v) == "table" then
      if v.raw then -- allows user to add something directly to statusline
        result = result .. v.value
        goto __break__
      end
      local minmax = ""
      if v.minwid then minmax = minmax .. tostring(v.minwid) end
      if v.maxwid then minmax = minmax .. "." .. tostring(v.maxwid) end
      local group = {}
      for _, item in ipairs(v) do
        table.insert(group, self:create_status_item(item))
      end
      local dash = ""
      if v.left_justify then dash = "-" end
      result = result .. string.format(
        "%%%s%s(%s%%)", dash, minmax, table.concat(group, v.separator or " ")
      )
    else
      result = result .. self:create_status_item(v)
    end
    ::__break__::
  end
  return result
end

function M.load_lualine_theme(theme_name)
  local path = table.concat { 'lua/lualine/themes/', theme_name, '.lua' }
  local files = vim.api.nvim_get_runtime_file(path, true)
  if #files <= 0 then
    path = table.concat { 'lua/lualine/themes/', theme_name, '/init.lua' }
    files = vim.api.nvim_get_runtime_file(path, true)
  end
  local retval = {}
  local n_files = #files
  if n_files == 0 then
    -- No match found
    error(path .. ' Not found')
  elseif n_files == 1 then
    -- when only one is found run that and return it's return value
    retval = dofile(files[1])
  else
    -- put entries from user config path in front
    local user_config_path = vim.fn.stdpath('config')
    table.sort(files, function(a, b)
      return vim.startswith(a, user_config_path) or not vim.startswith(b, user_config_path)
    end)
    -- More then 1 found . Use the first one that isn't in lualines repo
    local sep = package.config:sub(1, 1)
    local lualine_repo_pattern = table.concat({ 'lualine.nvim', 'lua', 'lualine' }, sep)
    local file_found = false
    for _, file in ipairs(files) do
      if not file:find(lualine_repo_pattern) then
        retval = dofile(file)
        file_found = true
        break
      end
    end
    if not file_found then
      -- This shouldn't happen but somehow we have multiple files but they
      -- appear to be in lualines repo . Just run the first one
      retval = dofile(files[1])
    end
  end
  return retval
end

function M.lualine(theme_name)
  local theme = M.load_lualine_theme(theme_name)
  for _, sections in pairs(theme) do
    for _, val in pairs(sections) do
      local gui_hl = val.gui
      if gui_hl ~= nil then
        val[gui_hl] = true
        val.gui = nil
      end
    end
  end
  return {
    ["N"] = theme.normal.a,
    ["I"] = theme.insert.a,
    ["V"] = theme.visual.a,
    ["C"] = theme.command.a,
    ["T"] = theme.command.a,
    ["S"] = theme.replace.a,
    ["File"] = theme.normal.b,
    ["Filetype"] = theme.normal.b,
    ["GitDiffDeletion"] = { link = "DiffDelete" },
    ["GitDiffInsertion"] = { link = "DiffAdd" },
  }
end

return M
