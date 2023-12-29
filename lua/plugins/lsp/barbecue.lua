-- triggers CursorHold event faster
vim.opt.updatetime = 200

require("barbecue").setup({
    create_autocmd = false, -- prevent barbecue from updating itself automatically
})

vim.api.nvim_create_autocmd({
    "WinScrolled", -- or WinResized on NVIM-v0.9 and higher
    "BufWinEnter",
    "CursorHold",
    "InsertLeave",

    -- include this if you have set `show_modified` to `true`
    "BufModifiedSet",
}, {
    group = vim.api.nvim_create_augroup("barbecue.updater", {}),
    callback = function()
        require("barbecue.ui").update()
    end,
})

require("barbecue").setup({
    attach_navic = false,
    show_dirname = false,
    show_basename = false,
    symbols = {
        modified = "●",

        ellipsis = "…",

        separator = "",
    },
})

require("barbecue.ui").toggle(true)
require("barbecue.ui").update(winnr)
require("barbecue.ui").navigate(index, winnr)
