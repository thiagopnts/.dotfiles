return {
  { "nvim-treesitter/nvim-treesitter-textobjects", dependencies = { "nvim-treesitter/nvim-treesitter" } },
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    -- build = ":TSUpdate",
    -- event = { "LazyFile", "VeryLazy" },
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts_extend = { "ensure_installed" },
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "lua",
        "rust",
        "java",
        "go",
        "typescript",
        "tsx",
        "comment",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            ["uc"] = "@comment.outer",
            -- You can use the capture groups defined in textobjects.scm
            ["ai"] = "@conditional.outer",
            ["ii"] = "@conditional.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
      },
    },
    ---@param opts TSConfig
    config = function(_, opts)
      -- if type(opts.ensure_installed) == "table" then
      -- opts.ensure_installed = LazyVim.dedup(opts.ensure_installed)
      -- end
      require("nvim-treesitter.configs").setup(opts)
      require("treesitter-context").setup()
      require("ibl").setup({
        indent = {
          char = "┋",
        },
        scope = {
          enabled = true,
        },
      })
    end,
  },
}
