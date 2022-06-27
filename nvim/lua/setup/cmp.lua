local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
local cmp = require("cmp")

local codicons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

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

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
--cmp.setup.cmdline("/", {
--  --mapping = cmp.mapping.preset.cmdline(),
--  sources = {
--    { name = "buffer" },
--  },
--})
--
---- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
--cmp.setup.cmdline(":", {
--  --mapping = cmp.mapping.preset.cmdline(),
--  sources = {
--    { name = "cmdline" },
--  },
--})
