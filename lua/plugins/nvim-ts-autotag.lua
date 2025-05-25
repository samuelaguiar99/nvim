#Enable auto-close tags for HTML files & Javascript
return {
    "windwp/nvim-ts-autotag" , 
    ft = { "html" , "xml" , "javascript" , "typescript" , "javascriptreact" , "typescriptreact" , "svelte" },
    config = function ()
        require("nvim-ts-autotag").setup({
            opts = {
                enable_close = true , 
                enable_rename = true , 
                enable_close_on_slash = false , 
            },
            per_filetype = {
                ["html"] = {
                    enable_close = true , 
                },
                ["typescriptreact"] = {
                    enable_close = true , 
                }
            }
        })
    end

}
