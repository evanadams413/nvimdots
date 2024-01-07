return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        'linrongbin16/lsp-progress.nvim',
    },
    config = function()
        local status, lualine = pcall(require, "lualine")
        if not status then
            vim.notify("没有找到 lualine!")
            return
        end

        local mode_map = {
            ['NORMAL'] = 'N',
            ['O-PENDING'] = 'N?',
            ['INSERT'] = 'I',
            ['VISUAL'] = 'V',
            ['V-BLOCK'] = 'VB',
            ['V-LINE'] = 'VL',
            ['V-REPLACE'] = 'VR',
            ['REPLACE'] = 'R',
            ['COMMAND'] = '!',
            ['SHELL'] = 'SH',
            ['TERMINAL'] = 'T',
            ['EX'] = 'X',
            ['S-BLOCK'] = 'SB',
            ['S-LINE'] = 'SL',
            ['SELECT'] = 'S',
            ['CONFIRM'] = 'Y?',
            ['MORE'] = 'M',
        }
        local progress = function()
            local current_line = vim.fn.line(".")
            local total_lines = vim.fn.line("$")
            local chars = { " ", " ", " ", " ", " " }
            -- local chars = { "██", "▇▇", "▆▆", "▅▅", "▄▄", "▃▃", "▂▂", "▁▁", " ", }
            local line_ratio = current_line / total_lines
            local index = math.ceil(line_ratio * #chars)
            return chars[index]
        end

        lualine.setup({
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = { left = '', right = '' },
                -- section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                },
                disabled_filetypes = { 'packer', 'neo-tree', 'Outline', 'vista' }
            },
            sections = {
                lualine_a = { { 'mode',
                    -- fmt = function(s) return mode_map[s] or s end
                } },
                lualine_b = {
                    'branch',
                    'diff',
                    {
                        'diagnostics',
                        sources = { 'nvim_diagnostic' },
                        symbols = { error = ' ', warn = ' ', info = ' ' },
                    }
                },
                lualine_c = {
                    'filename',
                    require('lsp-progress').progress,
                },
                lualine_x = { 'encoding', 'fileformat', 'filetype' },
                lualine_y = { progress },
                lualine_z = { 'location' }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            -- winbar = {
            --     lualine_c = {
            --         {
            --             "navic",
            --         }
            --     }
            -- },
            inactive_winbar = {},
            extensions = {}
        })
        -- 监听 lsp-progress 事件并刷新 lualine
        vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
        vim.api.nvim_create_autocmd("User", {
            group = "lualine_augroup",
            pattern = "LspProgressStatusUpdated",
            callback = require("lualine").refresh,
        })
    end
}
