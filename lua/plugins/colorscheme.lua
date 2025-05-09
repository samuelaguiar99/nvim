local nightfox = 
{
	"EdenEast/nightfox.nvim",
    name = "NightFox",
    lazy = false , 
    priority = 1000 ,
	
	config = function()
		
		require('nightfox').setup({
			options = {
				-- Compiled file's destination location
				compile_path = vim.fn.stdpath("cache") .. "/nightfox",
				compile_file_suffix = "_compiled", -- Compiled file suffix
				transparent = true,     -- Disable setting background
				terminal_colors = true,  -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
				dim_inactive = false,    -- Non focused panes set to alternative background
				module_default = true,   -- Default enable value for modules
				colorblind = {
				  enable = false,        -- Enable colorblind support
				  simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
				  severity = {
					protan = 0,          -- Severity [0,1] for protan (red)
					deutan = 0,          -- Severity [0,1] for deutan (green)
					tritan = 0,          -- Severity [0,1] for tritan (blue)
				  },
				},
				styles = {               -- Style to be applied to different syntax groups
				  comments = "NONE",     -- Value is any valid attr-list value `:help attr-list`
				  conditionals = "NONE",
				  constants = "NONE",
				  functions = "NONE",
				  keywords = "NONE",
				  numbers = "NONE",
				  operators = "NONE",
				  strings = "NONE",
				  types = "NONE",
				  variables = "NONE",
				},
				inverse = {             -- Inverse highlight for different types
				  match_paren = false,
				  visual = false,
				  search = false,
				},
				modules = {             -- List of various plugins and additional options
				  -- ...
				},
			  },
			  palettes = {},
			  specs = {},
			  groups = {},

		})
		vim.cmd.colorscheme("nightfox")
	end


}


local gruvbox_material = 
{
      'sainnhe/gruvbox-material',
	  name="gruvbox",
      lazy = false,
      priority = 1000,
      config = function()
        -- Optionally configure and load the colorscheme
        -- directly inside the plugin declaration.
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



local everforest = {
	"neanias/everforest-nvim",
	name = "everforest",
	priority=1000,
	lazy=false,
	config = function()
		vim.cmd.colorscheme("everforest")
	end
}


local gruvbox = 
{
	'ellisonleao/gruvbox.nvim',
	priority=1000,
	lazy=false,
	config= function()
		require("gruvbox").setup({
		  terminal_colors = true, -- add neovim terminal colors
		  undercurl = true,
		  underline = true,
		  bold = true,
		  italic = {
			strings = true,
			emphasis = true,
			comments = true,
			operators = false,
			folds = true,
		  },
		  strikethrough = true,
		  invert_selection = false,
		  invert_signs = false,
		  invert_tabline = false,
		  invert_intend_guides = false,
		  inverse = true, -- invert background for search, diffs, statuslines and errors
		  contrast = "", -- can be "hard", "soft" or empty string
		  palette_overrides = {},
		  overrides = {},
		  dim_inactive = false,
		  transparent_mode = false,
		})
		vim.cmd("colorscheme gruvbox")
	end
}


local gruvbox_baby = 
{
	'luisiacc/gruvbox-baby',
	priority=1000,
	lazy=false,
	config = function()
		vim.cmd.colorscheme("gruvbox-baby")
	end

}




local material = 
{
	'marko-cerovac/material.nvim',
	priority = 1000, 
	lazy = false , 
	config = function()
		vim.cmd.colorscheme("material")
	end
}

local neovoid = 
{
  "samuelaguiar99/neovoid.nvim",
  priority = 1000,
  lazy=false,
  config = function()
    require("neovoid").load()
  end,
}

local kanagawa =
{
	"rebelot/kanagawa.nvim",
	config = function()
		require("kanagawa").setup({
			keywordStyle = { italic = false },
			transparent = true ,
			overrides = function(colors)
				local palette = colors.palette
				return {
					String = { italic = true },
					Boolean = { fg = palette.dragonPink },
					Constant = { fg = palette.constant, bold = true },

					Identifier = { fg = palette.identifier },
					Statement = { fg = palette.dragonBlue },
					Operator = { fg = palette.dragonGray2 },
					Keyword = { fg = palette.dragonRed },
					Function = { fg = palette.fun, bold = true },

					Type = { fg = palette.dragonYellow },

					Special = { fg = palette.dragonOrange },

					["@lsp.typemod.function.readonly"] = { fg = palette.dragonBlue },
					["@variable.member"] = { fg = palette.dragonBlue },
				}
			end,
		})
		vim.api.nvim_create_autocmd("LspAttach", {
		  callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			client.server_capabilities.semanticTokensProvider = nil
		  end,
		});
		vim.cmd("colorscheme kanagawa-dragon")
	end,
}

local melange = 
{
    "savq/melange-nvim",
    lazy = false , 
    priority = 1000, 
    config = function()
        vim.cmd.colorscheme("melange")

		vim.api.nvim_create_autocmd("LspAttach", {
		  callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			client.server_capabilities.semanticTokensProvider = nil
		  end,
		});

    end
}

local catppuccin = 
{
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        local transparent = true -- set to true if you would like to enable transparency

        local bg = "#011628"
        local bg_dark = "#011423"
        local bg_highlight = "#143652"
        local bg_search = "#0A64AC"
        local bg_visual = "#275378"
        local fg = "#CBE0F0"
        local fg_dark = "#B4D0E9"
        local fg_gutter = "#627E97"
        local border = "#547998"

        require("catppuccin").setup({
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            background = {     -- :h background
                light = "latte",
                dark = "mocha",
            },
            transparent_background = true, -- disables setting the background color.
            show_end_of_buffer = false,    -- shows the '~' characters after the end of buffers
            term_colors = false,           -- sets terminal colors (e.g. `g:terminal_color_0`)
            dim_inactive = {
                enabled = false,           -- dims the background color of inactive window
                shade = "dark",
                percentage = 0.15,         -- percentage of the shade to apply to the inactive window
            },
            no_italic = false,             -- Force no italic
            no_bold = false,               -- Force no bold
            no_underline = false,          -- Force no underline
            styles = {                     -- Handles the styles of general hi groups (see `:h highlight-args`):
                comments = { "italic" },   -- Change the style of comments
                conditionals = { "italic" },
                loops = {},
                functions = {},
                keywords = { "bold" },
                strings = {},
                variables = { "bold" },
                numbers = { "italic" },
                booleans = {},
                properties = {},
                types = {},
                operators = {},
                -- miscs = {}, -- Uncomment to turn off hard-coded styles
            },
            color_overrides = {},
            custom_highlights = {},
            default_integrations = true,
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                notify = true,
                mini = {
                    enabled = true,
                    indentscope_color = "",
                },
            },
        })
        vim.cmd("colorscheme catppuccin")

		vim.api.nvim_create_autocmd("LspAttach", {
		  callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			client.server_capabilities.semanticTokensProvider = nil
		  end,
		});
    end,
}


return gruvbox_material; 
