return {
    {
        'nvimdev/dashboard-nvim',
        dependencies = { { 'nvim-tree/nvim-web-devicons' } },
        event = 'VimEnter',
        config = function()
            local status, db = pcall(require, "dashboard")
            if not status then
                vim.notify("没有找到 dashboard")
                return
            end

            require('dashboard').setup({
                theme = 'Hyper',
                config = {
                    week_header = {
                        enable = true,
                    },
                    shortcut = {
                        {
                            desc = ' Github',
                            group = '@property',
                            action = 'edit ~/.config/nvim/init.lua',
                            key = 'g'
                        },
                        {
                            icon = ' ',
                            icon_hl = '@variable',
                            desc = 'Files',
                            group = 'Label',
                            action = 'Telescope find_files',
                            key = 'f',
                        },
                        {
                            desc = ' Projects',
                            group = 'DiagnosticHint',
                            action = 'Telescope projects',
                            key = 'p',
                        },
                        {
                            desc = ' Oldfiles',
                            group = 'Number',
                            action = 'Telescope oldfiles',
                            key = 'o',
                        },
                    },
                },
            })
        end
    }
}
