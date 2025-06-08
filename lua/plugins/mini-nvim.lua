return
{
	'echasnovski/mini.nvim',
	version = false ,
	config = function()
		-- require("mini.pairs").setup({})
		require("mini.animate").setup({
			open = { enable = false },
			close = { enable = false },
		})
		require("mini.sessions").setup({})
	end
}

