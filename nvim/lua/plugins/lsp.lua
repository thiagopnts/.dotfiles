local kinds = {
    Namespace = " ",
    Text = " ",
    Method = " ",
    Function = "󰊕 ",
    Constructor = " ",
    Field = " ",
    Variable = " ",
    Class = " ",
    Interface = " ",
    Module = " ",
    Property = " ",
    Unit = " ",
    Number = " ",
    Constant = " ",
    Enum = " ",
    EnumMember = " ",
    Keyword = " ",
    Snippet = " ",
    Color = " ",
    File = " ",
    Reference = " ",
    Folder = " ",
    Struct = " ",
    Event = " ",
    Operator = " ",
    TypeParameter = " ",
    Table = " ",
    Object = " ",
    Tag = " ",
    Array = " ",
    Boolean = " ",
    Value = " ",
    Null = " ",
    String = " ",
    Calendar = " ",
    Watch = " ",
    Package = " ",
    Copilot = " ",
}

vim.lsp.config("*", {
    root_markers = { ".git" },
})

-- local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
-- vim.api.nvim_create_autocmd("BufWritePre", {
--     pattern = "*.go",
--     callback = function()
--         require("go.format").goimports()
--     end,
--     group = format_sync_grp,
-- })
vim.lsp.set_log_level("OFF")
return {
    {
        "mason-org/mason.nvim",
        opts = {},
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            {
                "hrsh7th/cmp-nvim-lsp",
                "L3MON4D3/LuaSnip",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lua",
                "rafamadriz/friendly-snippets",
            },
        },
        config = function()
            local luasnip = require("luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()
            local cmp = require("cmp")
            cmp.setup({
                experimental = {
                    ghost_text = true,
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(_, vim_item)
                        vim_item.menu = vim_item.kind
                        vim_item.kind = kinds[vim_item.kind]
                        return vim_item
                    end,
                },
                window = {
                    documentation = {
                        completion = cmp.config.window.bordered(),
                        documentation = cmp.config.window.bordered(),
                    },
                },
                mapping = cmp.mapping.preset.insert({
                    -- pick the closest snipet completion match out of all sources
                    ["<C-s>"] = cmp.mapping.complete({
                        config = {
                            sources = {
                                { name = "luasnip" },
                            },
                        },
                    }),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete({}),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    -- jump to next placeholder in the snippet
                    ["<C-d>"] = cmp.mapping(function(fallback)
                        if luasnip.jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    -- jump to previous placeholder in the snippet
                    ["<C-b>"] = cmp.mapping(function(fallback)
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "lazydev" },
                    { name = "luasnip" },
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "copilot" },
                }),
            })
        end,
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        -- cmd = { "LspInfo", "LspInstall", "LspStart" },
        -- event = { "BufReadPre", "BufNewFile" },
    },
}
