return {
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {},
    config = function(_, opts)
      require("tokyonight").setup(opts)
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      -- transparent_background = true,
      integrations = {
        dashboard = true,
        diffview = true,
        flash = true,
        gitsigns = true,
        indent_blankline = {
          enabled = true,
          scope_color = "mauve", -- catppuccin color (eg. `lavender`) Default: text
          colored_indent_levels = false,
        },
        markdown = true,
        mini = {
          enabled = true,
          indentscope_color = "mauve", -- catppuccin color (eg. `lavender`) Default: text
        },
        neotree = true,
        neotest = true,
        noice = true,
        cmp = true,
        dap = true,
        dap_ui = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "undercurl" },
            hints = { "underline" },
            warnings = { "undercurl" },
            information = { "underline" },
          },
        },
        treesitter = true,
        treesitter_context = true,
        ufo = true,
        rainbow_delimiters = true,
        telescope = {
          enabled = true,
          style = "nvchad",
        },
        lsp_trouble = true,
        which_key = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)

      -- load the colorscheme here
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
}
