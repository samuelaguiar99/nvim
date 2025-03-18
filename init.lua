-- Declare path where lazy will clone plugin code
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"



-- Check to see if lazy itself has been cloned , if not clone it into the lazy.nvim directory
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({"git" , "clone" , "--filter=blob:none" , "--branch=stable" , lazyrepo , lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
        {"Failed to close lazy.nvim:\n" , "ErrorMsg"},
        {out , "WarningMsg"},
        {"\nPress any key to exit..."},
            }, true , {})
            vim.fn.getchar()
            os.exit(1)
    end
end


--Declare a few options for lazy
local opts = {
    change_detection = {
        --Dont notifity us every time a change is made to the configuration
        notify = false
    },

    checker = {
        --Automatically check for package updates
        enabled = true,
        --Don't spam us with notifications every time there is an update available
        notify = false
    }
}
 
-- Add the path to the lazy plugin repositories to the vim runtime path
vim.opt.rtp:prepend(lazypath)



require("config.options")
require("config.keymaps")
require("config.autocmds")
--Setup lazy ( ALWAYS LAST ) 
--Tells lazy that all plugins are under the plugins directory
--and the options to apply from lazy to all plugins
require("lazy").setup("plugins",opts)


