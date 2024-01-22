local kinds = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "ﰠ",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "塞",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "פּ",
  Event = "",
  Operator = "",
  TypeParameter = "",
}


require("lsp_signature").setup({
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  hint_prefix = "",
  handler_opts = {
    border = "rounded",
  },
})

local lsp = require("lsp-zero")
lsp.preset("recommended")
lsp.ensure_installed({
  -- "jdtls",
  "tsserver",
  "eslint",
  "lua_ls",
  "rust_analyzer",
  "gopls",
  "denols",
  "zls",
  "terraformls",
  "pyright",
  "bashls",
  "solargraph",
  "clangd",
})

lsp.nvim_workspace()
local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
lsp.setup_nvim_cmp({
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
  documentation = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
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
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "copilot" },
  }),
})
local rust_lsp = lsp.build_options("rust_analyzer", {})
local lsp_format = require('lsp-format')
-- local go_lsp = lsp.build_options("gopls", {})

lsp.on_attach(function(client, bufnr)
  lsp_format.on_attach(client, bufnr)
end)

lsp.setup()

require("rust-tools").setup({ server = rust_lsp })
require("go").setup({
  disable_defaults = true,
  lsp_codelens = true,
  lsp_keymaps = false,
  run_in_floaterm = true,
  diagnostic = {
    hdlr = true,
    virtual_text = {},
  },
  textobjects = true,
  lsp_document_formatting = true,
  lsp_inlay_hints = {
    style = 'inlay',
    enable = true,
    only_current_line = false,
    show_variable_name = true,
    show_parameter_hints = true,
    parameter_hints_prefix = " ",
    other_hints_prefix = "=> ",
    max_len_align = false,
    max_len_align_padding = 1,
    right_align = false,
    highlight = "Comment",
  },
  trouble = true, -- true: use trouble to open quickfix
  luasnip = true,
  lsp_cfg = {
    flags = {
      debounce_text_changes = 150,
    },
    root_dir = vim.cwd,
    settings = { telemetry = false },
    -- offset_encoding = "utf-8",
    capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = function(client, bufnr)
      vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })
      lsp_format.on_attach(client, bufnr)
      -- if client.server_capabilities.documentFormattingProvider then
      --   vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
      -- end
    end,
  },
})


require("lspsaga").setup({
  kinds = kinds,
  diagnostic_header = { " ", " ", " ", "ﴞ " },
})

local signs = { Error = "", Warn = "", Hint = "ﴞ", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
