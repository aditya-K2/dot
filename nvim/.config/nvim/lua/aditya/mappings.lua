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

local function format_func(formatter)
    return function()
        if vim.api.nvim_buf_get_option(0, "modified") then
            local cpos  = vim.fn.getpos('.')
            local file = vim.fn.expand("%")
            vim.fn.jobstart({formatter, file}, {
              stdout_buffered = true,
              on_stdout = function(_, data)
                if data then
                  vim.api.nvim_buf_set_lines(0, 0, -1, false, data)
                  vim.fn.setpos('.', cpos)
                  vim.api.nvim_command("noautocmd write")
                end
          end})
        end
    end
end

local function format_buffer()
    vim.lsp.buf.format()
end

local format_group = vim.api.nvim_create_augroup("__aditya__format_group", {clear = true})
local fg_pattern = { "*.cpp" , "*.cc" }
local show_spaces = { "*.yaml", "*.py" }

vim.api.nvim_create_autocmd("BufEnter", {
    group = format_group,
    pattern = show_spaces,
    callback = function()
        vim.cmd("setlocal listchars+=space:.")
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    group = format_group,
    pattern = fg_pattern,
    callback = function()
        vim.api.nvim_buf_set_option(0, "tabstop", 2)
        vim.api.nvim_buf_set_option(0, "softtabstop", 2)
        vim.api.nvim_buf_set_option(0, "shiftwidth", 2)
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    group = format_group,
    pattern = { "*/waybar/config" },
    callback = function()
        vim.cmd("set filetype=jsonc")
    end
})

vim.api.nvim_create_autocmd("BufEnter", {
    group = format_group,
    pattern = { "*/notes", "*/note" },
    callback = function()
        vim.cmd("set filetype=markdown")
    end
})

vim.api.nvim_create_autocmd("BufEnter", {
    group = format_group,
    pattern = { "*.tf" },
    callback = function()
        vim.cmd("set filetype=hcl")
    end
})

nnoremap ("<TAB>" , ":bnext<CR>")
nnoremap ("<S-TAB>" , ":bprevious<CR>")
nnoremap ("Y" , "y$")
nnoremap ("<C-\\>" , ":vsplit <CR>")
nnoremap ("<leader><CR>" , ":split<CR>")
nnoremap ("<leader>fc" , "<cmd> lua require('telescope.builtin').find_files{cwd='/H/code', prompt='cpFiles'}<CR>")
nnoremap ("<leader>m" , ":MaximizerToggle <CR>")
nnoremap ("U", "<cmd>lua vim.diagnostic.open_float(0, { scope = \"line\" })<CR>")

-- nnoremap ("<S-m>"      , ":lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
-- nnoremap ("<M-m>"      , ":lua require('termtoggle').TermToggle()<CR>")

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

nmap ("<leader>fn" , ":Files ~/.config/nvim/<CR>")
nmap ("<leader>fs" , ":Files<CR>")
nmap ("<leader>fo" , ":Buffers<CR>")
nmap ("<leader>fg" , ":Rg <CR>")
nmap ("<leader>fh" , ":Telescope help_tags <CR>")

vim.api.nvim_set_keymap("i", "<C-BS>" , "<C-w>", {})
vim.api.nvim_set_keymap("i", "<C-h>" , "<C-w>", {})

-- Better tabbing

vnoremap ("<" , "<gv")
vnoremap (">" , ">gv")

-- Helps Moving Text Up and Down

vnoremap ("J" , ":m '>+1<CR>gv=gv")
vnoremap ("K" , ":m '<-2<CR>gv=gv")
