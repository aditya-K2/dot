local lspkind = require "lspkind"
lspkind.init()
local cmp = require "cmp"

cmp.setup {
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.close(),
    ["<c-y>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },

    ["<c-space>"] = cmp.mapping.complete(),

  },

  sources = {
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "buffer" }
  },

  experimental = {
    -- the new menu
    native_menu = false,
    ghost_text = true,
  },
  formatting = {
    format = lspkind.cmp_format({with_text = true, maxwidth = 50})
  }
}
