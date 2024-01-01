return {
    {
        'simrat39/symbols-outline.nvim',
        config = function()
            require("symbols-outline").setup({
                auto_close = true,
                keymaps = {},
                width = 25,
                symbols = {
                    icon_fetcher = function(k)
                        if k == 'Package' then
                            return ""
                        end
                        return false
                    end,
                    icon_source = 'lspkind',
                }
            })
        end
    }
}
