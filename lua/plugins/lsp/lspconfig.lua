local status, lspconfig = pcall(require, "lspconfig")
if not status then
    vim.notify("没有找到 lspconfig!")
    return
end

local navbuddy = require("nvim-navbuddy")
local on_attach = function(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end

    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ async = true })
            end,
        })
    end

    navbuddy.attach(client, bufnr)
end

lspconfig.lua_ls.setup({})
lspconfig.jsonls.setup({})
lspconfig.clangd.setup({
    on_attach = on_attach,
})
lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
        -- vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set({ 'n', 'v' }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
        -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opts)
        vim.keymap.set('n', '<C-f>', function()
            vim.lsp.buf.format { async = true }
        end, opts)
        -- diagnostic
        vim.keymap.set("n", "gp", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
        vim.keymap.set("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
        vim.keymap.set("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
    end,
})
