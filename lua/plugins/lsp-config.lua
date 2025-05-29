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
	-- use mason tool installer to install java-debug-adapter & java-test as these are not DAPS, but JDTLS dependencies
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
			  "java-debug-adapter",
			  "java-test",
			  "google-java-format",
              {"eslint_d" , version = '13.1.2'},
              "prettier",
              "stylua" ,
			},
		},
	},
    -- utility plugin for configuring the java language server for us
    {
        "mfussenegger/nvim-jdtls",
        dependencies = {
            "mfussenegger/nvim-dap",
        }
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- get access to the lspconfig plugins functions
            local lspconfig = require("lspconfig")

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- setup the lua language server
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })

            -- setup the typescript language server
            lspconfig.ts_ls.setup({
                capabilities = capabilities,
            })

            lspconfig.html.setup({
                capabilities = capabilities , 
                filetypes = {"html"},
                init_options = {
                    configurationSection = {"html" , "javascript" , "typescript"},
                    embeddedLanguages = {
                        css = true , 
                        javascript = true
                    },
                    provideFormatter = true,
                },
            })
			
            lspconfig.emmet_language_server.setup({
                capabilities = capabilities,
				filetypes = {
					"astro",
					"css",
					"eruby",
					"html",
					"javascript",
					"javascriptreact",
					"less",
					"php",
					"pug",
					"sass",
					"scss",
					"typescriptreact"
				},
				  -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
				  -- **Note:** only the options listed in the table are supported.
				  init_options = {
					--- @type string[]
					excludeLanguages = {},
					--- @type string[]
					extensionsPath = {},
					--- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
					preferences = {},
					--- @type boolean Defaults to `true`
					showAbbreviationSuggestions = true,
					--- @type "always" | "never" Defaults to `"always"`
					showExpandedAbbreviation = "always",
					--- @type boolean Defaults to `false`
					showSuggestionsAsSnippets = false,
					--- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
					syntaxProfiles = {},
					--- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
					variables = {},
				  },
            })

            -- Set vim motion for <Space> + c + h to show code documentation about the code the cursor is currently over if available
            vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, { desc = "[C]ode [H]over Documentation" })
            -- Set vim motion for <Space> + c + d to go where the code/variable under the cursor was defined
            vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "[C]ode Goto [D]efinition" })
            -- Set vim motion for <Space> + c + a for display code action suggestions for code diagnostics in both normal and visual mode
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })
            -- Set vim motion for <Space> + c + r to display references to the code under the cursor
            vim.keymap.set("n", "<leader>cr", require("telescope.builtin").lsp_references, { desc = "[C]ode Goto [R]eferences" })
            -- Set vim motion for <Space> + c + i to display implementations to the code under the cursor
            vim.keymap.set("n", "<leader>ci", require("telescope.builtin").lsp_implementations, { desc = "[C]ode Goto [I]mplementations" })
            -- Set a vim motion for <Space> + c + <Shift>R to smartly rename the code under the cursor
            vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, { desc = "[C]ode [R]ename" })
            -- Set a vim motion for <Space> + c + <Shift>D to go to where the code/object was declared in the project (class file)
            vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, { desc = "[C]ode Goto [D]eclaration" })
			--Show diagnostic in hover window
			vim.keymap.set("n", "<leader>sd", vim.diagnostic.open_float, { desc = "[S]how [D]iagnostic" })
        end
    }
}
