return {
    {
        "lukas-reineke/indent-blankline.nvim",
        dependencies = "HiPhish/rainbow-delimiters.nvim",
        config = function()
            local status, ibl = pcall(require, "ibl")
            if not status then
                vim.notify("没有找到 indent_blankline")
                return
            end

            local highlight = {
                "RainbowRed",
                "RainbowYellow",
                "RainbowBlue",
                "RainbowOrange",
                "RainbowGreen",
                "RainbowViolet",
                "RainbowCyan",
            }
            local hooks = require "ibl.hooks"
            -- create the highlight groups in the highlight setup hook, so they are reset
            -- every time the colorscheme changes
            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
                vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
                vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
                vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
                vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
                vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
                vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
            end)

            vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
            vim.g.indent_blankline_filetype_exclude = {
                "help",
                "startify",
                "dashboard",
                "packer",
                "neogitstatus",
                "neo-tree",
                "Outline",
                "Trouble",
            }
            vim.g.indentLine_enabled = 1
            
            vim.g.rainbow_delimiters = { highlight = highlight }
            ibl.setup({
                indent = { char = "▏" },
                scope = { highlight = highlight }
            })

            hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
        end
    }
}
