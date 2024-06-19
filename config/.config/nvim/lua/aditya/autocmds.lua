local format_group = vim.api.nvim_create_augroup("__aditya__format_group", { clear = true })
local notes = { "*/notes", "*/note" }

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
