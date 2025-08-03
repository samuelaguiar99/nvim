return
{
        "neovim/nvim-lspconfig",
        config = function()

			vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
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
			end,
			})


            -- get access to the lspconfig plugins functions
            local lspconfig = require("lspconfig")

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- setup the lua language server
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
            })

            -- setup the typescript language server
            lspconfig.ts_ls.setup({
                capabilities = capabilities,
                init_options = {
                    preferences = {
                        includeCompletionsWithSnippetText = true,
                        includeCompletionsForImportStatements = true,
                    }
                }
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


            lspconfig.tailwindcss.setup({
                capabilities = capabilities,
            })



            -- Set custom diagnostic icons
            local signs = {
              [vim.diagnostic.severity.ERROR] = " ",
              [vim.diagnostic.severity.WARN]  = " ",
              [vim.diagnostic.severity.HINT] =  " ",
              [vim.diagnostic.severity.INFO] = " ",
            }

            vim.diagnostic.config({
                virtual_text = false ,
                signs = {
                    active = true ,
                    text = signs,
                } ,
                underline = {
                    severity = {
                        min = vim.diagnostic.severity.HINT,
                        max = vim.diagnostic.severity.HINT,
                    }
                },
                update_in_insert = false ,
                severity_sort = true ,
            })
            vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = "#999da3" })


        end
    }
