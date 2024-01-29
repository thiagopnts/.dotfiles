require("telescope").setup({
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },
  },
  pickers = {
    find_files = {
      theme = "dropdown",
    }
  },
  defaults = {
    prompt_prefix = "",
    selection_caret = "",
    entry_prefix = "",
    initial_mode = "insert",
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
    file_ignore_patterns = {},
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    use_less = true,
    path_display = {},
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
  },
})
require("telescope").load_extension("fzy_native")
require("telescope").load_extension("emoji")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<Leader>c", builtin.commands)
vim.keymap.set("n", "<Leader>ff", builtin.git_files)
vim.keymap.set("n", "<Leader>pf", builtin.find_files)
vim.keymap.set("n", "<Leader>bf", builtin.buffers)
vim.keymap.set("n", "<Leader>ag", builtin.live_grep)
