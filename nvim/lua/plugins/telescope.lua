
return {
  { "nvim-telescope/telescope-fzy-native.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
  { "xiyaowong/telescope-emoji.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      extensions = {
        fzy_native = {
          override_generic_sorter = false,
          override_file_sorter = true,
        },
      },
      pickers = {
        find_files = {
          theme = "ivy",
        },
      },
      defaults = {
        prompt_prefix = "",
        selection_caret = "",
        entry_prefix = "",
        initial_mode = "insert",
        path_display = { "tail" },
        selection_strategy = "reset",
        sorting_strategy = "descending",
        -- layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            mirror = false,
          },
          vertical = {
            mirror = false,
          },
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = {".class"},
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        use_less = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
      },
    },
    keys = {
      { "<leader>c", "<cmd>Telescope commands<cr>" },
      { "<leader>lg", "<cmd>LazyGit<cr>" },
      { "<leader>ds", "<cmd>Telescope lsp_document_symbols<cr>" },
      { "<leader>ws", "<cmd>Telescope lsp_workspace_symbols<cr>" },
      { "<leader>ff", "<cmd>lua require('telescope.builtin').find_files{ path_display = { 'shorten' } }<cr>" },
      { "<leader>bf", "<cmd>Telescope buffers path_display={'shorten'}<cr>" },
      { "<leader>ag", "<cmd>Telescope live_grep  path_display={'shorten'}<cr>" },
    },
    config = function()
      require("telescope").load_extension("fzy_native")
      require("telescope").load_extension("emoji")
    end,
  },
}
