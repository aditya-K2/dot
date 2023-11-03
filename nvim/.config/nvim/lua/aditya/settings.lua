-- Globals
vim.g["vscode_style"]="dark"
vim.g["user_emmet_leader_key"]               = ","
vim.g["user_emmet_mode"]                     = "n"
vim.g["color_coded_enabled "]                = 1
vim.g["go_def_mapping_enabled"]              = false
vim.g["indent_blankline_filetype"]           = { "yaml", "lua" }
vim.g["fzf_preview_window"]                  = {}
vim.g["fzf_layout"]                          = { down = '15%' }

if vim.fn.has("wsl") then
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

vim.opt.background="dark"
vim.opt.termguicolors=true

vim.cmd [[
    syntax enable
    colorscheme base16-tomorrow-night
    syntax on
]]

COLUMNS = 80
-- vim.opt.colorcolumn=vim.fn.join(vim.fn.range(COLUMNS, 999),",")
vim.opt.colorcolumn={COLUMNS}
vim.opt.cmdheight=1
vim.opt.hidden = true                                       -- Required to keep multiple buffers open multiple buffers
vim.opt.wrap = false
vim.opt.pumheight = 10                                      -- Makes popup menu smaller
vim.opt.mouse="a"                                           -- Enable your mouse
vim.opt.splitbelow = true                                   -- Horizontal splits will automatically be below
vim.opt.splitright = true                                   -- Vertical splits will automatically be to the right
vim.opt.swapfile = false
vim.opt.showmode = false                                    -- We don't need to see things like -- INSERT -- anymore
vim.opt.backup = false                                      -- This is recommended by coc
vim.opt.writebackup = false                                 -- This is recommended by coc
vim.opt.updatetime=300                                      -- Faster completion
vim.opt.timeoutlen=500                                      -- By default timeoutlen is 1000 ms
vim.opt.clipboard="unnamedplus"                             -- Copy paste between vim and everything else
vim.opt.winbar="%m %f"
vim.opt.nu = true
vim.opt.errorbells = false
vim.opt.tabstop=4
vim.opt.softtabstop=4
vim.opt.shiftwidth=4
vim.opt.smartindent = true
vim.opt.incsearch = true
vim.opt.list = true
vim.opt.listchars = { eol = '↴', tab = '» ', trail = '~' --[[, space = "." ]] }
vim.opt.fillchars = { vert = '|', horiz = '-' }
vim.opt.compatible = false
vim.opt.cursorline = true
vim.opt.showmode = false
vim.opt.completeopt="menu"
vim.opt.spelloptions="camel"
vim.opt.guifont="Source Code Pro:h8"
vim.opt.expandtab=true
vim.opt.laststatus=3
-- vim.cmd("set mouse=")

-- LSP Diagnostics

vim.cmd("sign define DiagnosticSignError texthl=DiagnosticSignError text=>"  )
vim.cmd("sign define DiagnosticSignWarn  texthl=DiagnosticSignWarn  text=>"  )
vim.cmd("sign define DiagnosticSignInfo  texthl=DiagnosticSignInfo  text=>"  )
vim.cmd("sign define DiagnosticSignHint  texthl=DiagnosticSignHint  text=>"  )

-- Diagnostics Highlights

vim.cmd( "hi DiagnosticsDefaultError guibg=NONE " )
vim.cmd( "hi DiagnosticVirtualTextError guifg=#ff3939 ctermbg=NONE gui=italic " )
vim.cmd( "hi DiagnosticVirtualTextWarn guifg=#ffa500 ctermbg=NONE gui=italic " )
vim.cmd( "hi DiagnosticVirtualTextHint guifg=#1d6a70 ctermbg=NONE gui=italic " )
vim.cmd( "hi DiagnosticFloatingError guifg=#ff3939 ctermbg=NONE gui=italic " )
vim.cmd( "hi DiagnosticFloatingWarn guifg=#ffa500 ctermbg=NONE gui=italic " )
vim.cmd( "hi DiagnosticFloatingHint guifg=#1d6a70 ctermbg=NONE gui=italic " )
vim.cmd( "hi DiagnosticSignError guifg=#ff3939 " )
vim.cmd( "hi DiagnosticSignHint guifg=#1d6a70 " )

-- Highlights

vim.cmd( "hi Normal guibg=black" )
-- -- -- vim.cmd( "hi EndOfBuffer guibg=NONE" )
-- vim.cmd( "hi LineNr guifg=#65a616" )
-- vim.cmd( "hi CursorLineNr guifg=yellow guibg=None" )
-- -- vim.cmd( "hi SignColumn guibg=#262626" )
vim.cmd( "hi NonText guifg=#454545" )
-- -- vim.cmd( "hi Pmenu guibg=#262526" )
-- vim.cmd( "hi Comment guifg=grey gui=italic" )
-- -- -- vim.cmd( "hi Winbar guibg=#4e4e43" )
-- -- vim.cmd( "hi Statusline guibg=#1177aa guifg=white" )
-- -- vim.cmd( "hi WinbarNC guibg=#30302c" )
-- vim.cmd( "hi MatchParen guifg=black guibg=orange")
-- vim.cmd( "hi CursorLine guibg=#282f2d" )
-- -- vim.cmd( "hi CursorLineNr guibg=#111111" )
-- -- vim.cmd( "hi Visual guibg=#05233d" )
-- -- vim.cmd( "hi SpellBad guifg=#703435 gui=none " )
-- -- vim.cmd( "hi ColorColumn guibg=darkred" )
-- vim.cmd( "hi String guifg=#89b3d9" )
-- vim.cmd( "hi Identifier guifg=#ececec" )
-- -- vim.cmd( "hi Function guifg=#deb03e" )
-- vim.cmd( "hi @method.call guifg=#90fff0" )
-- -- vim.cmd("hi @parameter guibg=None guifg=grey")
-- vim.cmd( "hi WinSeparator guibg=None" )
