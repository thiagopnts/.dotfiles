--
-- setting opts as an object to take advantage
-- of the double key checking lint, its easy to
-- ended up setting the same option multiple times
-- as we're trying/setting/experimenting things in a hurry,
-- with this we get a warning in our faces.
for opt, value in pairs({
  compatible = false,
  tabstop = 4,
  shiftwidth = 4,
  undofile = true,
  undodir = os.getenv("HOME") .. "/.vim/undodir",
  shiftround = true,
  expandtab = true,
  encoding = "utf-8",
  autoindent = true,
  fileencoding = "utf-8",
  fileencodings = { "utf-8" },
  backup = false,
  writebackup = false,
  swapfile = false,
  wrap = true,
  background = "dark",
  softtabstop = 4,
  relativenumber = true, -- show line numbers relative
  number = true,
  colorcolumn = { 90 },
  mouse = "a",
  termguicolors = true,
  ignorecase = true,
  scrolloff = 999, -- keep cursor centered
  hlsearch = true,
  incsearch = true,
  smartindent = true,
  inccommand = "nosplit",
  clipboard = "unnamedplus",
  guifont = "CaskaydiaCove Nerd Font:h16",
  laststatus = 3,
  completeopt = { "menu", "menuone", "noselect" },
  list = true,
  --  cmdheight = 0,
  -- winbar = "%f",
}) do
  vim.opt[opt] = value
end

-- vim.opt.listchars:append("eol:↴")
vim.opt.listchars:append("eol:~")
vim.opt.listchars:append("tab:  ")
vim.g.camelcasemotion_key = ","
