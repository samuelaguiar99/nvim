local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local general = augroup("General", { clear = true })


-- Setup our JDTLS server any time we open up a java file
vim.cmd [[
    augroup jdtls_lsp
        autocmd!
        autocmd FileType java lua require'config.jdtls'.setup_jdtls()
    augroup end
]]


--Disable readonly file message when saving automatically
vim.api.nvim_create_autocmd("FileChangedRO", {
  callback = function()
    vim.bo.readonly = false
  end,
  group = general,
  desc = "Disable Readonly Message",
})

--Auto save
autocmd({ "FocusLost", "BufLeave", "BufWinLeave", "InsertLeave" }, {
  -- nested = true, -- for format on save
  callback = function()
    if vim.bo.filetype ~= "" and vim.bo.buftype == "" then
      vim.cmd "silent! w"
    end
  end,
  group = general,
  desc = "Auto Save",
})

autocmd("TextYankPost", {
  callback = function()
    if vim.version().minor >= 11 then
      require("vim.hl").on_yank { higroup = "Visual", timeout = 200 }
    else
      require("vim.highlight").on_yank { higroup = "Visual", timeout = 200 }
    end
  end,
  group = general,
  desc = "Highlight when yanking",
})
