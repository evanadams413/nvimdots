local status, mason = pcall(require, "mason")
if not status then
    vim.notify("没有找到 mason!")
    return
end

mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

local status, masonLspConfig = pcall(require, "mason-lspconfig")
if not status then
    vim.notify("没有找到 mason-lspconfig!")
    return
end

masonLspConfig.setup({
    ensure_installed = { "lua_ls", "clangd", "jsonls", "marksman", "rust_analyzer" },
    automatic_installation = true,
})
