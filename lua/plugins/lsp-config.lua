return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "tsserver", "html", "tailwindcss", "cssls", "jsonls", "gopls" },
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			-- Function to filter out react/index.d.ts
			local function filterReactDTS(value)
				return string.match(value.filename, "react/index.d.ts") == nil
			end

			-- Custom on_list function
			local function on_list(options)
				local items = options.items
				if #items > 1 then
					items = vim.tbl_filter(filterReactDTS, items)
				end

				vim.fn.setqflist({}, " ", { title = options.title, items = items, context = options.context })
				vim.api.nvim_command("cfirst") -- or maybe you want 'copen' instead of 'cfirst'
			end

			-- Common on_attach function
			local on_attach = function(client, bufnr)
				local bufopts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set("n", "gd", function()
					vim.lsp.buf.definition({ on_list = on_list })
				end, bufopts)
			end

			-- Setup LSP servers with common configuration
			local servers = {
				emmet_language_server = {},
				lua_ls = { capabilities = capabilities },
				html = { capabilities = capabilities },
				cssls = { capabilities = capabilities },
				tailwindcss = { capabilities = capabilities },
				tsserver = { capabilities = capabilities },
				jsonls = { capabilities = capabilities },
				gopls = {
					capabilities = capabilities,
					cmd = { "gopls" },
					filetypes = { "go", "gomod", "gowork", "gotmpl" },
					root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
				},
			}

			for server, config in pairs(servers) do
				config.on_attach = on_attach
				lspconfig[server].setup(config)
			end

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
