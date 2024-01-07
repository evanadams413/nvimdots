return {
    {
        "williamboman/mason.nvim",
        dependencies = "williamboman/mason-lspconfig.nvim",
        config = function()
            require("plugins.lsp.mason")
        end
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            { "antosha417/nvim-lsp-file-operations", config = true },
        },
        config = function()
            require("plugins.lsp.lspconfig")
        end
    },
    {
        'linrongbin16/lsp-progress.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require("plugins.lsp.lsp-progress")
        end
    },
    {
        "onsails/lspkind.nvim",
        config = function()
            require("plugins.lsp.lspkind")
        end
    },
    {
        "kkharji/lspsaga.nvim",
        config = function()
            require("plugins.lsp.lspsaga")
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            -- "nvim-treesitter/nvim-treesitter-context",
        },
        run = ":TSUpdate",
        config = function()
            require("plugins.lsp.nvim-treesitter")
        end,
    },
    {
        "SmiteshP/nvim-navic",
        config = function()
            require("plugins.lsp.nvim-navic")
        end
    },
    {
        "utilyre/barbecue.nvim",
        tag = "*",
        requires = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        after = "nvim-web-devicons",       -- keep this if you're using NvChad
        config = function()
            require("plugins.lsp.barbecue")
        end,
    },
    -- {
    --     "SmiteshP/nvim-navbuddy",
    --     dependencies = {
    --         "SmiteshP/nvim-navic",
    --         "MunifTanjim/nui.nvim"
    --     },
    --     config = function()
    --         require("plugins.lsp.nvim-navbuddy")
    --     end
    -- },
    {
        "simrat39/rust-tools.nvim"
    },
    {
        'liuchengxu/vista.vim',
        config = function()
            vim.cmd([[
                let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
                let g:vista_default_executive = 'ctags'
                let g:vista_executive_for = {
                  \ 'cpp': 'vim_lsp',
                  \ 'php': 'vim_lsp',
                  \ }
                let g:vista_ctags_cmd = {
                      \ 'haskell': 'hasktags -x -o - -c',
                      \ }
                let g:vista_fzf_preview = ['right:50%']
                let g:vista#renderer#enable_icon = 1
            ]])
        end
    }
}
