require("giuxtaposition.plugins-setup")
require("giuxtaposition.core.options")
require("giuxtaposition.core.keymaps")
require("giuxtaposition.core.colorscheme")
require("giuxtaposition.plugins.nvim-tree")
require("giuxtaposition.plugins.lualine")
require("giuxtaposition.plugins.telescope")
require("giuxtaposition.plugins.nvim-cmp")
require("giuxtaposition.plugins.lsp.mason")
require("giuxtaposition.plugins.lsp.lspsaga")
require("giuxtaposition.plugins.lsp.lspconfig")
require("giuxtaposition.plugins.lsp.null-ls")
require("giuxtaposition.plugins.autopairs")
require("giuxtaposition.plugins.treesitter")
require("giuxtaposition.plugins.nvim-colorizer")
require("giuxtaposition.plugins.bufferline")
require("giuxtaposition.plugins.indent-blankline")
require("giuxtaposition.plugins.neo-test")
require("giuxtaposition.plugins.rainbow-delimiters")
require("giuxtaposition.plugins.noice")

-- disable netrw as suggested by nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
