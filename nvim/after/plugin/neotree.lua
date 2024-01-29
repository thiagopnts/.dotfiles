require("neo-tree").setup({
  filesystem = {
    follow_current_file = {
      enabled = true,
      leave_dirs_open = false,
    },
  },
  close_if_last_window = true,
  buffers = {
    follow_current_file = {
      enabled = true,
      leave_dirs_open = false,
    },
  },
})
