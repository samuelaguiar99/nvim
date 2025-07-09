return {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
	vim.keymap.set('n','<leader>e' , "<cmd>NvimTreeToggle<CR>" , { desc = "Toggle [E]xplorer"} )
    require("nvim-tree").setup {
		hijack_netrw = true ,
		auto_reload_on_write = true,
		renderer = {
			group_empty = true,
		},
		view = {
			width = 40,
		},

	}
  end,
}
