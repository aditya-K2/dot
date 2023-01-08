vim.g["mapleader"] = " "            -- set leader key

local function nnoremap(lhs, rhs)
    vim.api.nvim_set_keymap("n", lhs, rhs, {noremap = true, silent = true})
end

local function nmap(lhs, rhs)
    vim.api.nvim_set_keymap("n", lhs, rhs, {})
end

local function vnoremap(lhs, rhs)
    vim.api.nvim_set_keymap("v", lhs, rhs, {noremap = true})
end

local function ClangFormatBuffer()
    if vim.api.nvim_buf_get_option(0, "modified") then
        local cpos  = vim.fn.getpos('.')
        vim.cmd("%!clang-format")
        vim.fn.setpos('.', cpos)
    end
end

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.cpp" , "*.cc" },
    callback = ClangFormatBuffer,
})

nnoremap ("<TAB>" , ":bnext<CR>")
nnoremap ("<S-TAB>" , ":bprevious<CR>")
nnoremap ("Y" , "y$")
nnoremap ("<C-\\>" , ":vsplit <CR>")
nnoremap ("<leader><CR>" , ":split<CR>")
nnoremap ("<leader>fc" , "<cmd> lua require('telescope.builtin').find_files{cwd='/H/code', prompt='cpFiles'}<CR>")
nnoremap ("<leader>m" , ":MaximizerToggle <CR>")

-- nnoremap ("<S-m>"      , ":lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
nnoremap ("<M-m>"      , ":lua require('termtoggle').TermToggle()<CR>")

-- Split Mappings

nnoremap("<M-h>", "<C-w>h")
nnoremap("<M-j>", "<C-w>j")
nnoremap("<M-k>", "<C-w>k")
nnoremap("<M-l>", "<C-w>l")

vim.cmd( "autocmd BufRead,BufNewFile *.txt nmap <CR> :wq <CR>" )
vim.cmd( "autocmd BufWritePre * :%s/\\s\\+$//e" )
vim.cmd( "autocmd BufRead,BufNewFile .zshrc set filetype=bash" )
vim.cmd( "autocmd BufRead,BufNewFile *.html set noexpandtab")

vim.cmd( "autocmd BufRead,BufNewFile *.md set wrap" )
vim.cmd( "autocmd BufRead,BufNewFile *.md nnoremap <C-o> :call Spellfloat()<CR>" )
vim.cmd( "autocmd BufRead,BufNewFile *.md  nmap <leader>mm :!pandoc % -o output.pdf --highlight-style breezedark && zathura output.pdf &<CR>" )
vim.cmd( "autocmd BufRead,BufNewFile *.md nmap <leader>mc :!pandoc % -o output.pdf --highlight-style breezedark &<CR>" )

vim.cmd( "autocmd BufRead,BufNewFile *.latex set wrap" )
vim.cmd( "autocmd BufRead,BufNewFile *.latex nnoremap <C-o> :call Spellfloat()<CR>" )
vim.cmd( "autocmd BufRead,BufNewFile *.latex nmap <leader>mm :!compileLatex % <CR>" )
vim.cmd( "autocmd BufRead,BufNewFile *.latex nmap <leader>mc :!pdflatex -shell-escape % <CR>" )

nmap ("<leader>fn" , "<cmd> lua require('telescope.builtin').find_files{cwd='/home/aditya/.config/nvim', prompt='cpFiles'}<CR>")
nmap ("<leader>fs" , ":Telescope find_files <CR>")
nmap ("<leader>fg" , ":Telescope live_grep <CR>")
nmap ("<leader>fh" , ":Telescope help_tags <CR>")

vim.api.nvim_set_keymap("i", "<C-BS>" , "<C-w>", {})
vim.api.nvim_set_keymap("i", "<C-h>" , "<C-w>", {})

-- Better tabbing

vnoremap ("<" , "<gv")
vnoremap (">" , ">gv")

-- Helps Moving Text Up and Down

vnoremap ("J" , ":m '>+1<CR>gv=gv")
vnoremap ("K" , ":m '<-2<CR>gv=gv")
