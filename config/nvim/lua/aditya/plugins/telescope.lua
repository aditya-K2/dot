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
}
