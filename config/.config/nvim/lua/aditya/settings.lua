-- Globals
vim.g["vscode_style"]           = "dark"
vim.g["user_emmet_leader_key"]  = ","
vim.g["user_emmet_mode"]        = "n"
vim.g["color_coded_enabled "]   = 1
vim.g["go_def_mapping_enabled"] = false
vim.g["fzf_preview_window"]     = {}
vim.g["fzf_layout"]             = { down = '15%' }

if vim.fn.has("wsl") == 1 then
    vim.cmd [[
        let g:clipboard = {
          \   'name': 'WslClipboard',
          \   'copy': {
          \      '+': 'clip.exe',
          \      '*': 'clip.exe',
          \    },
          \   'paste': {
          \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
          \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
          \   },
          \   'cache_enabled': 0,
          \ }
    ]]
end

vim.opt.background = "dark"
vim.opt.termguicolors = true

vim.cmd [[
    syntax enable
    color spacecamp
    syntax on
]]

local COLUMNS = 80
-- vim.opt.colorcolumn=vim.fn.join(vim.fn.range(COLUMNS, 999),",")
vim.opt.colorcolumn = { COLUMNS }
vim.opt.cmdheight = 1
vim.opt.hidden = true       -- Required to keep multiple buffers open multiple buffers
vim.opt.wrap = false
vim.opt.pumheight = 10      -- Makes popup menu smaller
vim.opt.splitbelow = true   -- Horizontal splits will automatically be below
vim.opt.splitright = true   -- Vertical splits will automatically be to the right
vim.opt.swapfile = false
vim.opt.showmode = false    -- We don't need to see things like -- INSERT -- anymore
vim.opt.backup = false      -- This is recommended by coc
vim.opt.writebackup = false -- This is recommended by coc
vim.opt.updatetime = 300    -- Faster completion
vim.opt.timeoutlen = 500    -- By default timeoutlen is 1000 ms
vim.opt.winbar = "%m %f"
vim.opt.rnu = true
vim.opt.nu = true
vim.opt.errorbells = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.incsearch = true
vim.opt.list = true
vim.opt.listchars = { eol = '↴', trail = '~', space = ".", tab = '▎ ' --[[,]] }
vim.opt.compatible = false
vim.opt.cursorline = true
vim.opt.showmode = false
vim.opt.completeopt = "menu"
vim.opt.spelloptions = "camel"
vim.opt.guifont = "Source Code Pro:h8"
vim.opt.expandtab = true
vim.opt.laststatus = 0
vim.cmd("set mouse=")

-- LSP Diagnostics

vim.cmd("sign define DiagnosticSignError texthl=DiagnosticSignError text=")
vim.cmd("sign define DiagnosticSignWarn  texthl=DiagnosticSignWarn  text=")
vim.cmd("sign define DiagnosticSignInfo  texthl=DiagnosticSignInfo  text=")
vim.cmd("sign define DiagnosticSignHint  texthl=DiagnosticSignHint  text=")

-- Highlights

vim.cmd("hi GitGutterChange guifg=#70bdf6")
vim.cmd("hi GitSignsChange guifg=#70bdf6")
vim.cmd("hi GitGutterDelete guifg=red")
vim.cmd("hi GitGutterAdd guifg=#00ff00")
vim.cmd("hi NonText guifg=#3b3b3b guibg=None")
vim.cmd("hi CursorLine  guibg=#232323")
