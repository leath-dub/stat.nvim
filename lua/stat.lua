local M = {}

-- global for module
__Stat__ = M

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
    M.mod.filetype
  },
  theme = {
    ["N"] = { fg = "#2d353b", bg = "#83c092" },
    ["I"] = { fg = "#2d353b", bg = "#7fbbb3" },
    ["V"] = { fg = "#2d353b", bg = "#dbbc7f" },
    ["C"] = { fg = "#2d353b", bg = "#d699b6" },
    ["T"] = { fg = "#2d353b", bg = "#a7c080" },
    ["S"] = { fg = "#2d353b", bg = "#e67e80" },
    ["File"] = { fg = "#d3c6aa", bg = "#343f44" },
    ["Filetype"] = { fg = "#d3c6aa", bg = "#232a2e" }
  }
}

function M.setup(config)
  local config = config or M.default_config
  M.lib:create_status_highlight_groups(config.theme)
  vim.opt.statusline = M.lib:parse_config(config.statusline)
  vim.opt.winbar = M.lib:parse_config(config.winbar)
end

return M


times in msec
 clock   self+sourced   self:  sourced script
 clock   elapsed:              other lines

000.014  000.014: --- NVIM STARTING ---
000.151  000.137: event init
000.294  000.143: early init
000.375  000.081: locale set
000.424  000.049: init first window
000.888  000.464: inits 1
000.909  000.021: window checked
000.917  000.008: parsing arguments
001.745  000.141  000.141: require('vim.shared')
001.955  000.077  000.077: require('vim._meta')
001.961  000.209  000.132: require('vim._editor')
001.966  000.418  000.068: require('vim._init_packages')
001.971  000.636: init lua interpreter
002.039  000.068: expanding arguments
002.111  000.072: inits 2
002.586  000.475: init highlight
002.590  000.004: waiting for UI
004.338  001.749: done waiting for UI
004.361  000.023: init screen for UI
004.626  000.265: init default mappings
004.649  000.023: init default autocommands
005.386  000.095  000.095: sourcing /usr/share/nvim/runtime/ftplugin.vim
005.482  000.050  000.050: sourcing /usr/share/nvim/runtime/indent.vim
006.388  000.543  000.543: require('bootstrap')
008.494  000.331  000.331: require('dep.log')
008.727  000.221  000.221: require('dep.proc')
008.797  002.401  001.849: require('dep')
011.001  000.084  000.084: sourcing /home/cathal/.local/share/nvim/site/pack/deps/opt/vim-hexokinase/autoload/hexokinase/v2.vim
011.313  001.077  000.993: sourcing /home/cathal/.local/share/nvim/site/pack/deps/opt/vim-hexokinase/plugin/hexokinase.vim
013.874  000.369  000.369: sourcing /home/cathal/.local/share/nvim/site/pack/deps/opt/undotree/plugin/undotree.vim
020.220  000.356  000.356: require('vim.lsp.log')
021.719  000.015  000.015: require('vim.F')
021.729  001.495  001.480: require('vim.lsp.protocol')
025.578  001.104  001.104: require('vim.lsp._snippet')
025.866  000.275  000.275: require('vim.highlight')
025.899  004.165  002.786: require('vim.lsp.util')
025.925  007.001  000.985: require('vim.lsp.handlers')
026.815  000.886  000.886: require('vim.lsp.rpc')
027.308  000.486  000.486: require('vim.lsp.sync')
028.469  001.151  001.151: require('vim.lsp.buf')
028.856  000.377  000.377: require('vim.lsp.diagnostic')
029.300  000.438  000.438: require('vim.lsp.codelens')
029.456  014.028  003.690: require('vim.lsp')
029.565  014.895  000.867: sourcing /home/cathal/.local/share/nvim/site/pack/deps/opt/nvim-lspconfig/plugin/lspconfig.lua
031.166  000.842  000.842: require('lspconfig.util')
031.182  001.328  000.486: require('lspconfig.configs')
031.190  001.432  000.104: require('lspconfig')
031.306  000.109  000.109: require('lspconfig.server_configurations.pylsp')
031.648  000.178  000.178: require('lspconfig.server_configurations.rust_analyzer')
031.918  000.140  000.140: require('lspconfig.server_configurations.sumneko_lua')
033.193  000.094  000.094: require('lspconfig.server_configurations.ccls')
034.045  000.217  000.217: require('lspconfig.server_configurations.denols')
034.974  000.123  000.123: require('lspconfig.server_configurations.gopls')
036.632  000.845  000.845: require('cmp.utils.api')
036.783  000.088  000.088: require('cmp.types.cmp')
037.432  000.353  000.353: require('cmp.utils.misc')
037.467  000.678  000.325: require('cmp.types.lsp')
037.516  000.043  000.043: require('cmp.types.vim')
037.522  000.881  000.072: require('cmp.types')
037.634  000.108  000.108: require('cmp.utils.highlight')
037.831  000.061  000.061: require('cmp.utils.debug')
037.846  000.206  000.145: require('cmp.utils.autocmd')
038.334  002.715  000.675: sourcing /home/cathal/.local/share/nvim/site/pack/deps/opt/nvim-cmp/plugin/cmp.lua
040.702  000.250  000.250: require('cmp.utils.char')
040.727  000.566  000.316: require('cmp.utils.str')
040.819  000.086  000.086: require('cmp.utils.pattern')
041.535  000.073  000.073: require('cmp.utils.buffer')
041.554  000.556  000.482: require('cmp.utils.keymap')
041.568  000.744  000.188: require('cmp.utils.feedkeys')
041.833  000.261  000.261: require('cmp.utils.async')
042.140  000.113  000.113: require('cmp.utils.cache')
042.150  000.311  000.198: require('cmp.context')
043.781  000.311  000.311: require('cmp.config.mapping')
044.261  000.300  000.300: require('cmp.config.compare')
044.267  000.439  000.139: require('cmp.config.default')
044.293  001.365  000.616: require('cmp.config')
045.224  000.263  000.263: require('cmp.matcher')
045.239  000.941  000.678: require('cmp.entry')
045.250  003.095  000.789: require('cmp.source')
045.584  000.074  000.074: require('cmp.utils.event')
046.131  000.359  000.359: require('cmp.utils.window')
046.139  000.549  000.191: require('cmp.view.docs_view')
046.705  000.562  000.562: require('cmp.view.custom_entries_view')
047.103  000.393  000.393: require('cmp.view.wildmenu_entries_view')
047.312  000.199  000.199: require('cmp.view.native_entries_view')
047.385  000.071  000.071: require('cmp.view.ghost_text_view')
047.397  002.143  000.296: require('cmp.view')
047.572  008.405  001.200: require('cmp.core')
047.687  000.029  000.029: require('cmp.config.sources')
047.715  000.024  000.024: require('cmp.config.window')
047.749  009.251  000.793: require('cmp')
048.461  000.027  000.027: sourcing /home/cathal/.local/share/nvim/site/pack/deps/opt/plenary.nvim/plugin/plenary.vim
049.000  000.007  000.007: require('vim.keymap')
049.044  000.222  000.215: sourcing /home/cathal/.local/share/nvim/site/pack/deps/opt/telescope.nvim/plugin/telescope.lua
049.445  000.044  000.044: require('telescope._extensions')
049.449  000.350  000.306: require('telescope')
050.402  000.144  000.144: require('plenary.bit')
050.453  000.048  000.048: require('plenary.functional')
050.472  000.012  000.012: require('ffi')
050.483  000.714  000.510: require('plenary.path')
050.489  000.842  000.128: require('plenary.strings')
050.513  000.021  000.021: require('telescope.deprecated')
050.983  000.206  000.206: require('plenary.log')
051.005  000.245  000.039: require('telescope.log')
051.550  000.277  000.277: require('plenary.job')
051.585  000.031  000.031: require('telescope.state')
051.592  000.584  000.276: require('telescope.utils')
051.598  001.082  000.253: require('telescope.sorters')
051.656  000.051  000.051: require('vim.inspect')
052.734  003.282  001.285: require('telescope.config')
054.205  000.077  000.077: sourcing /home/cathal/.local/share/nvim/site/pack/deps/opt/everforest/autoload/everforest.vim
058.077  000.019  000.019: sourcing /home/cathal/.local/share/nvim/site/pack/deps/opt/everforest/after/syntax/text/everforest.vim
058.095  003.995  003.898: sourcing /home/cathal/.local/share/nvim/site/pack/deps/opt/everforest/colors/everforest.vim
058.247  000.060  000.060: sourcing /home/cathal/.local/share/nvim/site/pack/deps/opt/vim-hexokinase/autoload/hexokinase/v2/scraper.vim
058.390  000.060  000.060: sourcing /home/cathal/.local/share/nvim/site/pack/deps/opt/vim-hexokinase/autoload/hexokinase/utils.vim
060.706  000.107  000.107: require('lib')
060.898  000.169  000.169: require('mod')
060.909  000.674  000.398: require('stat')
062.664  000.141  000.141: require('nvim-treesitter.utils')
064.695  000.064  000.064: require('vim.treesitter.language')
064.709  000.347  000.282: require('vim.treesitter.query')
064.946  000.235  000.235: require('vim.treesitter.languagetree')
064.993  000.923  000.342: require('vim.treesitter')
065.091  002.420  001.497: require('nvim-treesitter.parsers')
065.892  000.198  000.198: require('nvim-treesitter.ts_utils')
065.898  000.289  000.091: require('nvim-treesitter.tsrange')
065.935  000.035  000.035: require('nvim-treesitter.caching')
065.943  000.511  000.188: require('nvim-treesitter.query')
065.953  000.750  000.239: require('nvim-treesitter.configs')
065.957  000.863  000.113: require('nvim-treesitter.info')
066.094  000.135  000.135: require('nvim-treesitter.shell_command_selectors')
066.118  004.197  000.639: require('nvim-treesitter.install')
066.159  000.038  000.038: require('nvim-treesitter.statusline')
066.256  000.094  000.094: require('nvim-treesitter.query_predicates')
066.259  004.702  000.373: require('nvim-treesitter')
066.518  005.016  000.313: sourcing /home/cathal/.local/share/nvim/site/pack/deps/opt/nvim-treesitter/plugin/nvim-treesitter.lua
067.384  000.083  000.083: require('nvim-treesitter.highlight')
068.655  000.201  000.201: require('vim.treesitter.highlighter')
068.688  000.916  000.715: require('treesitter-context')
068.692  000.933  000.016: sourcing /home/cathal/.local/share/nvim/site/pack/deps/opt/nvim-treesitter-context/plugin/treesitter-context.vim
069.305  000.038  000.038: require('mason-core.path')
069.315  000.090  000.052: require('mason.settings')
069.539  000.092  000.092: require('mason-core.functional')
069.650  000.029  000.029: require('mason-core.functional.data')
069.655  000.106  000.077: require('mason-core.functional.function')
069.694  000.030  000.030: require('mason-core.functional.relation')
069.735  000.035  000.035: require('mason-core.functional.logic')
069.745  000.428  000.166: require('mason-core.platform')
069.748  000.822  000.305: require('mason')
069.978  000.109  000.109: require('mason-core.functional.list')
069.993  000.236  000.127: require('mason.api.command')
070.670  000.135  000.135: require('mason-core.log')
070.675  000.496  000.361: require('mason-lspconfig')
070.699  000.022  000.022: require('mason-lspconfig.settings')
070.785  000.020  000.020: require('mason-core.notify')
070.789  000.087  000.068: require('mason-lspconfig.lspconfig_hook')
070.951  000.064  000.064: require('mason-core.functional.table')
070.994  000.198  000.135: require('mason-lspconfig.mappings.server')
071.346  000.167  000.167: require('mason-core.async')
071.381  000.026  000.026: require('mason-core.async.uv')
071.387  000.332  000.138: require('mason-core.fs')
071.451  000.061  000.061: require('mason-core.optional')
071.502  000.049  000.049: require('mason-core.EventEmitter')
071.685  000.181  000.181: require('mason-registry.index')
071.699  000.702  000.080: require('mason-registry')
071.722  000.019  000.019: require('mason-lspconfig.server_config_extensions')
071.823  000.098  000.098: require('lspconfig.server_configurations.omnisharp')
072.024  000.033  000.033: require('mason-core.functional.number')
072.047  000.172  000.139: require('mason-lspconfig.api.command')
077.676  072.084  020.984: require('plugin')
078.384  000.281  000.281: sourcing /usr/share/nvim/runtime/filetype.lua
078.410  000.012  000.012: sourcing /usr/share/nvim/runtime/filetype.vim
078.499  000.006  000.006: sourcing /usr/share/nvim/runtime/ftplugin.vim
078.670  000.985  000.685: require('setting')
078.891  000.217  000.217: require('keymap')
078.914  000.019  000.019: require('globals')
078.917  073.359  000.054: sourcing /home/cathal/.config/nvim/init.lua
078.923  000.769: sourcing vimrc file(s)
079.089  000.076  000.076: sourcing /usr/share/nvim/runtime/syntax/synload.vim
079.238  000.299  000.223: sourcing /usr/share/nvim/runtime/syntax/syntax.vim
079.473  000.019  000.019: sourcing /home/cathal/.local/share/nvim/site/pack/deps/opt/nvim-treesitter-context/plugin/treesitter-context.vim
079.635  000.029  000.029: sourcing /home/cathal/.local/share/nvim/site/pack/deps/opt/plenary.nvim/plugin/plenary.vim
079.732  000.010  000.010: sourcing /home/cathal/.local/share/nvim/site/pack/deps/opt/undotree/plugin/undotree.vim
079.811  000.007  000.007: sourcing /home/cathal/.local/share/nvim/site/pack/deps/opt/vim-hexokinase/plugin/hexokinase.vim
080.147  000.142  000.142: sourcing /usr/share/nvim/runtime/plugin/gzip.vim
080.166  000.006  000.006: sourcing /usr/share/nvim/runtime/plugin/health.vim
080.529  000.137  000.137: sourcing /usr/share/nvim/runtime/pack/dist/opt/matchit/plugin/matchit.vim
080.592  000.417  000.281: sourcing /usr/share/nvim/runtime/plugin/matchit.vim
080.701  000.099  000.099: sourcing /usr/share/nvim/runtime/plugin/matchparen.vim
080.965  000.253  000.253: sourcing /usr/share/nvim/runtime/plugin/netrwPlugin.vim
081.087  000.007  000.007: sourcing /home/cathal/.local/share/nvim/rplugin.vim
081.093  000.106  000.099: sourcing /usr/share/nvim/runtime/plugin/rplugin.vim
081.150  000.046  000.046: sourcing /usr/share/nvim/runtime/plugin/shada.vim
081.187  000.014  000.014: sourcing /usr/share/nvim/runtime/plugin/spellfile.vim
081.299  000.078  000.078: sourcing /usr/share/nvim/runtime/plugin/tarPlugin.vim
081.374  000.057  000.057: sourcing /usr/share/nvim/runtime/plugin/tohtml.vim
081.399  000.011  000.011: sourcing /usr/share/nvim/runtime/plugin/tutor.vim
081.519  000.109  000.109: sourcing /usr/share/nvim/runtime/plugin/zipPlugin.vim
081.692  000.038  000.038: sourcing /home/cathal/.local/share/nvim/site/pack/deps/opt/nvim-treesitter/plugin/nvim-treesitter.lua
081.892  000.121  000.121: sourcing /home/cathal/.local/share/nvim/site/pack/deps/opt/telescope.nvim/plugin/telescope.lua
082.033  000.067  000.067: sourcing /home/cathal/.local/share/nvim/site/pack/deps/opt/nvim-cmp/plugin/cmp.lua
082.184  000.108  000.108: sourcing /home/cathal/.local/share/nvim/site/pack/deps/opt/nvim-lspconfig/plugin/lspconfig.lua
082.472  000.050  000.050: sourcing /usr/share/nvim/runtime/plugin/man.lua
082.485  001.476: loading rtp plugins
082.562  000.077: loading packages
083.312  000.294  000.294: require('cmp_path')
083.386  000.381  000.087: sourcing /home/cathal/.local/share/nvim/site/pack/deps/opt/cmp-path/after/plugin/cmp_path.lua
083.726  000.118  000.118: require('cmp_nvim_lsp.source')
083.730  000.260  000.142: require('cmp_nvim_lsp')
083.761  000.304  000.044: sourcing /home/cathal/.local/share/nvim/site/pack/deps/opt/cmp-nvim-lsp/after/plugin/cmp_nvim_lsp.lua
084.020  000.199  000.199: require('cmp_cmdline')
084.059  000.248  000.049: sourcing /home/cathal/.local/share/nvim/site/pack/deps/opt/cmp-cmdline/after/plugin/cmp_cmdline.lua
084.564  000.070  000.070: require('cmp_buffer.timer')
084.569  000.267  000.197: require('cmp_buffer.buffer')
084.572  000.393  000.126: require('cmp_buffer.source')
084.576  000.453  000.060: require('cmp_buffer')
084.587  000.475  000.022: sourcing /home/cathal/.local/share/nvim/site/pack/deps/opt/cmp-buffer/after/plugin/cmp_buffer.lua
084.589  000.620: loading after plugins
084.599  000.010: inits 3
086.252  001.653: reading ShaDa
086.298  000.046: opening buffers
086.337  000.038: BufEnter autocommands
086.340  000.003: editing files in windows
086.880  000.540: VimEnter autocommands
086.885  000.005: UIEnter autocommands
086.889  000.003: before starting main loop
087.496  000.607: first screen update
087.501  000.006: --- NVIM STARTED ---
