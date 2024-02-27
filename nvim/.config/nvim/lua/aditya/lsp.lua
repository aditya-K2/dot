local lspconfig = require('lspconfig')

local servers = {
    "clangd",
    "vimls",
    "pyright",
    "gopls",
    -- "lua_ls",
    "yamlls",
    "cssls",
    "html"
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    local opts = { noremap = true, silent = true }

    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
end

-- Merges rhs into lhs
local function merge(lhs, rhs)
    for k, v in pairs(rhs) do lhs[k] = v end
    return lhs
end

local default_setup = {
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    }
}

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local server_specific_configuration = {
    yamlls = {
        settings = {
            yaml = {
                schemas = {
                    ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] =
                    "/*.k8s.yaml",
                },
            },
        }
    },
    cssls = {
        capabilities = capabilities,
    },
    html = {
        capabilities = capabilities,
    },
    clangd = {
        cmd = {
            "clangd",
            "--enable-config"
        }
    }
}

local function configuration(lsp)
    local val = server_specific_configuration[lsp]
    if val == nil then
        val = {}
    end
    return val
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
for _, lsp in ipairs(servers) do
    local val = merge(default_setup, configuration(lsp))
    lspconfig[lsp].setup(val)
end

vim.diagnostic.config {
      virtual_text = true, float = {
        source = 'always',
        focusable = true,
        focus = false,
        pad_top = diagnostics_padding,
        pad_bottom = diagnostics_padding,
      }
    }
