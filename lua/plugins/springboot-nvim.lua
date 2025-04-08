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





Also change function generate_class in \home\samuel\.local\share\nvim\lazy\springboot-nvim\lua\springboot-nvim\generate_class.lua
so that it handles the creation of the class in the correct directory

local function generate_class()
    local file_path = vim.fn.fnamemodify(start_buf, ':p')
    local path_pattern = "(.-)/java"
    local root_path = file_path:match(path_pattern) .. "/java"
    -- Make sure there is content in the class buffer
    local class_lines = api.nvim_buf_get_lines(bufs[4], 0, -1, false)
    local class_content = table.concat(class_lines)
    local package_lines = api.nvim_buf_get_lines(bufs[3], 0, -1, false)
    local base_package_path = table.concat(package_lines)
    local package_path = base_package_path:gsub("%.", "/")
    if (package_path:sub(-1, -1) ~= '/' and package_path ~= '') then
        package_path = package_path .. "/"
    end

    if(class_content ~= '') then
        -- Check the specified package directory to make sure it exists
        if(vim.fn.isdirectory(root_path .. '/' .. package_path) == 1) then
            print("package directory exists")
        else
            -- Make the package directory if it does not exist
            local command = 'mkdir -p ' .. root_path .. '/' .. package_path
			local quoted_command = '"' .. command .. '"'
            os.execute(quoted_command)
        end
        -- Generate the new java file and inject boiler plate
        -- Need to strip and trailing periods from the package
        if(base_package_path:sub(-1, -1) == '.') then
            base_package_path = string.sub(base_package_path, 1, -2)
        end
        local java_file_content = string.format(class_boiler_plate, base_package_path, class_content)
        local java_file = io.open(root_path .. "/" .. package_path .. class_content .. ".java", "r")
        if(java_file) then
            print("Class already exists in package")
            java_file:close()
        else
            java_file = io.open(root_path .. "/" .. package_path .. class_content .. ".java", "w")
            java_file:write(java_file_content)
            java_file:close()
            close_generate_class()
            local path = root_path .. "/" .. package_path .. class_content .. ".java"
            vim.cmd('edit ' .. vim.fn.fnameescape(path))
        end
    else
        print("Please specify a class name to continue")
    end

end

]]--