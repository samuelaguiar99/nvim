-- https://www.youtube.com/watch?v=zbpF3te0M3g

local mason_packages_path = vim.fn.expand("$MASON/packages")

-- Automatically attach normal jars along with sources/javadoc if available
local function get_all_m2_jars_with_sources()
    local m2 = vim.fn.expand("~/.m2/repository")
    local jars = vim.fn.glob(m2 .. "/**/*.jar", 1, 1)
    local libraries = {}

    for _, jar in ipairs(jars) do
        -- Skip sources and javadoc jars themselves
        if not jar:match("sources%.jar$") and not jar:match("javadoc%.jar$") then
            local base = jar:gsub("%.jar$", "")
            local sources = base .. "-sources.jar"
            local javadoc = base .. "-javadoc.jar"

            table.insert(libraries, {
                name = jar,
                sources = vim.fn.filereadable(sources) == 1 and sources or nil,
                javadoc = vim.fn.filereadable(javadoc) == 1 and javadoc or nil,
            })
        end
    end

    return libraries
end


local function get_jdtls_client(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    for _, client in pairs(vim.lsp.get_active_clients({bufnr = bufnr})) do
        if client.name == "jdtls" then
            return client
        end
    end
    return nil
end


function get_jdtls()
    local jdtls_path = mason_packages_path .. "/jdtls"
    local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
    local SYSTEM = "linux" -- change if needed
    local config = jdtls_path .. "/config_" .. SYSTEM
    local lombok = jdtls_path .. "/lombok.jar"
    return launcher, config, lombok
end

local function get_bundles()
    local java_debug_path = mason_packages_path .. "/java-debug-adapter"
    local bundles = {
        vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", 1),
    }
    local java_test_path = mason_packages_path .. "/java-test"
    vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar", 1), "\n"))
    return bundles
end

local function get_workspace()
    local home = os.getenv "HOME"
    local workspace_path = home .. "/code/workspace/"
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    return workspace_path .. project_name
end

local function java_keymaps()
    vim.cmd(
    "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)")
    vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
    vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")
    vim.cmd("command! -buffer JdtJshell lua require('jdtls').jshell()")

    vim.keymap.set('n', '<leader>Jo', "<Cmd> lua require('jdtls').organize_imports()<CR>",
        { desc = "[J]ava [O]rganize Imports" })
    vim.keymap.set('n', '<leader>Jv', "<Cmd> lua require('jdtls').extract_variable()<CR>",
        { desc = "[J]ava Extract [V]ariable" })
    vim.keymap.set('v', '<leader>Jv', "<Esc><Cmd> lua require('jdtls').extract_variable(true)<CR>",
        { desc = "[J]ava Extract [V]ariable" })
    vim.keymap.set('n', '<leader>JC', "<Cmd> lua require('jdtls').extract_constant()<CR>",
        { desc = "[J]ava Extract [C]onstant" })
    vim.keymap.set('v', '<leader>JC', "<Esc><Cmd> lua require('jdtls').extract_constant(true)<CR>",
        { desc = "[J]ava Extract [C]onstant" })
    vim.keymap.set('n', '<leader>Jt', "<Cmd> lua require('jdtls').test_nearest_method()<CR>",
        { desc = "[J]ava [T]est Method" })
    vim.keymap.set('v', '<leader>Jt', "<Esc><Cmd> lua require('jdtls').test_nearest_method(true)<CR>",
        { desc = "[J]ava [T]est Method" })
    vim.keymap.set('n', '<leader>JT', "<Cmd> lua require('jdtls').test_class()<CR>", { desc = "[J]ava [T]est Class" })
    vim.keymap.set('n', '<leader>Ju', "<Cmd> JdtUpdateConfig<CR>", { desc = "[J]ava [U]pdate Config" })
end

local function setup_jdtls()
    local jdtls = require "jdtls"
    local launcher, os_config, lombok = get_jdtls()
    local workspace_dir = get_workspace()
    local bundles = get_bundles()
    local root_dir = jdtls.setup.find_root({ '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' })

    local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
    lsp_capabilities.textDocument.completion.completionItem.snippetSupport = true
    lsp_capabilities.textDocument.hover={ dynamicRegistration = true }
    lsp_capabilities.workspace = lsp_capabilities.workspace or {}
    lsp_capabilities.workspace.configuration = true

    local extendedClientCapabilities = jdtls.extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
    extendedClientCapabilities.classFileContentsSupport = true

    local cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-javaagent:' .. lombok,
        '-jar', launcher,
        '-configuration', os_config,
        '-data', workspace_dir
    }

    local settings = {
        java = {
            format = { enabled = true },
            eclipse = { downloadSources = true },
            maven = { downloadSources = true },
            references = { includeDecompiledSources = true },
            import = { gradle = { enabled = true }, maven = { enabled = true } },
            signatureHelp = { enabled = true },
            contentProvider = { preferred = "fernflower" },
            saveActions = { organizeImports = true },
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*",
                },
                filteredTypes = { "com.sun.*", "io.micrometer.shaded.*", "java.awt.*", "jdk.*", "sun.*" },
                importOrder = { "java", "jakarta", "javax", "com", "org" },
            },
            sources = { organizeImports = { starThreshold = 9999, staticThreshold = 9999 } },
            project = {
                importOnFirstTimeStartup = true,
                referencedLibraries = get_all_m2_jars_with_sources(), -- updated here
            },
            codeGeneration = {
                toString = { template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}" },
                hashCodeEquals = { useJava7Objects = true },
                useBlocks = true,
            },
            configuration = {
                runtimes = {
                    { name = "JavaSE-24", path = "/usr/lib/jvm/jdk-24.0.1-oracle-x64", default = true },
                    { name = "JavaSE-21", path = "/usr/lib/jvm/java-21-openjdk-amd64" }
                },
                updateBuildConfiguration = "interactive",
            },
            referencesCodeLens = { enabled = true },
            inlayHints = { parameterNames = { enabled = "all" } },
        },
    }

    local init_options = { bundles = bundles, extendedClientCapabilities = extendedClientCapabilities }

    local on_attach = function(client, bufnr)
        if client.name ~= "jdts" then
            return
        end


        if client.server_capabilities.semanticTokensProvider then
            client.server_capabilities.semanticTokensProvider = nil
        end
        java_keymaps()
        require('jdtls.dap').setup_dap()
        require('jdtls.dap').setup_dap_main_class_configs()
        require 'jdtls.setup'.add_commands()
        vim.lsp.codelens.refresh()
        vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = { "*.java" },
            callback = function() pcall(vim.lsp.codelens.refresh) end,
        })

        --Schedule sources to be downloaded so we have javadoc info
        vim.defer_fn(function()
                if get_jdtls_client(bufnr) then
                    require('jdtls').update_project_config()
                end
            end, 100)
        end

    local config = { cmd = cmd, root_dir = root_dir, settings = settings, capabilities = lsp_capabilities, init_options = init_options, on_attach = on_attach }

    require('jdtls').start_or_attach(config)
end

return { setup_jdtls = setup_jdtls }
