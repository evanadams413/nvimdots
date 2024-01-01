return {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require("bufferline").setup({
            options = {
                close_command = "bdelete! %d",       -- 点击关闭按钮关闭
                right_mouse_command = "bdelete! %d", -- 右键点击关闭
                buffer_close_icon = '',
                modified_icon = '●',
                close_icon = '',
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "File Explorer",
                        text_align = "left",
                        separator = true,
                    },
                    {
                        filetype = "Outline",
                        text = "Symbols Outline",
                        text_align = "left",
                        separator = true,
                    }
                }
            }
        })
    end
}
