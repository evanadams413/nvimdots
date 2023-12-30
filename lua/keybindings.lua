--  _  __          ____  _           _ _
-- | |/ /___ _   _| __ )(_)_ __   __| (_)_ __   __ _ ___
-- | ' // _ \ | | |  _ \| | '_ \ / _` | | '_ \ / _` / __|
-- | . \  __/ |_| | |_) | | | | | (_| | | | | | (_| \__ \
-- |_|\_\___|\__, |____/|_|_| |_|\__,_|_|_| |_|\__, |___/
--           |___/                             |___/

local map = vim.api.nvim_set_keymap
-- 复用 opt 参数
local opt = { noremap = true, silent = true }

-- ======================================
-- =============== NORMAL ===============
-- ======================================

-- Cursor move
map("n", "H", "^", opt)
map("n", "L", "$", opt)

-- Split window
map("n", "s", "", opt)
map("n", "sv", ":split<CR>", opt)
map("n", "ss", ":vsplit<CR>", opt)
map("n", "sc", ":close<CR>", opt)
map("n", "so", ":only<CR>", opt)
map("n", "s=", "<C-w>=", opt)
map("n", "<C-h>", "<C-W>h", opt)
map("n", "<C-l>", "<C-W>l", opt)
map("n", "<C-j>", "<C-W>j", opt)
map("n", "<C-k>", "<C-W>k", opt)
map("n", "<left>", ":vertical resize -20<CR>", opt)
map("n", "<right>", ":vertical resize +20<CR>", opt)
map("n", "<down>", ":resize +10<CR>", opt)
map("n", "<up>", ":resize -10<CR>", opt)

-- Tab
map("n", "tt", ":tabs<CR>", opt)
map("n", "tn", ":tabnew<CR>", opt)
map("n", "mt", ":tabmove +1<CR>", opt)
map("n", "mT", ":tabmove -1<CR>", opt)
map("n", "tc", ":tabclose<CR>", opt)
map("n", "to", ":tabonly<CR>", opt)

-- Copy & Paste
map("n", "ck", "ci(", opt)
map("n", "cd", "ca{", opt)
map("n", "cz", "ci[", opt)
map("n", "cs", 'ci"', opt)
map("n", "<C-a>", "ggVG", opt)
-- map("v", "<C-c>", "\"+y", opt)

-- Find
map("n", "fs", "f\"", opt)
map("n", "fk", "f(", opt)
map("n", "fK", "f)", opt)

-- Other
map("n", ";", ":", opt)
map("n", "U", "<C-r>", opt)

-- ======================================
-- =============== INSERT ===============
-- ======================================

-- map("i", "jk", "<ESC>", opt)

-- ======================================
-- =============== VISUAL ===============
-- ======================================

-- Cursor move
map("v", "H", "^", opt)
map("v", "L", "$<left>", opt)

-- visual模式下缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)
-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)

-- ======================================
-- =============== COMMAND ==============
-- ======================================

map("c", "<C-j>", "<t_Kd>", opt)
map("c", "<C-k>", "<t_Ku>", opt)
map("c", "<C-a>", "<Home>", opt)
map("c", "<C-e>", "<End>", opt)

-- ======================================
-- =============== SCRIPT ==============
-- ======================================

map('n', '<leader>yy', '<cmd>lua require(\'SCRIPT.md\').markdownCopyPlus()<CR>', opt)



--  _  __                                    ____  _             _
-- | |/ /___ _   _ _ __ ___   __ _ _ __  ___|  _ \| |_   _  __ _(_)_ __
-- | ' // _ \ | | | '_ ` _ \ / _` | '_ \/ __| |_) | | | | |/ _` | | '_ \
-- | . \  __/ |_| | | | | | | (_| | |_) \__ \  __/| | |_| | (_| | | | | |
-- |_|\_\___|\__, |_| |_| |_|\__,_| .__/|___/_|   |_|\__,_|\__, |_|_| |_|
--           |___/                |_|                      |___/

-- ===============================================
-- ================ PluginStartup ================
-- ===============================================

-- neo-tree
map('n', '<leader>e', ':Neotree toggle<CR>', opt)
map('n', '<leader>b', ':Neotree buffers reveal float<CR>', opt)

-- telescope
map("n", "<leader>ff", ":Telescope find_files<CR>", opt)
-- map("n", "<leader>fg", ":Telescope live_grep<CR>", opt)
map("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", opt)
map("n", "<leader>fo", ":Telescope oldfiles<CR>", opt)
map("n", "<leader>fb", [[<cmd>lua require('telescope.builtin').buffers()<cr>]], opt)

-- bufferline
map("n", "bk", ":BufferLineCyclePrev<CR>", opt)
map("n", "bj", ":BufferLineCycleNext<CR>", opt)
map("n", "bc", ":BufferLinePickClose<CR>", opt)
map("n", "bch", ":BufferLineCloseLeft<CR>", opt)
map("n", "bcl", ":BufferLineCloseRight<CR>", opt)
map("n", "bco", ":BufferLinePickCloseOther<CR>", opt)
map("n", "bmj", ":BufferLinePickMovePrev<CR>", opt)
map("n", "bmk", ":BufferLinePickMoveNext<CR>", opt)

map("n", "<C-w>", ":Bdelete!<CR>", opt)

-- choosewin
map("n", "-", "<Plug>(choosewin)", opt)

-- repeat
map("n", "'", "<Plug>(clever-f-repeat-forward)", opt)
map("n", "\"", "<Plug>(clever-f-repeat-back)", opt)
map("v", "'", "<Plug>(clever-f-repeat-forward)", opt)
map("v", "\"", "<Plug>(clever-f-repeat-back)", opt)

map("n", "1", "%", opt)
map("v", "1", "%", opt)

-- ===============================================
-- ================ PluginConfig =================
-- ===============================================

local pluginKeys = {}

pluginKeys.neoTreeList = {
    ["l"] = "open",
    ["L"] = "open_tabnew",
    ["<2-LeftMouse>"] = "open",
    ["<ESC>"] = "cancel",
    ["d"] = "delete",
    ["r"] = "rename",
    ["y"] = "copy_to_clipboard",
    ["x"] = "cut_to_clipboard",
    ["p"] = "paste_from_clipboard",
    ["?"] = "show_help",
    ["i"] = "show_file_details",
    ["q"] = "close_window",
    ["A"] = "add_directory",
    ["a"] = {
        "add",
        config = {
            show_path = "relative" -- "none", "relative", "absolute"
        }
    },
    ["S"] = "open_split",
    ["s"] = "open_vsplit",
    ["m"] = "move",
    ["R"] = "refresh",
    -- follow_current_file
    ["."] = "set_root",
    ["H"] = "toggle_hidden",
    ["/"] = "fuzzy_finder",
}

pluginKeys.telescopeList = {
    i = {
        -- 上下移动
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
        ["<Down>"] = "move_selection_next",
        ["<Up>"] = "move_selection_previous",
        -- 历史记录
        ["<C-n>"] = "cycle_history_next",
        ["<C-p>"] = "cycle_history_prev",
        -- 关闭窗口
        ["<C-c>"] = "close",
        -- 预览窗口上下滚动
        ["<C-u>"] = "preview_scrolling_up",
        ["<C-d>"] = "preview_scrolling_down",
    },
}

return pluginKeys
