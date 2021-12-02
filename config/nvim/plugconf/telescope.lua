-- Telescope Settings

require("telescope").setup {
  defaults = {
	  -- defaults here
  },
  pickers = {
    -- Your special builtin config goes in here
    find_files = {
      theme = "ivy",
    },
    live_grep = {
      theme = "ivy",
    }
  },
  extensions = {
    -- Your extension config goes in here
	fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}

require('telescope').load_extension('fzf')
