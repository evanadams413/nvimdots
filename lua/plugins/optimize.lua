return {
    {
        "romainl/vim-cool",
        config = function()
            vim.cmd([[
                set hlsearch
                let g:cool_total_matches = 1
            ]])
        end
    },
    {
        'andymass/vim-matchup',
        setup = function()
            -- may set any options here
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end
    },
    {
        'gelguy/wilder.nvim',
        config = function()
            local wilder = require('wilder')

            local gradient = {
                '#f4468f', '#fd4a85', '#ff507a', '#ff566f', '#ff5e63',
                '#ff6658', '#ff704e', '#ff7a45', '#ff843d', '#ff9036',
                '#f89b31', '#efa72f', '#e6b32e', '#dcbe30', '#d2c934',
                '#c8d43a', '#bfde43', '#b6e84e', '#aff05b'
            }

            for i, fg in ipairs(gradient) do
                gradient[i] = wilder.make_hl('WilderGradient' .. i, 'Pmenu',
                    { { a = 1 }, { a = 1 }, { foreground = fg } })
            end

            wilder.setup({ modes = { ':', '/', '?' } })
            wilder.set_option('renderer', wilder.wildmenu_renderer({
                -- highlighter applies highlighting to the candidates
                highlights = { gradient = gradient },
                highlighter = wilder.highlighter_with_gradient({
                    wilder.basic_highlighter(), -- or wilder.lua_fzy_highlighter(),
                }),
                separator = ' · ',
                left = { ' ', wilder.wildmenu_spinner(), ' ' },
                right = { ' ', wilder.wildmenu_index() },
            }))
        end,
    },
    {
        "rhysd/clever-f.vim"
    },
    {
        'edluffy/specs.nvim',
        config = function()
            require('specs').setup {
                show_jumps       = true,
                min_jump         = 20,
                popup            = {
                    delay_ms = 0, -- delay before popup displays
                    inc_ms = 10,  -- time increments used for fade/resize effects
                    blend = 10,   -- starting blend, between 0-100 (fully transparent), see :h winblend
                    width = 10,
                    winhl = "PMenu",
                    fader = require('specs').linear_fader,
                    resizer = require('specs').shrink_resizer
                },
                ignore_filetypes = {},
                ignore_buftypes  = {
                    nofile = true,
                },
            }
        end
    },
    {
        'ibhagwan/smartyank.nvim',
        config = function()
            require('smartyank').setup {
                highlight = {
                    enabled = true,        -- highlight yanked text
                    higroup = "IncSearch", -- highlight group of yanked text
                    timeout = 2000,        -- timeout for clearing the highlight
                },
                clipboard = {
                    enabled = true
                },
                tmux = {
                    enabled = true,
                    -- remove `-w` to disable copy to host client's clipboard
                    cmd = { 'tmux', 'set-buffer', '-w' }
                },
                osc52 = {
                    enabled = true,
                    -- escseq = 'tmux',     -- use tmux escape sequence, only enable if
                    -- you're using tmux and have issues (see #4)
                    ssh_only = true,       -- false to OSC52 yank also in local sessions
                    silent = false,        -- true to disable the "n chars copied" echo
                    echo_hl = "Directory", -- highlight group of the OSC52 echo message
                },
                -- By default copy is only triggered by "intentional yanks" where the
                -- user initiated a `y` motion (e.g. `yy`, `yiw`, etc). Set to `false`
                -- if you wish to copy indiscriminately:
                -- validate_yank = false,
                --
                -- For advanced customization set to a lua function returning a boolean
                -- for example, the default condition is:
                -- validate_yank = function() return vim.v.operator == "y" end,
            }
        end
    },
    {
        "max397574/better-escape.nvim",
        config = function()
            require("better_escape").setup {
                mapping = { "jk", "jj" }, -- a table with mappings to use
                timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
                clear_empty_lines = false, -- clear line after escaping if there is only whitespace
                keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
                -- example(recommended)
                -- keys = function()
                --   return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<esc>l' or '<esc>'
                -- end,
            }
        end,
    }
}
