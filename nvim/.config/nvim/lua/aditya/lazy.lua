local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    'tpope/vim-commentary',
    -- 'mattn/emmet-vim',
    { "lukas-reineke/indent-blankline.nvim", ft = { "yaml", "lua" } } ,

    -- Telescope
    -- { 'nvim-telescope/telescope.nvim', tag = '0.1.0', dependencies = { {'nvim-lua/plenary.nvim'} }, },
    { 'junegunn/fzf', build = function() vim.cmd('call fzf#install()') end},
    { 'junegunn/fzf.vim' },

    -- Color Schemes
    -- 'mhartington/oceanic-next',
    -- 'navarasu/onedark.nvim',
    -- 'folke/tokyonight.nvim',
    -- 'tomasiser/vim-code-dark',
    -- 'Mofiqul/vscode.nvim',
    -- 'projekt0n/github-nvim-theme',
    'RRethy/nvim-base16',
    -- "rebelot/kanagawa.nvim",
    -- {"ellisonleao/gruvbox.nvim", dependencies = {"rktjmp/lush.nvim"}},
    -- { "briones-gabriel/darcula-solid.nvim", dependencies = "rktjmp/lush.nvim" },
    -- {'shaunsingh/oxocarbon.nvim', branch = 'fennel'},
    -- 'ishan9299/nvim-solarized-lua',
    -- 'davidosomething/vim-colors-meh',
    -- 'Shatur/neovim-ayu',
    -- 'https://gitlab.com/madyanov/gruber.vim',
    -- 'aditya-K2/scruber.vim',
    -- 'vim/colorschemes',

    {'iamcco/markdown-preview.nvim', build = 'cd app && yarn install'},

    'fatih/vim-go',
    -- {'akinsho/flutter-tools.nvim', dependencies = 'nvim-lua/plenary.nvim',
    -- config = function()
    --     flutter_tools = true
    --     require("flutter-tools").setup{}
    -- end},

    -- Tree Sitter
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate',
    config = function()
        -- treesitter highlighting
        require'nvim-treesitter.configs'.setup {
            ensure_installed = {
                "go", "haskell",
                "typescript", "javascript", "html", "css",
                "java", "cpp", "c", "lua",
                "json", "jsonc",
                "python", "dart"
            },
            highlight = { enable = true } }
    end},
    { 'nvim-treesitter/playground', cmd = "TSPlaygroundToggle" },

    -- Lsp
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    -- 'ray-x/lsp_signature.nvim',

    -- Cmp
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-nvim-lsp',
    'onsails/lspkind-nvim',

    'aditya-K2/spellfloat',
    { 'aditya-K2/termtoggle.nvim', config = function()
        require('termtoggle').setup({bg="black"})
    end},
    'dstein64/vim-startuptime',

    --Maximizer
    'szw/vim-maximizer',
})
