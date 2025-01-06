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

local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require("go.format").goimports()
  end,
  group = format_sync_grp,
})

return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v4.x",
    lazy = true,
    config = false,
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = true,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    -- event = "InsertEnter",
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
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
    },
    config = function()
      local lsp_zero = require("lsp-zero")
      require("mason").setup({})
      require("mason-lspconfig").setup({
        ensure_installed = {
          -- "tsserver",
          -- "eslint",
          -- "buf",
          "zls",
          "terraformls",
          "pyright",
          "bashls",
          -- "clangd",
        },
        handlers = {
          rust_analyzer = lsp_zero.noop,
          -- gopls = lsp_zero.noop,
          lsp_zero.default_setup,
          jdtls = lsp_zero.noop,
          tsserver = lsp_zero.noop,
          -- lua_ls = function()
          --   local lua_opts = lsp_zero.nvim_lua_ls()
          --   require("lspconfig").lua_ls.setup(lua_opts)
          -- end,
        },
      })
      lsp_zero.setup()

      -- local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
      -- vim.api.nvim_create_autocmd("BufWritePre", {
      --   pattern = "*.go",
      --   callback = function()
      --     require("go.format").goimports()
      --   end,
      --   group = format_sync_grp,
      -- })

      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.formatting.rubocop,
          null_ls.builtins.formatting.xmllint,
          null_ls.builtins.formatting.black,
          null_ls.builtins.diagnostics.buf,
          -- null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.zigfmt,
          -- null_ls.builtins.formatting.prettierd,
          -- null_ls.builtins.code_actions.eslint,

          null_ls.builtins.diagnostics.hadolint,
          null_ls.builtins.diagnostics.checkmake,
          null_ls.builtins.diagnostics.fish,

        },
        -- you can reuse a shared lspconfig on_attach callback here
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            print("null-ls formatting used")
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({
                  bufnr = bufnr,
                })
              end,
            })
          end
        end,
      })
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("go").setup({
        -- disable_defaults = true,
        lsp_codelens = true,
        lsp_keymaps = false,
        run_in_floaterm = true,
        -- diagnostic = {
        --     hdlr = true,
        --     virtual_text = {},
        -- },
        textobjects = true,
        lsp_inlay_hints = {
          enable = false,
          only_current_line = true,
          show_variable_name = true,
          show_parameter_hints = true,
          parameter_hints_prefix = " ",
          other_hints_prefix = "=> ",
          max_len_align = false,
          max_len_align_padding = 1,
          right_align = false,
          -- highlight = "Comment",
        },
        trouble = true, -- true: use trouble to open quickfix
        luasnip = true,
        lsp_cfg = {
          flags = {
            debounce_text_changes = 150,
          },
          -- root_dir = vim.loop,
          settings = { telemetry = false },
          -- offset_encoding = "utf-8",
          capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        },
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
}
