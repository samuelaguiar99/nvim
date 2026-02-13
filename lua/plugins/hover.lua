return {
	"lewis6991/hover.nvim",
	event = "LspAttach",
	config = function()
		require("hover").setup({
			providers = {
                require("hover_providers.java")
            },
			title = false,
			preview_opts = {
				border = "single",
				wrap = true,
				max_width = 85,
				max_height = 15,
			},
			preview_window = false,
		})

		vim.api.nvim_set_hl(0, "HoverWindow", { link = "NormalFloat" })
		-- vim.api.nvim_set_hl(0, "HoverBorder", { fg = "#82A497" })
		vim.api.nvim_set_hl(0, "HoverBorder", { fg = "#4F4F4F" })



		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local hover = require("hover")

				-- double-tap detection
				local last = 0

				-- remove any existing mapping first (extra safe)
				pcall(vim.keymap.del, "n", "<leader>ch", { buffer = args.buf })

				vim.keymap.set("n", "<leader>ch", function()
					local now = vim.loop.now()
					if now - last < 300 then
						hover.enter()
					else
						hover.open()
					end
					last = now
				end, {
					buffer = args.buf,
					desc = "Hover (double tap enters docs)",
				})
			end,
		})
	end,
}
