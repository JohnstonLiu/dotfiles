local config = function()
    require('mason').setup()
    require('mason-lspconfig').setup({
        ensure_installed = {
            "lua_ls",
            "rust_analyzer",
            "ts_ls",
            "clangd",
            "basedpyright",
            "eslint",
            "tailwindcss",
        },
    })

    vim.lsp.config('lua_ls', {
        on_init = function(client)
            if client.workspace_folders then
                local path = client.workspace_folders[1].name
                if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc')) then
                    return
                end
            end

            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                runtime = {
                    version = 'LuaJIT'
                },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME
                    }
                }
            })
        end,
        settings = {
            Lua = {}
        }
    })

    vim.lsp.enable({
        'basedpyright',
        'ruff',
        'clangd',
        'gopls',
        'rust_analyzer',
        'cmake',
        'jdtls',
        'eslint',
        'html',
        'ts_ls',
        'tailwindcss',
        'cssls',
        'cssmodules_ls',
        'mdx_analyzer',
        'css_variables',
        'sqlls',
        'dockerls',
        'docker_compose_language_service',
        'lua_ls',
    })
end

return {
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            'williamboman/mason.nvim',
            'neovim/nvim-lspconfig',
        },
        config = config,
    },
}
