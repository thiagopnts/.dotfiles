vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")
    -- client for language servers
    use({

        "ray-x/go.nvim",
        requires = { "ray-x/guihua.lua" },
    })
    use("charmbracelet/glow")
    -- use("mfussenegger/nvim-dap")
    use("mfussenegger/nvim-jdtls")
    use({ "ellisonleao/glow.nvim", config = function() require("glow").setup() end })
    use("jose-elias-alvarez/nvim-lsp-ts-utils")
    use("rafamadriz/friendly-snippets")
    use("folke/neodev.nvim")
    use("triglav/vim-visual-increment")
    -- TODO: learn more about
    use("nvim-treesitter/nvim-treesitter-textobjects")
    use("jose-elias-alvarez/null-ls.nvim")
    use({ "glepnir/lspsaga.nvim", branch = "main" })
    -- use("axelf4/vim-strip-trailing-whitespace") -- remove trailing whitespace
    use({
        "kyazdani42/nvim-web-devicons",
        config = function()
            require('nvim-web-devicons').setup({
                override = {
                    toml = {
                        icon = " ",
                    }
                }
            })
        end
    }) -- for file icons
    -- use({
    --   "yamatsum/nvim-nonicons",
    --   requires = { "kyazdani42/nvim-web-devicons" },
    --   config = function()
    --     require("nvim-nonicons").setup({})
    --   end,
    -- })
    use("tpope/vim-fugitive")
    use("christoomey/vim-tmux-navigator")
    use("cespare/vim-toml")         -- toml syntax highlight
    use("LnL7/vim-nix")             -- nix syntax support
    use("ray-x/lsp_signature.nvim") -- show function signature when you type
    -- repeat unrepeatable commands
    use("tpope/vim-repeat")
    -- classic surround plugin
    use("tpope/vim-surround")
    use("hashivim/vim-terraform")
    -- use("simrat39/rust-tools.nvim")
    use("mrcjkb/rustaceanvim")
    use("lukas-reineke/indent-blankline.nvim")
    -- colorschemes
    use("rebelot/kanagawa.nvim")
    use({ "akinsho/toggleterm.nvim" })
    use("github/copilot.vim")
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
        "VonHeikemen/lsp-zero.nvim",
        requires = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },

            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },
            { "saadparwaiz1/cmp_luasnip" },
        },
    })
    use("simrat39/symbols-outline.nvim")
    use('VidocqH/lsp-lens.nvim')
    use("numToStr/Comment.nvim")
    use("j-hui/fidget.nvim")
    use("windwp/nvim-autopairs")
    use("lewis6991/gitsigns.nvim")
    use("bkad/CamelCaseMotion") -- can jump between camel|snakecase words
    use("mbbill/undotree")
    use("folke/trouble.nvim")
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
    })
    use({
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
    })
end)
