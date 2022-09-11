-- Telescope Settings

require("telescope").setup {
  defaults = {
   -- defaults here
  },
  pickers = {
    -- Your special builtin config goes in here
    find_files = {
      theme = "ivy",
      layout_config = { height = 0.3 }
    },
    live_grep = {
      theme = "ivy",
      layout_config = { height = 0.3 }
    },
    help_tags = {
      theme = "ivy",
      layout_config = { height = 0.3 }
    }
  },
}
