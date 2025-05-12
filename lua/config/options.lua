--Left column and similar settings
vim.opt.number = true	--display line numbers
vim.opt.relativenumber = true -- display relative line numbers
vim.opt.numberwidth = 2 --set width of line number column * to revisit *
vim.opt.signcolumn = "yes"
vim.opt.wrap = false --display lines in single line
vim.opt.scrolloff = 10  --number of lines to keep above / below cursor
vim.opt.sidescrolloff = 8 --number of columns to keeps to the left /right of cursor
vim.opt.cursorline=true


--Tab spacing / behaviour
vim.opt.expandtab = true --convert tabs to spaces
vim.opt.shiftwidth = 4 --number of spaces inserted for each indentation level
vim.opt.tabstop = 4 -- number of spaces inserted for each tab character
vim.opt.softtabstop = 4 -- number of spaces inserted for <Tab> key
vim.opt.smartindent = true --enable start indentation
vim.opt.breakindent = true --enable line breaking indentation


--General behaviour
vim.g.loaded_netrw = 1 --disable netrw ( explorer ) 
vim.g.loaded_netrwPlugin = 1 --disable netrw
vim.opt.backup = false --disable backup file creation
vim.opt.clipboard = "unnamedplus" --enable system clipboard access
vim.opt.conceallevel = 0 --show concealed charactrs in markdown files
vim.opt.fileencoding = "utf-8" --set file encoding to UTF-8
vim.opt.mouse = "a" --enable mouse support
vim.opt.splitbelow = true --force horizontal splits below current window
vim.opt.splitright = true --force vertical splits right of current window
vim.opt.termguicolors = true  --enable term GUI colors
--vim.opt.undofile = true --enable persistent undo
vim.opt.writebackup =  false -- prevent editing of files being edited elsewhere
vim.opt.updatetime=50

--Searching behaviours
vim.opt.ignorecase = true --ignore case in search
vim.opt.smartcase = true --match case if explicitly stated

--Others
vim.opt.pumheight = 10 -- Set max number of completion suggestions to 6



