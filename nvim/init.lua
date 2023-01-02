require("setup")

--
-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost init.lua source <afile> | PackerCompile
--   augroup end
-- ]])
-- vim.cmd("filetype plugin indent on")
-- vim.cmd("syntax enable")
--
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
--
-- -- disable line numbers on terminal buffers
-- vim.cmd([[
--   autocmd TermOpen * setlocal nonumber norelativenumber
-- ]])
