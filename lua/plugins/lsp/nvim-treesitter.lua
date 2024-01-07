local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
    vim.notify("没有找到 nvim-treesitter")
    return
end

treesitter.setup({
    -- 安装 language parser
    -- :TSInstallInfo 命令查看支持的语言
    ensure_installed = { "c", "cpp", "rust", "vim", "lua" },
    -- 启用代码高亮模块
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    -- 启用增量选择模块
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            node_decremental = "<BS>",
            scope_incremental = "<TAB>",
        },
    },
    -- 启用代码缩进模块 (=)
    indent = {
        enable = true,
    },
})

-- 开启 Folding 模块
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- 默认不要折叠
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
vim.opt.foldlevel = 99

-- require 'treesitter-context'.setup {
--     enable = true,          -- Enable this plugin (Can be enabled/disabled later via commands)
--     max_lines = 0,          -- How many lines the window should span. Values <= 0 mean no limit.
--     min_window_height = 0,  -- Minimum editor window height to enable context. Values <= 0 mean no limit.
--     line_numbers = true,
--     multiline_threshold = 20, -- Maximum number of lines to show for a single context
--     trim_scope = 'outer',   -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
--     mode = 'cursor',        -- Line used to calculate context. Choices: 'cursor', 'topline'
--     -- Separator between context and content. Should be a single character string, like '-'.
--     -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
--     separator = nil,
--     zindex = 20,   -- The Z-index of the context window
--     on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
-- }
