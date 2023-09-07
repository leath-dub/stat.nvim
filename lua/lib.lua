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

return M
