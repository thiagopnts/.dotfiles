 require("nvim-treesitter.configs").setup({
   -- A list of parser names, or "all"
   ensure_installed = { "lua", "rust", "java", "go" },

   -- Install parsers synchronously (only applied to `ensure_installed`)
   sync_install = false,

   highlight = {
     enable = true,

     additional_vim_regex_highlighting = false,
   },
   -- nvim-treesitter-textobjects configs
   textobjects = {
     select = {
       enable = true,

       -- Automatically jump forward to textobj, similar to targets.vim
       lookahead = true,

       keymaps = {
         ["uc"] = "@comment.outer",
         -- You can use the capture groups defined in textobjects.scm
         ["ai"] = "@conditional.outer",
         ["ii"] = "@conditional.inner",
         ["af"] = "@function.outer",
         ["if"] = "@function.inner",
         ["ac"] = "@class.outer",
         ["ic"] = "@class.inner",
       },
     },
   },
 })

-- Uses TreesitterContext hightlight group, which defaults to values from NormalFloat
require("treesitter-context").setup()
