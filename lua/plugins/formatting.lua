return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
            formatters = {
				formatters_by_ft = {
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					svelte = { "prettier" },
					css = { "prettier" },
					html = { "prettier" },
					json = { "prettier" },
					yaml = { "prettier" },
					-- markdown = { "prettier" },
					graphql = { "prettier" },
					lua = { "stylua" },
				},
			},
		})

		-- Configure individual formatters
		conform.formatters.prettier = {
			args = {
				"--stdin-filepath",
				"$FILENAME",
				"--tab-width",
				"4",
				"--use-tabs",
				"false",
			},
		}
		vim.keymap.set({ "n", "v" }, "<leader>mF", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = " [m]anually [F]ormat buffer or selection with prettier" })
	end,
}
