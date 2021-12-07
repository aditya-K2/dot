  call plug#begin('~/.config/nvim/autoload/plugged')

		Plug 'tpope/vim-commentary'
		Plug 'mattn/emmet-vim'

		" Telescope
		Plug 'nvim-lua/popup.nvim'
		Plug 'nvim-lua/plenary.nvim'
		Plug 'nvim-telescope/telescope.nvim'
		Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

		" Color Schemes
		" Plug 'mhartington/oceanic-next'
		Plug 'chriskempson/base16-vim'
		" Plug 'navarasu/onedark.nvim'

		Plug 'nvim-lualine/lualine.nvim'
		Plug 'kyazdani42/nvim-web-devicons'
		" HOP
		Plug 'easymotion/vim-easymotion'

		Plug 'fatih/vim-go', {'do' : ':GoUpdateBinaries'}
		Plug 'lewis6991/impatient.nvim'

		" Float Term
		Plug 'voldikss/vim-floaterm'
		Plug 'dstein64/vim-startuptime'

		" Color Shower
		Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

		" Tree Sitter
		Plug 'nvim-treesitter/nvim-treesitter' , { 'do': ':TSUpdate' }
		Plug 'nvim-treesitter/playground'

		" Lsp
		Plug 'neovim/nvim-lspconfig'
		Plug 'ray-x/lsp_signature.nvim'

		Plug 'hrsh7th/nvim-cmp'
		Plug 'hrsh7th/cmp-buffer'
		Plug 'hrsh7th/cmp-path'
		Plug 'hrsh7th/cmp-nvim-lua'
		Plug 'hrsh7th/cmp-nvim-lsp'
		Plug 'onsails/lspkind-nvim'

		" Debugger
		" Plug 'puremourning/vimspector'

		" My Plugin
		Plug 'aditya-K2/spellfloat'

		"Maximizer
		Plug 'szw/vim-maximizer'

  call plug#end()
