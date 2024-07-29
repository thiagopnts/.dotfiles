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

local signs = { Error = "●", Warn = "●", Hint = "", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

require("lsp_signature").setup({
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  hint_prefix = "",
  handler_opts = {
    border = "rounded",
  },
})

local lsp = require("lsp-zero")
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
      "tsserver",
      "eslint",
      "jdtls",
      "lua_ls",
      "rust_analyzer",
      "gopls",
      "denols",
      "zls",
      "terraformls",
      "pyright",
      "bashls",
      "clangd",
  },
  handlers = {
    lsp.default_setup,
    lua_ls = function()
      local lua_opts = lsp.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  }
})
lsp.preset("recommended")

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
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "copilot" },
  }),
})
local rust_lsp = lsp.build_options("rust_analyzer", {})
-- local go_lsp = lsp.build_options("gopls", {})

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
  lsp_inlay_hints = {
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
    root_dir = vim.loop.cwd,
    settings = { telemetry = false },
    -- offset_encoding = "utf-8",
    capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = function(client, _)
      vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })
      if client.server_capabilities.documentFormattingProvider then
        vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
      end
    end,
  },
})

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.rubocop,
    null_ls.builtins.formatting.xmllint,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.zigfmt,
    -- null_ls.builtins.formatting.prettier,

    null_ls.builtins.diagnostics.hadolint,
    null_ls.builtins.diagnostics.checkmake,
    null_ls.builtins.diagnostics.fish,

    null_ls.builtins.code_actions.eslint,
  },
  -- you can reuse a shared lspconfig on_attach callback here
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
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

-- local kind = require("lspsaga.lspkind")
-- kind[12] = { "Function", " ", "#CBA6F7" }
require("lspsaga").setup({
  ui = {
    kind = {
--      ["Function"] = { " ", "#CBA6F7" },
    },
  },
  diagnostic_header = { " ", " ", " ", "ﴞ " },
  symbol_in_winbar = {
    in_custom = true,
  },
})

local function get_file_name(include_path)
  local file_name = require("lspsaga.symbolwinbar").get_file_name()
  if vim.fn.bufname("%") == "" then
    return ""
  end
  if include_path == false then
    return file_name
  end
  -- Else if include path: ./lsp/saga.lua -> lsp > saga.lua
  local sep = vim.loop.os_uname().sysname == "Windows" and "\\" or "/"
  local path_list = vim.split(string.gsub(vim.fn.expand("%:~:.:h"), "%%", ""), sep)
  local file_path = ""
  for _, cur in ipairs(path_list) do
    file_path = (cur == "." or cur == "~") and "" or file_path .. cur .. " " .. "%#LspSagaWinbarSep#>%*" .. " %*"
  end
  return file_path .. file_name
end

local function config_winbar()
  local exclude = {
    ["teminal"] = true,
    ["toggleterm"] = true,
    ["prompt"] = true,
    ["NvimTree"] = true,
    ["NeoTree"] = true,
    ["help"] = true,
  } -- Ignore float windows and exclude filetype
  if vim.api.nvim_win_get_config(0).zindex or exclude[vim.bo.filetype] then
    vim.wo.winbar = ""
  else
    local ok, lspsaga = pcall(require, "lspsaga.symbolwinbar")
    local sym
    if ok then
      sym = lspsaga.get_symbol_node()
    end
    local win_val = ""
    win_val = get_file_name(true) -- set to true to include path
    if sym ~= nil then
      win_val = win_val .. sym
    end
    vim.wo.winbar = win_val
  end
end

-- local events = { "BufEnter", "BufWinEnter", "CursorMoved" }

-- vim.api.nvim_create_autocmd(events, {
--   pattern = "*",
--   callback = function()
--     config_winbar()
--   end,
-- })

-- vim.api.nvim_create_autocmd("User", {
--   pattern = "LspsagaUpdateSymbol",
--   callback = function()
--     config_winbar()
--   end,
-- })
