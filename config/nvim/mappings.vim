function! CompileCPP()
	FloatermNew nvim input.txt && g++ % && ./a.out <input.txt >output.txt && nvim output.txt && rm output.txt input.txt
endfunction

function! OpenCheatSheat()
	split | resize -10 | term ch.sh
endfunction

function! OpenGoals()
	split | resize -10 | term glow ~/goals.md
endfunction

function! OpenInANewTmuxWindow()
	!tmux new-window nvim %
	bdel
endfunction

let g:mapleader = "\<Space>"            " set leader key

nnoremap <TAB> :bnext<CR>
nnoremap <S-TAB> :bprevious<CR>
nnoremap Y y$
nnoremap <C-\> :vsplit <CR>
nnoremap <leader><CR> :split<CR>
nnoremap <C-f> :NERDTreeToggle <CR>
nnoremap <leader>fc <cmd> lua require('telescope.builtin').find_files{cwd='/H/code', prompt='cpFiles'}<CR>
nnoremap <leader>m :MaximizerToggle <CR>

" Vim Spector Remaps
nnoremap <leader>dd : call vimspector#Launch()<CR>
nnoremap <leader>dc : call GotoWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dt : call GotoWindow(g:vimspector_session_windows.tabpage)<CR>
nnoremap <leader>dv : call GotoWindow(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>dw : call GotoWindow(g:vimspector_session_windows.watches)<CR>
nnoremap <leader>ds : call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>do : call GotoWindow(g:vimspector_session_windows.output)<CR>
nnoremap <leader>de : call vimspector#Reset()<CR>
nnoremap <leader>cs : call OpenCheatSheat() <CR>
nnoremap <M-m> : call TermToggle() <CR>
nnoremap <leader>cn : call OpenInANewTmuxWindow() <CR>
nnoremap <leader>ct :lua require("wordConverter").ConvertWord(vim.fn.expand("<cword>"), false)<CR>

nmap <leader>dj <Plug> VimspectorStepInto
nmap <leader>dk <Plug> VimspectorStepOver
nmap <leader>dl <Plug> VimspectorStepOut
nmap <leader>dr <Plug> VimspectorRestart
nnoremap <leader>d<space> :call vimspector#Continue()<CR>

nmap <leader> drc   <Plug>VimspectorRunToCursor
nmap <C-a> <Plug>VimspectorToggleBreakpoint
nmap <C-y> <Plug>VimspectorToggleBreakpoint
nmap <leader> dcbp  <Plug>VimspectorToggleConditionalBreakpoint

autocmd BufRead,BufNewFile *.cpp nmap <F6> :FloatermNew --autoclose=0 g++ % -o %< && ./%< <CR>
autocmd BufRead,BufNewFile *.cc nmap <F6> :FloatermNew --autoclose=0 g++ % -o %< && ./%< <CR>
autocmd BufRead,BufNewFile *.py nmap <F6> :FloatermNew --autoclose=0 python % <CR>
autocmd BufRead,BufNewFile *.c nmap <F6> :FloatermNew --autoclose=0 gcc % -o %< && ./%< <CR>
autocmd BufRead,BufNewFile *.txt nmap <CR> :wq <CR>
autocmd BufWritePre * :%s/\s\+$//e

autocmd BufRead,BufNewFile *.md set wrap
autocmd BufRead,BufNewFile *.md set spell spelllang=en_us
autocmd BufRead,BufNewFile *.md nnoremap <C-o> :call Spellfloat()<CR>
autocmd BufRead,BufNewFile *.md  nmap <leader>mm :!pandoc % -o output.pdf --highlight-style breezedark && zathura output.pdf &<CR>
autocmd BufRead,BufNewFile *.md nmap <leader>mc :!pandoc % -o output.pdf --highlight-style breezedark &<CR>

autocmd BufRead,BufNewFile *.latex set wrap
autocmd BufRead,BufNewFile *.latex set spell spelllang=en_us
autocmd BufRead,BufNewFile *.latex nnoremap <C-o> :call Spellfloat()<CR>
autocmd BufRead,BufNewFile *.latex nmap <leader>mm :!compileLatex % <CR>
autocmd BufRead,BufNewFile *.latex nmap <leader>mc :!pdflatex -shell-escape % <CR>
autocmd BufRead,BufNewFile *.hs set expandtab
autocmd BufRead,BufNewFile *def.h set expandtab

nmap <leader>fn <cmd> lua require('telescope.builtin').find_files{cwd='/home/aditya/.config/nvim', prompt='cpFiles'}<CR>
nmap <leader>fs :Telescope find_files <CR>
nmap <leader>fg :Telescope live_grep <CR>
nmap <leader>fh :Telescope help_tags <CR>
nmap <leader>fy :FloatermNew ncmpcpp  <CR>
nmap <leader>fi gg<CR>/int main()<CR> :read! cat /home/aditya/suckless/scripts/ifdef<CR>:noh<CR>
nmap <leader>fo :FloatermNew ranger /H/code <CR>
nmap <leader>ss :source /home/aditya/.config/nvim/init.vim <CR>:echo "Sourced init.vim" <CR>
nmap <leader>f<CR> :FloatermNew <CR>
nmap <F5> :call CompileCPP()<CR>

imap <C-BS> <C-w>
imap <C-h> <C-w>

"Better tabbing
vnoremap < <gv
vnoremap > >gv

tnoremap <M-m> <C-\><C-n>:call TermToggle()<CR>
