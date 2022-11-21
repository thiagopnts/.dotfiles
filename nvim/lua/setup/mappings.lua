vim.g.mapleader = " "
-- when in terminal mode(:term), map ESC to exit instead of the default c-\ c-n
vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<Leader>c", [[<Cmd>:Telescope commands<CR>]], { noremap = true, silent = true })

-- show symbol outline
vim.api.nvim_set_keymap("n", "<Leader>so", [[<Cmd>:SymbolsOutline<CR>]], { noremap = true, silent = true })

-- rename current symbol
-- vim.api.nvim_set_keymap("n", "<Leader>rn", [[<Cmd>lua vim.lsp.buf.rename()<CR>]], { noremap = true, silent = true })
-- trying lsp saga rename because it has a nice float window + preview etc
-- might be worth looking into hooking lsp.buf.rename into it instead?
vim.api.nvim_set_keymap("n", "<Leader>rn", [[<Cmd>Lspsaga rename<CR>]], { noremap = true, silent = true })

-- create new file
vim.api.nvim_set_keymap("n", "<Leader>fn", [[<Cmd> DashboardNewFile<CR>]], { noremap = true, silent = true })

-- eval current lua file
vim.api.nvim_set_keymap("n", "<Leader>rr", [[<Cmd> luafile %<CR>]], { noremap = true, silent = true })

-- FIXME: this should be bound only on go files
-- run current test func
vim.api.nvim_set_keymap("n", "<Leader>tf", [[<Cmd>GoTestFunc<CR>]], { noremap = true, silent = true })

-- FIXME: this should be bound only on lua files
-- eval current lua file
vim.api.nvim_set_keymap("n", "<Leader>rr", [[<Cmd> luafile %<CR>]], { noremap = true, silent = true })

-- keep everything centered
vim.api.nvim_set_keymap("n", "n", "nzzzv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "N", "Nzzzv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "J", "mzJ`z", { noremap = true, silent = true })

-- undo break points
--vim.api.nvim_set_keymap("i", ".", [[.<c-g>u]], {noremap = true, silent = true})

--vim.api.nvim_set_keymap("n", "<Leader>hw", [[<Cmd> HopWord<CR>]], { noremap = true, silent = true })

-- clear search hl
vim.api.nvim_set_keymap("n", "<Leader>cc", [[<Cmd> noh<CR>]], { noremap = true, silent = true })

-- open/close nvim tree
vim.api.nvim_set_keymap("n", "<Leader>k", [[<Cmd> NvimTreeToggle<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>[", [[<Cmd> bp<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>]", [[<Cmd> bn<CR>]], { noremap = true, silent = true })
-- map Y to yank curr line position up until the end, similar with D, C, etc
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true, silent = true })

-- text move support
vim.api.nvim_set_keymap("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-j>", "<esc>:m .+1<CR>==i", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-k>", "<esc>:m .-2<CR>==i", { noremap = true, silent = true })

-- telescope mappings
vim.api.nvim_set_keymap("n", "<Leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>em", "<cmd>Telescope emoji<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>b", ":Telescope buffers<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>ag", ":Telescope live_grep<cr>", { noremap = true, silent = true })
-- git fugitive mappings
vim.api.nvim_set_keymap("n", "<Leader>gs", ":Gstatus<cr>", { noremap = true, silent = true })
-- git merge accept right
vim.api.nvim_set_keymap("n", "<Leader>j", ":diffget //3", { noremap = true, silent = true })
-- git merge accept left
vim.api.nvim_set_keymap("n", "<Leader>f", ":diffget //2", { noremap = true, silent = true })
-- when in terminal mode(:term), map ESC to exit instead of the default c-\ c-n
vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

-- create new file
vim.api.nvim_set_keymap("n", "<Leader>fn", [[<Cmd> DashboardNewFile<CR>]], { noremap = true, silent = true })

-- eval current lua file
vim.api.nvim_set_keymap("n", "<Leader>rr", [[<Cmd> luafile %<CR>]], { noremap = true, silent = true })
-- show current line git blame
vim.api.nvim_set_keymap("n", "<Leader>gb", [[<Cmd> Gitsigns blame_line<CR>]], { noremap = true, silent = true })

-- keep everything centered
vim.api.nvim_set_keymap("n", "n", "nzzzv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "N", "Nzzzv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "J", "mzJ`z", { noremap = true, silent = true })

-- undo break points
--vim.api.nvim_set_keymap("i", ".", [[.<c-g>u]], {noremap = true, silent = true})

-- open/close nvim tree
vim.api.nvim_set_keymap("n", "<Leader>k", [[<Cmd> NvimTreeToggle<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>[", [[<Cmd> bp<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>]", [[<Cmd> bn<CR>]], { noremap = true, silent = true })
-- map Y to yank curr line position up until the end, similar with D, C, etc
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true, silent = true })

-- text move support
vim.api.nvim_set_keymap("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-j>", "<esc>:m .+1<CR>==i", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-k>", "<esc>:m .-2<CR>==i", { noremap = true, silent = true })

-- telescope mappings
vim.api.nvim_set_keymap("n", "<Leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>b", ":Telescope buffers<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>ag", ":Telescope live_grep<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-]>", ":lua vim.lsp.buf.definition()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<Leader>e",
  ":lua vim.diagnostic.open_float({prefix = '', source = true})<cr>",
  { noremap = true, silent = true }
)
-- git merge accept right
vim.api.nvim_set_keymap("n", "<Leader>j", ":diffget //3", { noremap = true, silent = true })
-- git merge accept left
vim.api.nvim_set_keymap("n", "<Leader>f", ":diffget //2", { noremap = true, silent = true })

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

--vim.api.nvim_set_keymap("n", "<Leader>cc", [[<Cmd>:cc<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>cn", [[<Cmd>:cn<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>cp", [[<Cmd>:cp<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-s><C-w>", "<C-o>:normal vg_S)A<cr>", {
  noremap = true,
  silent = true,
  desc = "wraps from current cursor position until the end of line with parenthesis in insert mode",
})

vim.api.nvim_set_keymap("n", "<Leader>gr", [[<Cmd>:GoGenReturn<CR>]], { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<Leader>ut", [[<Cmd>:UndotreeToggle<CR>]], { noremap = true, silent = true })
