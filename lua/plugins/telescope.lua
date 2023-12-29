return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
        },
        config = function()
            local status, telescope = pcall(require, "telescope")
            if not status then
                vim.notify("没有找到 telescope")
                return
            end

            telescope.setup {
                defaults = {
                    -- 打开弹窗后进入的初始模式，默认为 insert，也可以是 normal
                    initial_mode = "insert",
                    mappings = require("keybindings").telescopeList,
                    prompt_prefix = " ",
                    selection_caret = " ",
                    preview = {
                        mime_hook = function(filepath, bufnr, opts)
                            local is_image = function(filepath)
                                local image_extensions = { 'png', 'jpg' } -- Supported image formats
                                local split_path = vim.split(filepath:lower(), '.', { plain = true })
                                local extension = split_path[#split_path]
                                return vim.tbl_contains(image_extensions, extension)
                            end
                            if is_image(filepath) then
                                local term = vim.api.nvim_open_term(bufnr, {})
                                local function send_output(_, data, _)
                                    for _, d in ipairs(data) do
                                        vim.api.nvim_chan_send(term, d .. '\r\n')
                                    end
                                end
                                vim.fn.jobstart(
                                    {
                                        'catimg', filepath -- Terminal image viewer command
                                    },
                                    { on_stdout = send_output, stdout_buffered = true, pty = true })
                            else
                                require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid,
                                    "Binary cannot be previewed")
                            end
                        end
                    },
                },
                pickers = {
                    -- 内置 pickers 配置
                    find_files = {
                        -- 查找文件换皮肤，支持的参数有： dropdown, cursor, ivy
                        theme = "dropdown",
                        previewer = false,
                        find_command = { "fd", "-H", "-I" },
                    },
                },
                extensions = {
                    -- 扩展插件配置
                }
            }
        end,
    }
}
