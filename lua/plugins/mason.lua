return {
	-- add the lsp needed to use mason
    {
        "hrsh7th/cmp-nvim-lsp",
        lazy = false
    },
	{
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗"
					}
				},
			})
        end
    },
	-- mason lsp config utilizes mason to automatically ensure lsp servers you want installed are installed
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            -- ensure that we have lua language server, typescript launguage server, java language server, and java test language server are installed
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "ts_ls", "jdtls" , "html" },
				automatic_enable = {
					exclude = {
						"jdtls", "html" , "ts_ls" , "emmet_language_server",
					}
				},
            })
        end
    },
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
			  "java-debug-adapter",
			  "java-test",
			  "google-java-format",
              "eslint_d",
              "prettier",
              "stylua" ,
			},
		},
	},
    -- mason nvim dap utilizes mason to automatically ensure debug adapters you want installed are installed, mason-lspconfig will not automatically install debug adapters for us
    {
        "jay-babu/mason-nvim-dap.nvim",
        config = function()
            -- ensure the java debug adapter is installed
            require("mason-nvim-dap").setup({
                ensure_installed = { "java-debug-adapter", "java-test" } , 
            })
        end
    },


}
