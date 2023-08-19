local M = {}

local function get(module_name)
  return require("stat.themes." .. module_name)
end

setmetatable(M, {
  __index = function(tbl, key)
    local success, result = pcall(get, key)
    if success then
      rawset(tbl, key, result)
      return result
    else
      return nil
    end
  end
})

return M

