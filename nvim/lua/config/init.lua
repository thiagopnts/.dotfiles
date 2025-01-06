-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.compatible = false
vim.opt.syntax = "on"
vim.opt.signcolumn = "yes"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.undofile = true
vim.opt.cursorline = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.encoding = "utf-8"
vim.opt.autoindent = true
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = { "utf-8" }
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.wrap = true
vim.opt.background = "dark"
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.colorcolumn = { 90 }
vim.opt.mouse = "a"
vim.opt.termguicolors = true
vim.opt.ignorecase = true
vim.opt.scrolloff = 999 -- keep cursor centered
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.smartindent = true
vim.opt.inccommand = "nosplit"
vim.opt.clipboard = "unnamedplus"
vim.opt.guifont = "CaskaydiaCove Nerd Font:h16"
vim.opt.laststatus = 3
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.list = true
--  vim.opt.cmdheight = 0
-- vim.opt.winbar = "%f"

-- vim.opt.listchars:append("eol:↴")
vim.opt.listchars:append("eol:~")
vim.opt.listchars:append("tab:  ")
vim.g.camelcasemotion_key = ","

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = { colorscheme = { "kanagawa" } },
  -- automatically check for plugin updates
  checker = { enabled = true, notify = false },
})

-- remaps
-- when in terminal mode(:term), map ESC to exit instead of the default c-\ c-n
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

vim.keymap.set("n", "<leader>bd", vim.cmd.bd)

vim.keymap.set("n", "<leader>qq", [[<cmd>:q!<cr>]])

-- rename current symbol
-- vim.api.nvim_set_keymap("n", "<Leader>rn", [[<Cmd>lua vim.lsp.buf.rename()<CR>]], { noremap = true, silent = true })
-- trying lsp saga rename because it has a nice float window + preview etc
-- might be worth looking into hooking lsp.buf.rename into it instead?
vim.api.nvim_set_keymap("n", "<Leader>rn", [[<Cmd>Lspsaga rename<CR>]], { noremap = true, silent = true })

-- eval current lua file
vim.api.nvim_set_keymap("n", "<Leader>rr", [[<Cmd> luafile %<CR>]], { noremap = true, silent = true })

-- FIXME: this should be bound only on go files
-- run current test func
vim.api.nvim_set_keymap("n", "<Leader>tf", [[<Cmd>GoTestFunc<CR>]], { noremap = true, silent = true })

-- FIXME: this should be bound only on lua files

-- keep everything centered
vim.api.nvim_set_keymap("n", "n", "nzzzv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "N", "Nzzzv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "J", "mzJ`z", { noremap = true, silent = true })

-- undo break points
--vim.api.nvim_set_keymap("i", ".", [[.<c-g>u]], {noremap = true, silent = true})

--vim.api.nvim_set_keymap("n", "<Leader>hw", [[<Cmd> HopWord<CR>]], { noremap = true, silent = true })

-- clear search hl
vim.api.nvim_set_keymap("n", "<Leader>cc", [[<Cmd> noh<CR>]], { noremap = true, silent = true })

-- open/close neo tree
vim.api.nvim_set_keymap("n", "<Leader>k", [[<Cmd> Neotree toggle<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>[", [[<Cmd> bp<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>]", [[<Cmd> bn<CR>]], { noremap = true, silent = true })
-- map Y to yank curr line position up until the end, similar with D, C, etc
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true, silent = true })

-- text move support
vim.api.nvim_set_keymap("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-j>", "<esc>:m .+1<CR>==i", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-k>", "<esc>:m .-2<CR>==i", { noremap = true, silent = true })

-- when in terminal mode(:term), map ESC to exit instead of the default c-\ c-n
vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

-- create new file
vim.api.nvim_set_keymap("n", "<Leader>fn", [[<Cmd> DashboardNewFile<CR>]], { noremap = true, silent = true })

-- show current line git blame
vim.api.nvim_set_keymap("n", "<Leader>gb", [[<Cmd> Gitsigns blame_line<CR>]], { noremap = true, silent = true })

-- map Y to yank curr line position up until the end, similar with D, C, etc
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true, silent = true })

-- text move support
vim.api.nvim_set_keymap("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-j>", "<esc>:m .+1<CR>==i", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-k>", "<esc>:m .-2<CR>==i", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<C-]>", ":lua vim.lsp.buf.definition()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<Leader>e",
  ":lua vim.diagnostic.open_float({prefix = '', source = true})<cr>",
  { noremap = true, silent = true }
)
-- git merge accept right
--vim.api.nvim_set_keymap("n", "<Leader>j", ":diffget //3", { noremap = true, silent = true })
-- git merge accept left
--vim.api.nvim_set_keymap("n", "<Leader>f", ":diffget //2", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "K", ":Lspsaga hover_doc", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<Leader>gfs", ":GoFillStruct<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>uw", ":Lspsaga lsp_finder<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>dvo", ":DiffviewOpen<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>dvc", ":DiffviewClose<CR>", { noremap = true, silent = true })
--require('gitsigns')[op]({ vim.fn.line("."), vim.fn.line("v") })
vim.api.nvim_set_keymap(
  "n",
  "<Leader>gs",
  ":lua require('gitsigns')['stage_hunk']({ vim.fn.line('.'), vim.fn.line('v') })<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap("n", "<Leader>T", [[<Cmd>:TroubleToggle<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>Tr", [[<Cmd>:TroubleRefresh<CR>]], { noremap = true, silent = true })
--vim.api.nvim_set_keymap("n", "<Leader>cc", [[<Cmd>:cc<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>cn", [[<Cmd>:cn<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>cp", [[<Cmd>:cp<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-s><C-w>", "<C-o>:normal vg_S)A<cr>", {
  noremap = true,
  silent = true,
  desc = "wraps from current cursor position until the end of line with parenthesis in insert mode",
})

vim.api.nvim_set_keymap("n", "<Leader>gr", [[<Cmd>:GoGenReturn<CR>]], { noremap = true, silent = true })
