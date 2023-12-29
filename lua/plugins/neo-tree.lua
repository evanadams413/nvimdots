return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        local status, neoTree = pcall(require, "neo-tree")
        if not status then
            vim.notify("没有找到 neo-tree!")
          return
        end

        local list_keys = require('keybindings').neoTreeList

        neoTree.setup({
            close_if_last_window = true,    -- 自动关闭 neo-tree
            popup_border_style = "rounded", -- 弹出式边框样式
            enable_git_status = true,   -- 开启 git 状态
            enable_diagnostics = true,  -- 开启诊断
            open_files_do_not_replace_types = { "terminal", "trouble", "qf" },  -- 排除文件类型
            sort_case_insensitive = false,  -- 文件排列
            default_component_configs = {
                icon = {
                    folder_closed = "",
                    folder_open = "",
                    folder_empty = "",
                    default = "*",
                    highlight = "NeoTreeFileIcon"
                },
                filesystem = {
                    filtered_items = {
                          visible = false, 
                          hide_dotfiles = true,
                          hide_gitignored = true,
                          hide_hidden = true,
                    }
                }
            },
            window = {
                position = "left",
                width = 30,
                mapping_options = {
                    noremap = true,
                    nowait = true,
                },
                mappings = list_keys
            }
        })
    end
}
