local format_group = vim.api.nvim_create_augroup("__aditya__format_group", { clear = true })
local notes = { "*/notes", "*/note" }

vim.api.nvim_create_autocmd("BufEnter", {
    group = format_group,
    pattern = { "*.json" },
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

vim.api.nvim_create_autocmd({ "LspAttach" }, {
  pattern = { "*.c", "*.cpp", "*.h", "*.hpp", "*.cc", "*.cxx", "*.hh", "*.hxx" },
  callback = function()
    local pids = vim.fn.systemlist(
      [[ps aux | grep '[c]langd' | grep -v -- '--query-driver' | awk '{print $2}']]
    )
    if #pids > 0 then
      vim.fn.system("kill " .. table.concat(pids, " "))
      vim.notify("Killed extra clangd processes: " .. table.concat(pids, ", "), vim.log.levels.INFO)
    end
  end,
})

