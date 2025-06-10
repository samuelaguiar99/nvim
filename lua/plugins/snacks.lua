return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false ,
		opts = {},
		keys = {
			{ "<leader>lg", function() require("snacks").lazygit() end, desc = "Lazygit" },
            { "<leader>lgl", function() require("snacks").lazygit.log() end, desc = "Lazygit Logs" },
            { "<leader>rN", function() require("snacks").rename.rename_file() end, desc = "Fast Rename Current File" },
            { "<leader>dB", function() require("snacks").bufdelete() end, desc = "Delete or Close Buffer  (Confirm)" },

            --Snacks picker
            {"<leader>vc" , function() require("snacks").picker.files ( { cwd = vim.fn.stdpath("config")}) end , desc = "Find Neovim Config Files"}
		}
	},

}
