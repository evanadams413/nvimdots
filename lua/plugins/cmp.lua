return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            'hrsh7th/vim-vsnip',
            'hrsh7th/cmp-vsnip',
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
            "chrisgrieser/cmp_yanky",
            "hrsh7th/cmp-emoji",
            "windwp/nvim-autopairs",
        },
        config = function()
            -- if opts then require("luasnip").config.setup(opts) end
            -- vim.tbl_map(
            --     function(type) require("luasnip.loaders.from_" .. type).lazy_load() end,
            --     { "vscode", "snipmate", "lua" }
            -- )

            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            local cmp = require('cmp')
            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )

            local luasnip = require("luasnip")

            local lspkind = require("lspkind")

            local lspkind_comparator = function(conf)
                local lsp_types = require('cmp.types').lsp
                return function(entry1, entry2)
                    if entry1.source.name ~= 'nvim_lsp' then
                        if entry2.source.name == 'nvim_lsp' then
                            return false
                        else
                            return nil
                        end
                    end
                    local kind1 = lsp_types.CompletionItemKind[entry1:get_kind()]
                    local kind2 = lsp_types.CompletionItemKind[entry2:get_kind()]

                    local priority1 = conf.kind_priority[kind1] or 0
                    local priority2 = conf.kind_priority[kind2] or 0
                    if priority1 == priority2 then
                        return nil
                    end
                    return priority2 < priority1
                end
            end

            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and
                    vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            require("luasnip.loaders.from_vscode").lazy_load() -- load friendly-snippets
            require("luasnip.loaders.from_vscode").load({
                paths = {                                      -- load custom snippets
                    vim.fn.stdpath("config") .. "/snippets"
                }
            }) -- Load snippets from my-snippets folder

            cmp.setup({
                completion = {
                    completeopt = "menu,menuone,preview, noselect",
                },
                snippet = { -- configure how nvim-cmp interacts with snippet engine
                    expand = function(args)
                        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = {
                    ["<Tab>"] = function(fallback)
                        if cmp.visible() then
                            if #cmp.get_entries() == 1 then
                                cmp.confirm({ select = true })
                            else
                                cmp.select_next_item()
                            end
                        elseif has_words_before() then
                            cmp.complete()
                            if #cmp.get_entries() == 1 then
                                cmp.confirm({ select = true })
                            end
                        else
                            fallback()
                        end
                    end,
                    ["<S-Tab>"] = function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end,
                    -- ["<Tab>"] = function(fallback)
                    --     -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
                    --     if cmp.visible() then
                    --         local entry = cmp.get_selected_entry()
                    --         if not entry then
                    --             cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                    --         else
                    --             cmp.confirm()
                    --         end
                    --     else
                    --         fallback()
                    --     end
                    -- end,
                    ["<C-k>"] = cmp.mapping.select_prev_item(),
                    ["<C-j>"] = cmp.mapping.select_next_item(),
                    ["<C-e>"] = cmp.mapping.close(),
                    -- ["<Space>"] = function(fallback)
                    --     if cmp.visible() then
                    --         local entry = cmp.get_selected_entry()
                    --         if not entry then
                    --             fallback()
                    --         else
                    --             cmp.confirm()
                    --             fallback()
                    --         end
                    --     else
                    --         fallback()
                    --     end
                    -- end,
                    ["<CR>"] = cmp.mapping({
                        i = function(fallback)
                            if cmp.visible() and cmp.get_active_entry() then
                                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                            else
                                fallback()
                            end
                        end,
                    }),
                },
                -- sources for autocompletion
                sources = cmp.config.sources({
                    { name = "luasnip" }, -- snippets
                    { name = "nvim_lsp" },
                    { name = 'vsnip' },   -- For vsnip users.
                    -- { name = 'ultisnips' }, -- For ultisnips users.
                    -- { name = 'snippy' }, -- For snippy users.
                    { name = 'emoji' },
                    { name = "buffer" }, -- text within current buffer
                    { name = "path" },   -- file system paths
                }),
                -- configure lspkind for vs-code like pictograms in completion menu
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = lspkind.cmp_format({
                        mode = 'symbol',
                        maxwidth = 50,
                        ellipsis_char = '...',

                        before = function(entry, vim_item)
                            local source = entry.source.name
                            vim_item.menu = "(" .. source .. ")"
                            if source == "luasnip" or source == "vsnip" or source == "nvim_lsp" then
                                vim_item.dup = 0
                            end
                            return vim_item
                        end
                    }),
                },
                sorting = {
                    comparators = {
                        cmp.config.compare.exact,
                        cmp.config.compare.recently_used,
                        -- lspkind_comparator({
                        --     kind_priority = {
                        --         Field = 11,
                        --         Property = 11,
                        --         Constant = 10,
                        --         Enum = 10,
                        --         EnumMember = 10,
                        --         Event = 10,
                        --         Function = 10,
                        --         Method = 10,
                        --         Operator = 10,
                        --         Reference = 10,
                        --         Struct = 10,
                        --         Variable = 9,
                        --         File = 8,
                        --         Folder = 8,
                        --         Class = 5,
                        --         Color = 5,
                        --         Module = 5,
                        --         Keyword = 2,
                        --         Constructor = 1,
                        --         Interface = 1,
                        --         Snippet = 0,
                        --         Text = 1,
                        --         TypeParameter = 1,
                        --         Unit = 1,
                        --         Value = 1,
                        --     },
                        -- }),
                    },
                },
                experimental = {
                    native_menu = false,
                    ghost_text = false,
                },
            })
        end,
    }
}
