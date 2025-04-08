return {
    "elmcgill/springboot-nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "mfussenegger/nvim-jdtls"
    },
    config = function()
        -- gain acces to the springboot nvim plugin and its functions
        local springboot_nvim = require("springboot-nvim")

        -- set a vim motion to <Space> + <Shift>J + r to run the spring boot project in a vim terminal
        vim.keymap.set('n', '<leader>Jr', springboot_nvim.boot_run, {desc = "[J]ava [R]un Spring Boot"})
        -- set a vim motion to <Space> + <Shift>J + c to open the generate class ui to create a class
        vim.keymap.set('n', '<leader>Jc', springboot_nvim.generate_class, {desc = "[J]ava Create [C]lass"})
        -- set a vim motion to <Space> + <Shift>J + i to open the generate interface ui to create an interface
        vim.keymap.set('n', '<leader>Ji', springboot_nvim.generate_interface, {desc = "[J]ava Create [I]nterface"})
        -- set a vim motion to <Space> + <Shift>J + e to open the generate enum ui to create an enum
        vim.keymap.set('n', '<leader>Je', springboot_nvim.generate_enum, {desc = "[J]ava Create [E]num"})

        -- run the setup function with default configuration
        springboot_nvim.setup({})
    end
}



--[[

To fix the fact that the plugin cannot handle spaces in filename , change 
\home\samuel\.local\share\nvim\lazy\springboot-nvim\lua\springboot-nvim/utils.lua ( function find_main_application_class_directory )

Basically , we're englobing the whole path into a string so that the find command doesnt break

local function find_main_application_class_directory(root_path)
    local main_class_pattern = '@SpringBootApplication'
    local java_file_pattern = '*.java'

    -- Quote the root_path to handle spaces
    local quoted_root = '"' .. root_path .. '"'

    local search_cmd = 'find ' .. quoted_root .. ' -type f -name "' .. java_file_pattern .. '" -exec grep -l "' .. main_class_pattern .. '" {} +'
    local result = vim.fn.systemlist(search_cmd)

    if not vim.tbl_isempty(result) then
        local first_file_path = result[1] -- Assuming there's only one main application class
        local directory = vim.fn.fnamemodify(first_file_path, ':h')
        return directory
    else
        print('Main application class not found in the project directory.')
    end
end

]]--