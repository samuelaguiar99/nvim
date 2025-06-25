
local gruvbox_material =
{
      'sainnhe/gruvbox-material',
	  name="gruvbox",
      lazy = false,
      priority = 1000,
      config = function()
        vim.g.gruvbox_material_enable_italic = true
		vim.g.gruvbox_material_transparent_background = 2
		vim.g.gruvbox_material_background="hard"
		vim.g.gruvbox_material_enable_bold = 1
		vim.g.gruvbox_material_enable_italic = 1
		vim.g.gruvbox_material_diagnostic_virtual_text="grey"

		vim.api.nvim_create_autocmd("LspAttach", {
		  callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			client.server_capabilities.semanticTokensProvider = nil
		  end,
		});
        vim.cmd.colorscheme('gruvbox-material')

      end
}

local onedarkpro = {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    lazy = false ,
    config = function ()

		require("onedarkpro").setup({
			options = {
				cursorline = true,
				transparency = true,
				lualine_transparency = true,
			},
		})


        vim.cmd.colorscheme("onedark_vivid")
    end
}
return onedarkpro;
