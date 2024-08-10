return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    opts = {
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
      default_component_configs = {
        icon = {
          default = "",
        },
        git_status = {
          symbols = {
            added = " ",
            deleted = " ",
            modified = " ",
            renamed = " ",
            untracked = " ",
            ignored = " ",
            unstaged = "󰄱 ",
            staged = "󰄵 ",
            conflict = " ",
          },
        },
      },
    },
  },
}
