vim.g["mapleader"] = " " -- set leader key
local seeded = false

local function nnoremap(lhs, rhs)
    vim.api.nvim_set_keymap("n", lhs, rhs, { noremap = true, silent = true })
end

local function nmap(lhs, rhs)
    vim.api.nvim_set_keymap("n", lhs, rhs, {})
end

local function vnoremap(lhs, rhs)
    vim.api.nvim_set_keymap("v", lhs, rhs, { noremap = true })
end

local function imap(lhs, rhs)
    vim.api.nvim_set_keymap("i", lhs, rhs, {})
end

function random_color()
    if not seeded then
        math.randomseed(os.time())
        for _ = 0, 3, 1
        do
            math.random()
        end
        seeded = true
    end
    local colors = vim.fn.getcompletion("", "color")
    local clen = #colors
    local r = math.random(clen)
    local choice = colors[r]
    vim.cmd("color " .. choice)
    print(choice)
end

nnoremap("<TAB>", ":bnext<CR>")
nnoremap("<S-TAB>", ":bprevious<CR>")
nnoremap("Y", "y$")
nnoremap("<C-\\>", ":vsplit <CR>")
nnoremap("<leader><CR>", ":split<CR>")
nnoremap("<leader>m", ":MaximizerToggle <CR>")
nnoremap("mm", ":lua random_color() <CR>")

-- Split Navigation Mappings

nnoremap("<M-h>", "<C-w>h")
nnoremap("<M-j>", "<C-w>j")
nnoremap("<M-k>", "<C-w>k")
nnoremap("<M-l>", "<C-w>l")

nmap("<leader>fn", ":Files ~/.config/nvim/<CR>")
nmap("<leader>fs", ":Files<CR>")
nmap("<leader>fo", ":Buffers<CR>")
nmap("<leader>fg", ":Rg <CR>")
nmap("<leader>fh", ":Helptags <CR>")

-- Better tabbing

vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- Helps Moving Text Up and Down

vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

imap("<C-BS>", "<C-w>")
imap("<C-h>", "<C-w>")

vim.cmd("autocmd BufRead,BufNewFile *.txt nmap <CR> :wq <CR>")
-- vim.cmd("autocmd BufWritePre * :%s/\\s\\+$//e")
vim.cmd("autocmd BufRead,BufNewFile .zshrc set filetype=bash")
vim.cmd("autocmd BufRead,BufNewFile *.html set noexpandtab")

-- Clipboard
vim.cmd('noremap <Leader>y "+y')
vim.cmd('noremap <Leader>p "+p')
