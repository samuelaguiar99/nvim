return {
    'tribela/transparent.nvim',
    event = 'VimEnter',
    config = function()
        require("transparent").setup({ -- Optional, you don't have to run setup.
            groups = {           -- table: default groups
                "Normal",
                "NormalNC",
                "Comment",
                "Constant",
                "Special",
                "Identifier",
                "Statement",
                "PreProc",
                "Type",
                "Underlined",
                "Todo",
                "String",
                "Function",
                "Conditional",
                "Repeat",
                "Operator",
                "Structure",
                "LineNr",
                "NonText",
                "SignColumn",
                --"CursorLine",
                --"CursorLineNr",
                "StatusLine",
                "StatusLineNC",
                "EndOfBuffer",
                "NvimTreeWinSeparator",
            },
            extra_groups = {
                'NormalFloat', -- plugins which have float panel such as Lazy, Mason, LspInfo
                'FloatBorder',
                'NvimTreeWinSeparator',
                'NvimTreeNormal',
                'NvimTreeNormalNC',
                'TroubleNormal',
                'TelescopeNormal',
                'TelescopeBorder',
                'WhichKeyFloat',

                -- TODO: programmatically add this
                'NotifyINFOBody',
                'NotifyERRORBody',
                'NotifyWARNBody',
                'NotifyDEBUGBody',
                'NotifyTRACEBody',
                'NotifyINFOBorder',
                'NotifyERRORBorder',
                'NotifyWARNBorder',
                'NotifyDEBUGBorder',
                'NotifyTRACEBorder',
            },
            exclude_groups = {}, -- table: groups you don't want to clear
        })
    end,

}
