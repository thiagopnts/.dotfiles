local kanagawa = require("kanagawa.colors")
local colorscheme = kanagawa.setup({ theme = "dragon" })
local colors = {
  fg = colorscheme.oldWhite,
  bg = colorscheme.sumiInk0,
  black = colorscheme.sumiInk0,
  white = colorscheme.oldWhite,
  green = colorscheme.springGreen,
  red = colorscheme.peachRed,
  orange = colorscheme.surimiOrange,
  blue = colorscheme.springBlue,
  cyan = colorscheme.crystalBlue,
  darkblue = colorscheme.waveBlue1,
  magenta = colorscheme.oniViolet,
  violet = colorscheme.oniViolet,
  yellow = colorscheme.carpYellow,
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local config = {
  options = {
    disabled_filetypes = { "packer", "NvimTree", "TelescopePrompt" },
    -- Disable sections and component separators
    component_separators = "",
    section_separators = "",
    theme = "auto",
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

ins_left({
  function()
    return "▊"
  end,
  color = { fg = colorscheme.sumiInk2 }, -- Sets highlighting of component
  padding = { left = 0, right = 1 }, -- We don't need space before this
})

ins_left({
  -- mode component
  function()
    return ""
  end,
  color = function()
    -- auto change color according to neovims mode
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [""] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [""] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ["r?"] = colors.cyan,
      ["!"] = colors.red,
      t = colors.red,
    }
    return { fg = mode_color[vim.fn.mode()], bg = colorscheme.sumiInk2 }
  end,
  padding = { right = 1 },
})

ins_left({
  "filetype",
  icon_only = true,
  colored = true,
  --        color = { fg = colors.green, gui = "bold" },
})
ins_left({
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { error = " ", warn = " ", info = " " },
  diagnostics_color = {
    color_error = { fg = colors.red, bg = colorscheme.sumiInk2 },
    color_warn = { fg = colors.yellow, bg = colorscheme.sumiInk2 },
    color_info = { fg = colors.cyan, bg = colorscheme.sumiInk2 },
  },
})
ins_left({
  "filesize",
  cond = conditions.buffer_not_empty,
})

ins_left({
  "filename",
  cond = conditions.buffer_not_empty,
  color = { fg = colors.magenta, gui = "bold" },
})

ins_left({ "location" })

ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })

ins_right({
  -- LSP name.
  function()
    local msg = "No Active LSP"
    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
    if buf_ft == "java" then
      msg = "☕️"
    end
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and client.name ~= "null-ls" then
        return client.name
      end
    end
    return msg
  end,
  icon = false,
  color = { fg = colors.white, gui = "bold" },
})

-- Add components to right sections
ins_right({
  "o:encoding", -- option component same as &encoding in viml
  fmt = string.upper,
  cond = conditions.hide_in_width,
  color = { fg = colors.green, gui = "bold" },
})
ins_right({
  "diff",
  symbols = { added = " ", modified = " ", removed = " " },
  source = diff_source,
  diff_color = {
    added = { fg = colors.green, bg = colorscheme.sumiInk2 },
    modified = { fg = colors.orange, bg = colorscheme.sumiInk2 },
    removed = { fg = colors.red, bg = colorscheme.sumiInk2 },
  },
  cond = conditions.hide_in_width,
})

ins_right({
  "fileformat",
  fmt = string.upper,
  icons_enabled = true,
  color = { fg = colors.green, bg = colorscheme.sumiInk2, gui = "bold" },
})

ins_right({
  "branch",
  icon = "",
  color = { fg = colors.violet, bg = colorscheme.sumiInk2, gui = "bold" },
})

ins_right({
  function()
    return "▊"
  end,
  color = { fg = colorscheme.sumiInk2 }, -- Sets highlighting of component
  padding = { left = 1 },
})

return {
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   opts = config,
  -- },
}
