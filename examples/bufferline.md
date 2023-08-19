# Bufferline

Because `stat.nvim` trys to be as simple as possible it does not ship with a bufferline module (way to show buffers like tabs). However I did
create module for my own config that depends on [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons). This page will go through
the code and how to put it into your config.

## Setup

Firstly we need some way to get the current buffers, luckily this is a solved problem so much of the below code is ripped and modified from the
[telescope](https://github.com/nvim-telescope/telescope.nvim) source ( we love you teej <3 ).

```lua
local function get_buffers()
  local opts = {}
  -- Thanks to telescope source !
  local bufnrs = vim.tbl_filter(function(b)
    if 1 ~= vim.fn.buflisted(b) then
      return false
    end
    -- only hide unloaded buffers if opts.show_all_buffers is false, keep them listed if true or nil
    if opts.show_all_buffers == false and not vim.api.nvim_buf_is_loaded(b) then return false
    end
    if opts.ignore_current_buffer and b == vim.api.nvim_get_current_buf() then
      return false
    end
    if opts.cwd_only and not string.find(vim.api.nvim_buf_get_name(b), vim.loop.cwd(), 1, true) then
      return false
    end
    if not opts.cwd_only and opts.cwd and not string.find(vim.api.nvim_buf_get_name(b), opts.cwd, 1, true) then
      return false
    end
    return true
  end, vim.api.nvim_list_bufs())
  local buffers = {}
  for _, bufnr in ipairs(bufnrs) do
    local element = {
      bufnr = bufnr,
      info = vim.fn.getbufinfo(bufnr)[1],
    }
    table.insert(buffers, element)
  end
  return buffers
end
```

Then we need to use `stat.nvim`'s `lib` module to create a function that will return a string that will store the buffers one by one

```lua
local function buffer_line(stat)
  local utils = require("telescope.utils")
  local lib = stat.lib

  return function ()
    local res = ""
    local cwd = vim.fn.expand(vim.loop.cwd())
    local Path = require("plenary.path")
    for _, b in ipairs(get_buffers()) do
      local icon, hl_group = utils.get_devicons(b.info.name, false)
      local icon_width = vim.fn.strdisplaywidth(icon) + 1
      icon = icon .. (" "):rep(icon_width)

      local bufname = b.info.name ~= "" and b.info.name or "[No Name]"
      bufname = Path:new(bufname):normalize(cwd)

      if b.info.bufnr == vim.api.nvim_get_current_buf() then
        res = res .. lib.set_hl_abs(hl_group) .. lib.add_margin(icon .. lib.unset_hl() .. bufname, 1) .. lib.set_hl_abs("TabLineFill")
      else
        local bfr_line_hl = lib.get_hl_val_abs("TabLineFill")
        local new_hl = lib.set_hl_val_abs({ fg = lib.get_hl_val_abs(hl_group).fg, bg = bfr_line_hl.bg })
        res = res .. lib.set_hl_abs(new_hl) .. lib.add_margin(icon .. lib.set_hl_abs("TabLineFill") .. bufname, 1)
      end
    end
    return res
  end
end
```
**Note** The above function wraps an anonymous one, this allows us to do [dependency injection](https://en.wikipedia.org/wiki/Dependency_injection). This is useful as when we add it to our [lazy.nvim](https://github.com/folke/lazy.nvim) plugin definition we can actually ensure that stat is only required in the config function.

```lua
{
  "leath-dub/stat.nvim",
  event = "Colorscheme",
  config = function()
    local ok, stat = pcall(require, "stat")
    if not ok then
      return {}
    end
    local ___ = Stat.___
    stat.setup {
      winbar = {
        buffer_line(stat),
      },
      statusline = {
        ___,
        Stat.mod.mode,
        Stat.mod.filetype,
        Stat.mod.git_diff
      },
      theme = {
        stat.themes.rose_pine_moon,
      },
    }
  end
}
```

Finally we have the config, you can see why we used a wrapper previously as we lazy load `stat.nvim` on `Colorscheme` event - this is highly recommended as issues with highlighting and colors can happen

The result

![Buffer line](https://github.com/leath-dub/stat.nvim/blob/main/assets/bufferline.png?raw=true)
