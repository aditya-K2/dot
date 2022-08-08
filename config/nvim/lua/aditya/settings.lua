-- Globals
vim.g["vscode_style"]="dark"
vim.g["user_emmet_leader_key"]               = ","
vim.g["user_emmet_mode"]                     = "n"
vim.g["color_coded_enabled "]                = 1
vim.g["floaterm_autoinsert"]                 = 1
vim.g["floaterm_width"]                      = 0.8
vim.g["floaterm_height"]                     = 0.8
vim.g["floaterm_wintitle"]                   = 0
vim.g["floaterm_autoclose"]                  = 1
vim.g["airline#extensions#tabline#enabled "] = 1
vim.g["airline_theme "]                      = 'minimalist'
vim.g["vimspector_enable_mappings "]         = 'HUMAN'
vim.g["go_def_mapping_enabled"]              = false
vim.g["oceanic_next_terminal_bold"] = 1
vim.g["oceanic_next_terminal_italic"] = 1
vim.g.tokyonight_style = "night"

vim.cmd [[
    syntax enable
    syntax on
    colorscheme ayu-dark
]]

vim.opt.background="dark"
vim.opt.termguicolors=true

vim.opt.colorcolumn=vim.fn.join(vim.fn.range(120, 999),",")
vim.opt.hidden = true                                       -- Required to keep multiple buffers open multiple buffers
vim.opt.wrap = false
vim.opt.pumheight = 10                                      -- Makes popup menu smaller
vim.opt.mouse="a"                                           -- Enable your mouse
vim.opt.splitbelow = true                                   -- Horizontal splits will automatically be below
vim.opt.splitright = true                                   -- Vertical splits will automatically be to the right
vim.opt.showtabline=2                                       -- Always show tabs
vim.opt.swapfile = false
vim.opt.showmode = false                                    -- We don't need to see things like -- INSERT -- anymore
vim.opt.backup = false                                      -- This is recommended by coc
vim.opt.writebackup = false                                 -- This is recommended by coc
vim.opt.updatetime=300                                      -- Faster completion
vim.opt.timeoutlen=500                                      -- By default timeoutlen is 1000 ms
vim.opt.clipboard="unnamedplus"                             -- Copy paste between vim and everything else
vim.opt.nu = true
vim.opt.rnu = true
vim.opt.errorbells = false
vim.opt.tabstop=4
vim.opt.softtabstop=4
vim.opt.shiftwidth=4
vim.opt.smartindent = true
vim.opt.incsearch = true
vim.opt.list = true
vim.opt.listchars = { eol = '↴', tab = '» ', trail = '~' --[[, space = "." ]] }
vim.opt.compatible = false
vim.opt.cursorline = true
vim.opt.showtabline=2
vim.opt.showmode = false
vim.opt.completeopt="menuone,noinsert,noselect"
vim.opt.spelloptions="camel"
vim.opt.guifont="Source Code Pro:h8"
vim.opt.expandtab=true
vim.opt.laststatus=3

-- LSP Diagnostics

vim.cmd("sign define DiagnosticSignError texthl=DiagnosticSignError text="  )
vim.cmd("sign define DiagnosticSignWarn  texthl=DiagnosticSignWarn  text="  )
vim.cmd("sign define DiagnosticSignInfo  texthl=DiagnosticSignInfo  text="  )
vim.cmd("sign define DiagnosticSignHint  texthl=DiagnosticSignHint  text="  )

-- Highlights

vim.cmd( "hi SpellBad guifg=#703435 gui=none " )
vim.cmd( "hi DiagnosticsDefaultError guibg=NONE " )
vim.cmd( "hi DiagnosticVirtualTextError guifg=#ff3939 ctermbg=NONE gui=italic " )
vim.cmd( "hi DiagnosticVirtualTextWarn guifg=#ffa500 ctermbg=NONE gui=italic " )
vim.cmd( "hi DiagnosticVirtualTextHint guifg=#1d6a70 ctermbg=NONE gui=italic " )
vim.cmd( "hi DiagnosticFloatingError guifg=#ff3939 ctermbg=NONE gui=italic " )
vim.cmd( "hi DiagnosticFloatingWarn guifg=#ffa500 ctermbg=NONE gui=italic " )
vim.cmd( "hi DiagnosticFloatingHint guifg=#1d6a70 ctermbg=NONE gui=italic " )
vim.cmd( "hi DiagnosticSignError guifg=#ff3939 " )
vim.cmd( "hi DiagnosticSignHint guifg=#1d6a70 " )
vim.cmd( "hi Normal guibg=NONE gui=NONE" )
vim.cmd( "hi LineNr guibg=NONE" )
vim.cmd( "hi SignColumn guibg=NONE" )
vim.cmd( "hi NonText guibg=NONE guifg=#535e5a" )
vim.cmd( "hi Pmenu guibg=#2e2b2b" )
-- vim.cmd( "hi Comment guifg=#4a4a4a" )
vim.cmd( "hi ColorColumn guibg=#001e26" )
vim.cmd( "hi CursorLine guibg=#1e1e1e" )
