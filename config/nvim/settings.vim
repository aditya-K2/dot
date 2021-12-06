syntax enable                           " Enables syntax highlighing
syntax on
set background=dark
set termguicolors     " enable true colors support
colorscheme base16-default-dark

set hidden                              " Required to keep multiple buffers open multiple buffers
set nowrap
set pumheight=10                        " Makes popup menu smaller
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set showtabline=2                       " Always show tabs
set noswapfile
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set formatoptions-=cro                  " Stop newline continution of comments
set clipboard=unnamedplus               " Copy paste between vim and everything else
set nu rnu
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set smartindent
set incsearch
set list lcs=eol:↲,tab:»\ ,trail:~
set nocompatible
set cursorline
set showtabline=2
set noshowmode
set completeopt=menuone,noinsert,noselect
set spelloptions=camel
set guifont=Source\ Code\ Pro:h8


" LSP Diagnostics

sign define DiagnosticSignError texthl=DiagnosticSignError text=>>
sign define DiagnosticSignWarn  texthl=DiagnosticSignWarn  text=
sign define DiagnosticSignInfo  texthl=DiagnosticSignInfo  text=
sign define DiagnosticSignHint  texthl=DiagnosticSignHint  text=

" Highlights
"
hi Comment gui=italic guifg=#464646
hi Normal guibg=#000000 gui=NONE
" hi Normal guibg=#15191a gui=NONE
hi ColorColumn guibg=#232323
hi TabLineFill guifg=#14191f
hi TabLineSel guifg=#2b3642 guibg=#eaeaea
hi LineNr guibg=NONE
hi CursorLine guibg=#212223
hi CursorLineNr guibg=#212223
hi EndOfBuffer guibg=#000000
hi SignColumn guibg=NONE
hi DiagnosticsDefaultError guibg=NONE
hi EndOfBuffer guibg=#000000

hi SpellBad guifg=#703435 gui=none
hi DiagnosticVirtualTextError guifg=#910b0b ctermbg=NONE gui=italic
hi DiagnosticVirtualTextWarn guifg=#ffa500 ctermbg=NONE gui=italic
hi DiagnosticVirtualTextHint guifg=#1d6a70 ctermbg=NONE gui=italic
hi DiagnosticSignError guifg=#910b0b
hi DiagnosticSignHint guifg=#1d6a70
" hi DiagnosticSignWarn
hi Pmenu guibg=#282f31
hi PmenuSel guibg=#aaaaff guifg=#000000
hi NonText guifg=#333436 gui=italic

" Globals

let &colorcolumn=join(range(120,999),",")
let g:user_emmet_leader_key=","
let g:user_emmet_mode="n"
let g:color_coded_enabled = 1
let g:floaterm_autoinsert=1
let g:floaterm_width=0.8
let g:floaterm_height=0.8
let g:floaterm_wintitle=0
let g:floaterm_autoclose=1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'minimalist'
let g:vimspector_enable_mappings = 'HUMAN'
