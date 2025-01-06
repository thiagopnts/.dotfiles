local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
return {
    {
        'smoka7/hop.nvim',
        version = "*",
        opts = {
            keys = 'etovxqpdygfblzhckisuran'
        },
        keys = {
            { "<leader>h", vim.cmd.HopWord },
        },
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("kanagawa").setup({
                compile = true,
                overrides = function(colors)
                    return {
                        NvimTreeVertsplit = { bg = colors.sumiInk1, fg = colors.sumiInk1 },
                        NvimTreeStatusLineNC = { bg = colors.sumiInk1, fg = colors.sumiInk1 },
                        NvimTreeStatusLine = { bg = colors.sumiInk1, fg = colors.sumiInk1 },
                        StatusLineNC = { bg = colors.sumiInk2, fg = colors.sumiInk2 },
                    }
                end,
            })
            vim.o.termguicolors = true
            vim.cmd.colorscheme("kanagawa")
            vim.cmd("highlight Normal guibg=black ctermbg=black")
        end,
    },
    { "mfussenegger/nvim-dap" },
    {
        "OXY2DEV/markview.nvim",
        lazy = false, -- Recommended
        -- ft = "markdown" -- If you decide to lazy-load anyway

        dependencies = {
            -- You will not need this if you installed the
            -- parsers manually
            -- Or if the parsers are in your $RUNTIMEPATH
            "nvim-treesitter/nvim-treesitter",

            "nvim-tree/nvim-web-devicons",
        },
    },
    { "jose-elias-alvarez/null-ls.nvim" },
    {
        "ellisonleao/glow.nvim",
        config = true,
        cmd = { "Glow" },
    },
    {
        "ray-x/go.nvim",
        dependencies = { "ray-x/guihua.lua" },
    },
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        lazy = false,
        opts = {},
    },
    { "mfussenegger/nvim-jdtls",       lazy = false },

    { "folke/neodev.nvim" },
    { "triglav/vim-visual-increment" },

    { "tpope/vim-fugitive" },
    { "christoomey/vim-tmux-navigator" },
    { "cespare/vim-toml" },
    { "LnL7/vim-nix" },
    {
        "ray-x/lsp_signature.nvim",
        opts = {

            bind = true, -- This is mandatory, otherwise border config won't get registered.
            hint_prefix = "",
            handler_opts = {
                border = "rounded",
            },
        },
    },
    { "tpope/vim-repeat" },

    { "tpope/vim-surround" },

    { "simrat39/symbols-outline.nvim", keys = { "<leader>so", "<cmd>SymbolsOutline<cr>" } },
    -- show symbol outline
    { "VidocqH/lsp-lens.nvim",         opts = {} },
    { "numToStr/Comment.nvim" },
    { "j-hui/fidget.nvim",             opts = {} },
    { "windwp/nvim-autopairs",         opts = {},                                         lazy = false },
    { "bkad/CamelCaseMotion" }, -- can jump between camel|snakecase words
    {
        "mbbill/undotree",
        keys = {
            { "<leader>ut", vim.cmd.UndotreeToggle },
        },
    },
    { "rafamadriz/friendly-snippets" },
    {
        "glepnir/lspsaga.nvim",
        branch = "main",
        opts = {
            ui = {
                kind = {
                    -- FIXME: this is not working and gives this error:
                    -- "E5248: Invalid character in group name". The #CBA6F7 should be group name, not the color
                    -- ["Function"] = { "󰊕", "#CBA6F7" },
                },
            },
            diagnostic_header = { signs.Error, signs.Warn, signs.Hint, signs.Info },
            symbol_in_winbar = {
                in_custom = true,
            },
        },
    },
    { "axelf4/vim-strip-trailing-whitespace" }, -- remove trailing whitespace
    -- {
    --   "nvim-tree/nvim-web-devicons",
    --   opts = {
    --     override = {
    --       toml = {
    --         icon = " ",
    --       },
    --     },
    --   },
    -- },
    -- {
    --   "yamatsum/nvim-nonicons",
    --   requires = { "kyazdani42/nvim-web-devicons" },
    --   config = function()
    --     require("nvim-nonicons").setup({})
    --   end,
    -- },
    -- repeat unrepeatable commands
    { "tpope/vim-repeat" },
    -- classic surround plugin
    { "hashivim/vim-terraform" },
    { "mrcjkb/rustaceanvim",                    version = "^5",                    lazy = false },
    { "lukas-reineke/indent-blankline.nvim",    main = "ibl",                      opts = {} },
    { "akinsho/toggleterm.nvim" },
    {"kdheepak/lazygit.nvim"},
    { "github/copilot.vim" },
    { "sindrets/diffview.nvim",                 requires = "nvim-lua/plenary.nvim" },
    { "nvim-treesitter/nvim-treesitter",        run = ":TSUpdate" },
    -- sticks current function/method/class/etc context to top line
    { "nvim-treesitter/nvim-treesitter-context" },
    -- {
    --   "APZelos/blamer.nvim", -- show commit/blame current line
    --   config = function()
    --     vim.g.blamer_enabled = 1
    --     vim.g.blamer_show_in_visual_modes = 1
    --     vim.g.blamer_show_in_insert_modes = 0
    --   end,
    -- },
}
