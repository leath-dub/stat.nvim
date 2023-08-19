# stat.nvim
Another statusline ? - this statusline is a personal pursuit in a less bloated
option.

# About
Currently it is ~ 300 LOC long. This makes it a less daunting read as it is
very simple, feel free to use this as a base for your own statusline or plugin.

Laziness was the big motivator for this project, I could not be bothered
reading the source of a standard statusline plugin these days.

default config:

![default_config](https://user-images.githubusercontent.com/77889270/210636551-fa314b64-67fd-4954-8c23-dfdd80353533.png)


# Features
- winbar and statusline customization
- allows low level customization ( for those who have their own custom statusline )
- abstraction over highlight groups ( the theme )

# Installation
Refer to your plugin manager ( I recommend [dep](https://github.com/chiyadev/dep) )

# Configuration
__NOTE__ you should probably make sure that you call ``setup()`` after your
colorscheme plugin is loaded ( you can add stat.nvim it as a dependency of your
colorscheme in your prefered plugin manager )

Here is the default config:
```lua
local ___ = Stat.___
require("stat").setup({
  winbar = {
    ___,
    Stat.mod.file()
  },
  statusline = {
    ___,
    Stat.mod.mode,
    Stat.mod.filetype,
    Stat.mod.git_diff
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
})
```

The ``theme`` field can be a table like above or a table (array) of tables, this means
you can utilize the default themes (see lua/themes directory) along side other definitions
of themes (themes are just sets of highlight group definitions), e.g

```lua
theme = {
    ["MyHighlight"] = { fg = "#000000" },
}
-- Or you can do this
theme = {
    Stat.themes.rose_pine_moon,
    ["MyHighlight"] = { fg = "#000000" },
    { -- nest multiple
        ["MyHighlight2"] = { bg = "#FFFFFF" },
        ["ElectricBoogaloo"] = { fg = "#000000", bg ="#FFFFFF" },
    },
}
```

The basic idea is that you can provide **functions**, **strings** or **tables**
to ``winbar`` and ``statusline`` fields. Any builtin functions are of form
``Stat.mod.[function]``, however you can implement your own functions like
so:
```lua
function current_bufnr()
  local bufnr = vim.api.nvim_get_current_buf()
  return Stat.lib.set_highlight("MyHighlight", tostring(bufnr))
end
```
Any functions must take 0 arguments ( or must be able to run with none ) and
return a **string**. The function above also
applys the "MyHighlight" highlight group which would need to be defined in the
``theme`` field of the config.

## More Usage

check out the examples/

## Alignment
If you want to evenly space sections of your statusline you can use the
builtin ``Stat.___``(oof thats ugly :> maybe set ``local ___ = Stat.___`` ?).
If you put it before any sections, like in the default config, it will have the
effect of right justifying the items ( I would play around with this to understand
it fully, also refer to ``:help statusline`` in neovim )

As well as this you can set minimum and maximum widths of your modules, to do
so you must, rather than provide a string or function directly, wrap your
string/function in a table e.g:

```lua
statusline = {
  "Unwrapped section",
  {
    minwid = 0,
    maxwid = 5,
    "Wrapped section" -- Will be truncated as its length is more than 5
  },
  {
    left_justify = true, -- default is right justify
    minwid = 50, -- section length 50
    "I am not 50 characters!", -- left justify this in 50 character section
  }
}
```

Also if you add more than one function or string in a table, the contents will
be "grouped", this means that when using alignment with ``Stat.___`` that
section will be kept together.

## Raw
For those who have read ``:help statusline``, you may find it useful that you
can set "raw strings" ( they will not be wrapped or changed by stat.nvim ),
this allows you to easily use the builtin vim statusline codes, with least
runtime overhead ( no functions are called from stat.nvim it is literally a
component of the ``vim.opt.statusline`` variable directly )

To do this you can do the following:
```lua
statusline = {
  { raw = true, value = " %f " }, -- raw text " %f " will go directly in statusline
  "More non raw stuff as before"
}
```

## Themes

If you want to add a theme, make a pr (it needs to go in the lua/themes directory)
