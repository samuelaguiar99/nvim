return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvimtools/none-ls-extras.nvim",
    },
    config = function()
        -- get access to the none-ls functions
        local null_ls = require("null-ls")
        -- run the setup function for none-ls to setup our different formatters
        null_ls.setup({
			debug = true,
            sources = {
                null_ls.builtins.formatting.stylua,
				--null_ls.builtins.completion.spell,
				require("none-ls.diagnostics.eslint_d").with({
                    condition = function(utils)
                        return utils.root_has_file({".eslintrc.js", ".eslintrc.json", ".eslintrc.cjs"})
                    end
                }),
            }
        })

        -- set up a vim motion for <Space> + c + f to automatically format our code based on which langauge server is active
        vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "[C]ode [F]ormat" })
    end
}


--Error on line 1 
--run npm @eslint/config@latest and create a new config
