local M = {}

-- Adds highlight group infront of s
function M.set_highlight(name, s)
  if (not vim.api.nvim_get_hl_by_name("Normal", "")) or
     (not vim.api.nvim_get_hl_by_name("__Stat__" .. name, "")) then
    vim.api.nvim_err_writeln(
      "stat.nvim: the Normal highlight group is unset this is required by stat.nvim"
    )
    return nil
  end
  return string.format("%%#__Stat__%s#%%s%#Normal#", name, s)
end

M.lookup = {}
M.lookup._items = 1

function M.lookup._get(i)
  return M.lookup[i]
end

function M:create_status_item(fn)
  if not (type(fn) == "function") then
    item = function() return fn end
  else
    item = fn
  end
  self.lookup[self.lookup._items] = item
  self.lookup._items = self.lookup._items + 1
  return "%{%v:lua.__Stat__.lib.lookup._get(" .. string.format("%d", self.lookup._items - 1) .. ")()%}"
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
  for k, v in pairs(config) do
    if type(v) == "table" then
      if v.raw then -- allows user to add something directly to statusline
        result = result .. v.value
        goto __break__
      end
      local minmax = ""
      if v.minwid then minmax = minmax .. tostring(v.minwid) end
      if v.maxwid then minmax = minmax .. "." .. tostring(v.maxwid) end
      local group = {}
      for i, item in ipairs(v) do
        table.insert(group, self:create_status_item(item))
      end
      dash = ""
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
