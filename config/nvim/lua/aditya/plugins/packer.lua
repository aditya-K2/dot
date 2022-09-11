vim.cmd [[ packadd packer.nvim ]]

return require("packer").startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'lewis6991/impatient.nvim'
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'L3MON4D3/LuaSnip'
    -- use 'saadparwaiz1/cmp_luasnip'
    use { 'rrethy/vim-hexokinase', run = 'make hexokinase' }

    use 'tpope/vim-commentary'
    use 'mattn/emmet-vim'

    -- Telescope
    use 'nvim-telescope/telescope.nvim'

    -- Color Schemes
    -- use 'mhartington/oceanic-next'
    -- use 'navarasu/onedark.nvim'
    -- use 'folke/tokyonight.nvim'
    -- use 'chriskempson/base16-vim'
    -- use 'tomasiser/vim-code-dark'
    -- use 'Mofiqul/vscode.nvim'
    -- use "rebelot/kanagawa.nvim"
    -- use 'Soares/base16.nvim'
    use 'chriskempson/base16-vim'
    -- use {"ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
    -- use 'ishan9299/nvim-solarized-lua'
    -- use 'davidosomething/vim-colors-meh'
    -- use 'Shatur/neovim-ayu'

    -- use 'mhinz/vim-startify'
    -- use 'nvim-lualine/lualine.nvim'
    -- use 'kyazdani42/nvim-web-devicons'

    -- use 'easymotion/vim-easymotion'

    use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install'}
    use 'mzlogin/vim-markdown-toc'

    use 'fatih/vim-go'

    -- Tree Sitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-treesitter/playground'

    -- Lsp
    use 'neovim/nvim-lspconfig'
    use 'ray-x/lsp_signature.nvim'

    -- Cmp
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'onsails/lspkind-nvim'

    use 'aditya-K2/spellfloat'
    use 'aditya-K2/termtoggle.nvim'

    --Maximizer
    use 'szw/vim-maximizer'
end)
