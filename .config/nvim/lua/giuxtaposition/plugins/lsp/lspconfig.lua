return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} }, -- lua development
		"jose-elias-alvarez/typescript.nvim", -- typescript development
		"nvimdev/lspsaga.nvim", -- enhanced ui for lsp
	},
	config = function()
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local typescript = require("typescript")
		local lspsaga_diagnostic = require("lspsaga.diagnostic")
		local neodev = require("neodev")

		-- enable keybinds only for when lsp server available
		local on_attach = function(client, buffer)
			local Map = require("giuxtaposition.core.util").Map

			Map("n", "gf", "<cmd>Lspsaga finder<CR>", { desc = "References", buffer = buffer })
			Map("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { desc = "Goto Definition", buffer = buffer })
			Map({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "Code Action", buffer = buffer })
			Map("n", "<leader>cr", "<cmd>Lspsaga rename<CR>", { desc = "Rename", buffer = buffer })
			Map(
				"n",
				"<leader>cD",
				"<cmd>Lspsaga show_line_diagnostics<CR>",
				{ desc = "Line Diagnostics", buffer = buffer }
			)
			Map(
				"n",
				"<leader>cd",
				"<cmd>Lspsaga show_cursor_diagnostics<CR>",
				{ desc = "Cursor Diagnostics", buffer = buffer }
			)
			Map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { desc = "Prev Diagnostic", buffer = buffer })
			Map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", { desc = "Next Diagnostic", buffer = buffer })
			Map("n", "[e", function()
				lspsaga_diagnostic:goto_prev({ severity = vim.diagnostic.severity.ERROR })
			end, { desc = "Prev Error", buffer = buffer })
			Map("n", "]e", function()
				lspsaga_diagnostic:goto_next({ severity = vim.diagnostic.severity.ERROR })
			end, { desc = "Next Error", buffer = buffer })
			Map("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "Hover Documentation", buffer = buffer })

			if client.name == "tsserver" then
				Map("n", "<leader>co", ":TypescriptOrganizeImports<cr>", { desc = "Organize Imports", buffer = buffer })
				Map("n", "<leader>cc", ":TypescriptRemoveUnused<cr>", { desc = "Remove Unused", buffer = buffer })
				Map("n", "<leader>cF", ":TypescriptRenameFile<cr>", { desc = "Rename File", buffer = buffer })
			end
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- configure typescript server
		typescript.setup({
			server = {
				capabilities = capabilities,
				on_attach = on_attach,
				init_options = {
					preferences = {
						importModuleSpecifierPreference = "relative",
						importModuleSpecifierEnding = "minimal",
					},
				},
			},
		})

		-- neodev
		neodev.setup({
			library = { plugins = { "neotest" }, types = true },
		})

		-- configure html server
		lspconfig["html"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure css server
		lspconfig["cssls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure emmet language server
		lspconfig["emmet_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
		})

		-- configure lua server (with special settings)
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})

		-- markdown
		lspconfig["marksman"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
	end,
}
