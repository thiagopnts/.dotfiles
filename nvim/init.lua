-- TODO: we rely on a few binaries, add list here:
-- - fzf
-- - ripgrep
-- - lazygit
--local get_setup = function(name)
--  return string.format 'require("setup/%s")', name
--end
--

require("packer").startup(function(use)
  use("wbthomason/packer.nvim")
  -- client for language servers
  use({
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  })
  use({

    "ray-x/go.nvim",
    requires = { "ray-x/guihua.lua" },
  })
  use("ellisonleao/glow.nvim")
  use("jose-elias-alvarez/nvim-lsp-ts-utils")
  use("rafamadriz/friendly-snippets")
  use("folke/neodev.nvim")
  use("triglav/vim-visual-increment")
  -- TODO: learn more about
  use("nvim-treesitter/nvim-treesitter-textobjects")
  use("jose-elias-alvarez/null-ls.nvim")
  use({ "glepnir/lspsaga.nvim", branch = "main" })
  use("axelf4/vim-strip-trailing-whitespace") -- remove trailing whitespace
  use("kyazdani42/nvim-web-devicons") -- for file icons
  use({
    "yamatsum/nvim-nonicons",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("nvim-nonicons").setup({})
    end,
  })
  use("tpope/vim-fugitive")
  use("christoomey/vim-tmux-navigator")
  use("cespare/vim-toml") -- toml syntax highlight
  use("LnL7/vim-nix") -- nix syntax support
  use("ray-x/lsp_signature.nvim") -- show function signature when you type
  -- repeat unrepeatable commands
  use("tpope/vim-repeat")
  -- classic surround plugin
  use("tpope/vim-surround")
  use("hashivim/vim-terraform")
  use("simrat39/rust-tools.nvim")
  use("lukas-reineke/indent-blankline.nvim")
  -- colorschemes
  use("rebelot/kanagawa.nvim")
  use({ "akinsho/toggleterm.nvim" })
  use({ "nvim-telescope/telescope-fzy-native.nvim", run = "make" })
  use({ "xiyaowong/telescope-emoji.nvim", requires = "nvim-telescope/telescope.nvim" })
  use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })
  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
  })
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  -- sticks current function/method/class/etc context to top line
  use("nvim-treesitter/nvim-treesitter-context")
  use({
    "williamboman/nvim-lsp-installer",
    requires = {
      { "neovim/nvim-lspconfig" },
      { "folke/neodev.nvim" },
    },
  })
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-cmdline" },
      { "L3MON4D3/LuaSnip" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lua" },
      { "f3fora/cmp-spell", { "hrsh7th/cmp-calc" }, { "hrsh7th/cmp-emoji" } },
    },
  })
  use({
    "simrat39/symbols-outline.nvim",
    config = function()
      vim.g.symbols_outline = {
        width = 13,
        symbols = {
          Function = { icon = "", hl = "TSFunction" },
        },
      }
    end,
  })
  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({})
    end,
  })
  use({
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({
        text = {
          spinner = "dots",
        },
        align = {
          bottom = true,
          right = true,
        },
      })
    end,
  })
  use({
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  })
  use("lewis6991/gitsigns.nvim")
  use({
    "bkad/CamelCaseMotion", -- can jump between camel|snakecase words
    config = function()
      vim.g.camelcasemotion_key = ","
    end,
  })
  use("mbbill/undotree")
  use({
    "folke/trouble.nvim", -- rust lang support
    config = function()
      require("trouble").setup({
        position = "bottom",
        icons = true,
        action_keys = {
          close = "q", -- close the list
          cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
          refresh = "r", -- manually refresh
          jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
          open_split = { "i" }, -- open buffer in new split
          open_vsplit = { "s" }, -- open buffer in new vsplit
          open_tab = {}, -- { '<c-t>' }, -- open buffer in new tab
          jump_close = { "o" }, -- jump to the diagnostic and close the list
          toggle_mode = "m", -- toggle between 'workspace' and 'document' diagnostics mode
          toggle_preview = "P", -- toggle auto_preview
          hover = "K", -- opens a small popup with the full multiline message
          preview = "p", -- preview the diagnostic location
          close_folds = { "zM", "zm" }, -- close all folds
          open_folds = { "zR", "zr" }, -- open all folds
          toggle_fold = { "zA", "za" }, -- toggle fold of current file
          previous = "k", -- preview item
          next = "j", -- next item
        },
        use_diagnostic_signs = true,
      })
    end,
  })
  -- use({
  --   "APZelos/blamer.nvim", -- show commit/blame current line
  --   config = function()
  --     vim.g.blamer_enabled = 1
  --     vim.g.blamer_show_in_visual_modes = 1
  --     vim.g.blamer_show_in_insert_modes = 0
  --   end,
  -- })
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      -- lualine config based off eviline from @shadmansaleh
      local lualine = require("lualine")
      local kanagawa = require("kanagawa.colors")

      local colorscheme = kanagawa.setup()
      local colors = {
        fg = colorscheme.oldWhite,
        bg = colorscheme.sumiInk0,
        black = colorscheme.sumiInk0,
        white = colorscheme.oldWhite,
        green = colorscheme.springGreen,
        red = colorscheme.peachRed,
        orange = colorscheme.surimiOrange,
        blue = colorscheme.springBlue,
        cyan = colorscheme.crystalBlue,
        darkblue = colorscheme.waveBlue1,
        magenta = colorscheme.oniViolet,
        violet = colorscheme.oniViolet,
        yellow = colorscheme.carpYellow,
      }

      local conditions = {
        buffer_not_empty = function()
          return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
        end,
        hide_in_width = function()
          return vim.fn.winwidth(0) > 80
        end,
        check_git_workspace = function()
          local filepath = vim.fn.expand("%:p:h")
          local gitdir = vim.fn.finddir(".git", filepath .. ";")
          return gitdir and #gitdir > 0 and #gitdir < #filepath
        end,
      }

      local config = {
        options = {
          disabled_filetypes = { "packer", "NvimTree", "TelescopePrompt" },
          -- Disable sections and component separators
          component_separators = "",
          section_separators = "",
          theme = "auto",
        },
        sections = {
          -- these are to remove the defaults
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          -- These will be filled later
          lualine_c = {},
          lualine_x = {},
        },
        inactive_sections = {
          -- these are to remove the defaults
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
      }

      -- Inserts a component in lualine_c at left section
      local function ins_left(component)
        table.insert(config.sections.lualine_c, component)
      end

      -- Inserts a component in lualine_x ot right section
      local function ins_right(component)
        table.insert(config.sections.lualine_x, component)
      end

      ins_left({
        function()
          return "▊"
        end,
        color = { fg = colorscheme.sumiInk2 }, -- Sets highlighting of component
        padding = { left = 0, right = 1 }, -- We don't need space before this
      })

      ins_left({
        -- mode component
        function()
          return ""
        end,
        color = function()
          -- auto change color according to neovims mode
          local mode_color = {
            n = colors.red,
            i = colors.green,
            v = colors.blue,
            [""] = colors.blue,
            V = colors.blue,
            c = colors.magenta,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            [""] = colors.orange,
            ic = colors.yellow,
            R = colors.violet,
            Rv = colors.violet,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ["r?"] = colors.cyan,
            ["!"] = colors.red,
            t = colors.red,
          }
          return { fg = mode_color[vim.fn.mode()], bg = colorscheme.sumiInk2 }
        end,
        padding = { right = 1 },
      })

      ins_left({
        "filetype",
        icon_only = true,
        colored = true,
        --        color = { fg = colors.green, gui = "bold" },
      })
      ins_left({
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " " },
        diagnostics_color = {
          color_error = { fg = colors.red, bg = colorscheme.sumiInk2 },
          color_warn = { fg = colors.yellow, bg = colorscheme.sumiInk2 },
          color_info = { fg = colors.cyan, bg = colorscheme.sumiInk2 },
        },
      })
      ins_left({
        "filesize",
        cond = conditions.buffer_not_empty,
      })

      -- lets keep filename on the winbar for now
      -- ins_left({
      --   "filename",
      --   cond = conditions.buffer_not_empty,
      --   color = { fg = colors.magenta, gui = "bold" },
      -- })

      ins_left({ "location" })

      ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })

      ins_right({
        -- LSP name.
        function()
          local msg = "No Active LSP"
          local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then
            return msg
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and client.name ~= "null-ls" then
              return client.name
            end
          end
          return msg
        end,
        icon = false,
        color = { fg = colors.white, gui = "bold" },
      })

      -- Add components to right sections
      ins_right({
        "o:encoding", -- option component same as &encoding in viml
        fmt = string.upper,
        cond = conditions.hide_in_width,
        color = { fg = colors.green, gui = "bold" },
      })
      ins_right({
        "diff",
        symbols = { added = " ", modified = "柳", removed = " " },
        diff_color = {
          added = { fg = colors.green, bg = colorscheme.sumiInk2 },
          modified = { fg = colors.orange, bg = colorscheme.sumiInk2 },
          removed = { fg = colors.red, bg = colorscheme.sumiInk2 },
        },
        cond = conditions.hide_in_width,
      })

      ins_right({
        "fileformat",
        fmt = string.upper,
        icons_enabled = true,
        color = { fg = colors.green, bg = colorscheme.sumiInk2, gui = "bold" },
      })

      ins_right({
        "branch",
        icon = "",
        color = { fg = colors.violet, bg = colorscheme.sumiInk2, gui = "bold" },
      })

      ins_right({
        function()
          return "▊"
        end,
        color = { fg = colorscheme.sumiInk2 }, -- Sets highlighting of component
        padding = { left = 1 },
      })

      lualine.setup(config)
    end,
  })
  use({
    "nvim-neo-tree/neo-tree.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        buffers = {
          follow_current_file = true,
        },
        filetype = {
          follow_current_file = true,
        },
      })
    end,
  })
  -- use({
  --   "kyazdani42/nvim-tree.lua",
  --   config = function()
  --     vim.g.nvim_tree_side = "left"
  --     vim.g.nvim_tree_width = 25
  --     vim.g.nvim_tree_allow_resize = 1
  --     require("nvim-tree").setup({
  --       open_on_setup = false,
  --       open_on_tab = false,
  --       update_focused_file = { enable = true },
  --       git = {
  --         enable = false,
  --       },
  --       filters = {
  --         --dotfiles = true,
  --         custom = { ".git/", "node_modules", ".cache" },
  --       },
  --     })
  --   end,
  -- })
end)

require("setup/opts")
require("setup/mappings")
require("setup/cmp")
require("setup/lsp")
require("setup/telescope")
require("setup/gitsigns")
require("setup/toggleterm")

require("nvim-treesitter.configs").setup({
  -- A list of parser names, or "all"
  ensure_installed = { "c", "lua", "rust" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  -- nvim-treesitter-textobjects configs
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
})

-- Uses TreesitterContext hightlight group, which defaults to values from NormalFloat
require("treesitter-context").setup()

vim.g.indent_blankline_show_current_context = true

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerCompile
  augroup end
]])
vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")

local kanagawa = require("kanagawa.colors")

local colorscheme = kanagawa.setup()
require("kanagawa").setup({
  overrides = {
    --    NvimTreeNormal = { bg = colorscheme.sumiInk2, fg = colorscheme.sumiInk2 },
    NvimTreeVertsplit = { bg = colorscheme.sumiInk1, fg = colorscheme.sumiInk1 },
    NvimTreeStatusLineNC = { bg = colorscheme.sumiInk1, fg = colorscheme.sumiInk1 },
    NvimTreeStatusLine = { bg = colorscheme.sumiInk1, fg = colorscheme.sumiInk1 },
    StatusLineNC = { bg = colorscheme.sumiInk2, fg = colorscheme.sumiInk2 },
  },
})

vim.cmd([[colorscheme kanagawa]])
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)
vim.diagnostic.config({
  virtual_text = true,
})

-- disable line numbers on terminal buffers
vim.cmd([[
  autocmd TermOpen * setlocal nonumber norelativenumber
]])
