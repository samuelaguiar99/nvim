return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		local eslint = lint.linters.eslint_d

		-- if Eslint error configuration not found : change MasonInstall eslint@version or npm i -g eslint at a specific version
		lint.linters_by_ft = {
			javascript = {"eslint_d"},
			typescript = {"eslint_d"},
			javascriptreact = {"eslint_d"},
			typescriptreact = {"eslint_d"},
			svelte = { "eslint_d" },
			python = { "pylint" },
		}

		eslint.args = {
			"--no-warn-ignored",
			"--format",
			"json",
			"--stdin",
			"--stdin-filename",
			function()
                return vim.fn.expand("%:p")
			end,
		}

		local function find_nearest_node_modules_dir()
            -- current buffer dir
            local current_dir = vim.fn.expand('%:p:h')
            while current_dir ~= "/" do
                if vim.fn.isdirectory(current_dir .. "/node_modules") == 1 then
                    return current_dir
                end
                current_dir = vim.fn.fnamemodify(current_dir, ":h")
            end
            return nil
        end

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                local ft = vim.bo.filetype
                local js_types = { "javascript", "typescript", "javascriptreact", "typescriptreact" }
                if not vim.tbl_contains(js_types, ft) then
                    lint.try_lint()
                    return
                end
                local original_cwd = vim.fn.getcwd()
                local node_modules_dir = find_nearest_node_modules_dir()
                if node_modules_dir then
                    vim.cmd("cd " .. node_modules_dir)
                end
                lint.try_lint()
                vim.cmd("cd " .. original_cwd)
            end,
        })

		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "[L]int current buffer" })
	end,
}
