return {
    'neovim/nvim-lspconfig',
    dependencies = {
        { 'williamboman/mason.nvim', opts = {} },
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        'williamboman/mason-lspconfig.nvim',
        { 'j-hui/fidget.nvim', opts = {}, 'saghen/blink.cmp' },
    },
    config = function()
        local servers = { lua_ls = {}, gopls = {} }
        local ensure_installed = vim.tbl_keys(servers) or {}
        --local capabilities = require("blink.cmp").get_lsp_capabilities()
        vim.list_extend(ensure_installed, { 'stylua', 'crlfmt', 'trivy', 'selene' })
        require('mason-tool-installer').setup({
            ensure_installed = ensure_installed,
        })
        for k, v in pairs(servers) do
            v.capabilities = require('blink-cmp').get_lsp_capabilities(v.capabilities)
            require('lspconfig')[k].setup(v)
        end
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('elloce-lsp-attach', { clear = true }),
            callback = function(event)
                local c = vim.lsp.get_client_by_id(event.data.client_id)
                if not c then
                    return
                end
                local map = function(key, func, info, mode)
                    mode = mode or 'n'
                    vim.keymap.set(mode, key, func, { buffer = event.buf, desc = 'Lsp: ' .. info })
                end
                map('<leader>ca', function()
                    vim.lsp.buf.code_action()
                end, 'code action')
            end,
        })
    end,
}
