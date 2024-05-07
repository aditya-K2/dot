vim.g["mapleader"] = " " -- set leader key

local format_group = vim.api.nvim_create_augroup("__aditya__format_group", { clear = true })
local c_files = { "*.cpp", "*.cc", "*.c" }
local notes = { "*/notes", "*/note" }

vim.api.nvim_create_autocmd("BufEnter", {
    group = format_group,
    pattern = c_files,
    callback = function()
        vim.api.nvim_buf_set_option(0, "tabstop", 2)
        vim.api.nvim_buf_set_option(0, "softtabstop", 2)
        vim.api.nvim_buf_set_option(0, "shiftwidth", 2)
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    group = format_group,
    pattern = { "*/waybar/config", "config.json" },
    callback = function()
        vim.cmd("set filetype=jsonc")
    end
})

vim.api.nvim_create_autocmd("BufEnter", {
    group = format_group,
    pattern = notes,
    callback = function()
        vim.cmd("set filetype=markdown")
    end
})

vim.api.nvim_create_autocmd("TermOpen", {
    group = format_group,
    callback = function()
        vim.cmd("setlocal nonu nornu")
    end
})

-- Work around for mouse not working in the current Neovim
vim.api.nvim_create_autocmd("VimEnter", {
    group = format_group,
    callback = function()
        vim.cmd("set mouse=a")
    end
})

local function nnoremap(lhs, rhs)
    vim.api.nvim_set_keymap("n", lhs, rhs, { noremap = true, silent = true })
end

local function nmap(lhs, rhs)
    vim.api.nvim_set_keymap("n", lhs, rhs, {})
end

local function vnoremap(lhs, rhs)
    vim.api.nvim_set_keymap("v", lhs, rhs, { noremap = true })
end

nnoremap("<TAB>", ":bnext<CR>")
nnoremap("<S-TAB>", ":bprevious<CR>")
nnoremap("Y", "y$")
nnoremap("<C-\\>", ":vsplit <CR>")
nnoremap("<leader><CR>", ":split<CR>")
nnoremap("<leader>m", ":MaximizerToggle <CR>")

-- Split Navigation Mappings

nnoremap("<M-h>", "<C-w>h")
nnoremap("<M-j>", "<C-w>j")
nnoremap("<M-k>", "<C-w>k")
nnoremap("<M-l>", "<C-w>l")

-- Clipboard

nnoremap('<Leader>y','*y')
nnoremap('<Leader>p','*p')

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

vim.api.nvim_set_keymap("i", "<C-BS>", "<C-w>", {})
vim.api.nvim_set_keymap("i", "<C-h>", "<C-w>", {})

vim.cmd("autocmd BufRead,BufNewFile *.txt nmap <CR> :wq <CR>")
vim.cmd("autocmd BufWritePre * :%s/\\s\\+$//e")
vim.cmd("autocmd BufRead,BufNewFile .zshrc set filetype=bash")
vim.cmd("autocmd BufRead,BufNewFile *.html set noexpandtab")
