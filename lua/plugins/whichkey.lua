return 
{
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    {
			'<leader>/',
            '<leader>c',
            '<leader>d',
            '<leader>e',
            '<leader>f',
            '<leader>g',
            '<leader>J',
            '<leader>w',
			'<leader>u',
            '<leader>l',
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
