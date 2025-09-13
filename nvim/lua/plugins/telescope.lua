LazyVim = require("lazy")
return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  version = false, -- telescope did only one release, so use HEAD for now
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = (build_cmd ~= "cmake") and "make"
        or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      enabled = build_cmd ~= nil,
      config = function(plugin)
        LazyVim.on_load("telescope.nvim", function()
          local ok, err = pcall(require("telescope").load_extension, "fzf")
          if not ok then
            local lib = plugin.dir .. "/build/libfzf." .. (LazyVim.is_win() and "dll" or "so")
            if not vim.uv.fs_stat(lib) then
              LazyVim.warn("`telescope-fzf-native.nvim` not built. Rebuilding...")
              require("lazy").build({ plugins = { plugin }, show = false }):wait(function()
                LazyVim.info("Rebuilding `telescope-fzf-native.nvim` done.\nPlease restart Neovim.")
              end)
            else
              LazyVim.error("Failed to load `telescope-fzf-native.nvim`:\n" .. err)
            end
          end
        end)
      end,
    },
  },
  keys = {
    {
      "<leader>b",
      "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
      desc = "Switch Buffer",
    },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files (Root Dir)" },
    { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
    { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
    { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
    { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
    { "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix List" },
    {
      "<leader>ss",
      function()
        require("telescope.builtin").lsp_document_symbols({
          symbols = LazyVim.config.get_kind_filter(),
        })
      end,
      desc = "Goto Symbol",
    },
  },
  opts = function()
    local actions = require("telescope.actions")

    local open_with_trouble = function(...)
      return require("trouble.sources.telescope").open(...)
    end
    local find_files_no_ignore = function()
      local action_state = require("telescope.actions.state")
      local line = action_state.get_current_line()
      LazyVim.pick("find_files", { no_ignore = true, default_text = line })()
    end
    local find_files_with_hidden = function()
      local action_state = require("telescope.actions.state")
      local line = action_state.get_current_line()
      LazyVim.pick("find_files", { hidden = true, default_text = line })()
    end

    local function find_command()
      if 1 == vim.fn.executable("rg") then
        return { "rg", "--files", "--color", "never", "-g", "!.git" }
      elseif 1 == vim.fn.executable("fd") then
        return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
      elseif 1 == vim.fn.executable("fdfind") then
        return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
      elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
        return { "find", ".", "-type", "f" }
      elseif 1 == vim.fn.executable("where") then
        return { "where", "/r", ".", "*" }
      end
    end

    return {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        -- open files in the first window that is an actual file.
        -- use the current window if no other window is available.
        get_selection_window = function()
          local wins = vim.api.nvim_list_wins()
          table.insert(wins, 1, vim.api.nvim_get_current_win())
          for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].buftype == "" then
              return win
            end
          end
          return 0
        end,
        mappings = {
          i = {
            ["<c-t>"] = open_with_trouble,
            ["<a-t>"] = open_with_trouble,
            ["<a-i>"] = find_files_no_ignore,
            ["<a-h>"] = find_files_with_hidden,
            ["<C-Down>"] = actions.cycle_history_next,
            ["<C-Up>"] = actions.cycle_history_prev,
            ["<C-f>"] = actions.preview_scrolling_down,
            ["<C-b>"] = actions.preview_scrolling_up,
          },
          n = {
            ["q"] = actions.close,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = find_command,
          hidden = true,
        },
      },
    }
  end,
}
