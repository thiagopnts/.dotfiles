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

vim.cmd([[colorscheme kanagawa-wave]])
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)
vim.diagnostic.config({
  virtual_text = true,
})
--
-- -- disable line numbers on terminal buffers
-- vim.cmd([[
--   autocmd TermOpen * setlocal nonumber norelativenumber
-- ]])
