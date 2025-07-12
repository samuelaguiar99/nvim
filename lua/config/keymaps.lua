--Set leader keybinding to <Space>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Better window navigation
vim.keymap.set("n" , "<C-h>"  , "<C-w><C-h>" , {desc = "Move focus to the left window"})
vim.keymap.set("n" , "<C-l>"  , "<C-w><C-l>" , {desc = "Move focus to the right winddow" })
vim.keymap.set("n" , "<C-j>"  , "<C-w><C-j>" , {desc = "Move focus to the lower window "} )
vim.keymap.set("n" , "<C-k>" , "<C-w><C-k>" , {desc = "Move focus to the upper window "} )


--Easily split windows
vim.keymap.set("n" , "<leader>wv"  , ":vsplit<cr>" , {desc = "[W]indow Split [V]ertical "} )
vim.keymap.set("n" , "<leader>wh"  , ":split<cr>"  , {desc = "[W]indow Split [H]orizontal"} )


--Stay in indent mode when indenting
vim.keymap.set("v" , "<" , "<gv" , { desc = "Indent left in visual mode " } )
vim.keymap.set("v" , ">" , ">gv" , { desc = "Indent right in visual mode" } )

--Keep search terms in the middle of the screen while going to next and previous
vim.keymap.set("n" , "n" , "nzzzv")
vim.keymap.set("n" , "N" , "Nzzzv")

--Map <TAB> to go word by word
vim.keymap.set("n" , "<TAB>" , "w"  )
vim.keymap.set("n" , "<S-TAB>" , "W")

--Clear selections when pressing Enter after / command
vim.keymap.set( 'c' , "<CR>" , function () return vim.fn.getcmdtype() == "/" and "<CR>:noh<CR>" or "<CR>" end , { expr = true  , noremap = true })

