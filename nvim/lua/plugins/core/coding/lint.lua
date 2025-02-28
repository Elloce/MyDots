return {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        require('lint').linters_by_ft = {
            go = { 'trivy' },
            lua = { 'selene' },
        }

        vim.api.nvim_create_autocmd({ 'BufWritePost', 'InsertLeave', 'BufEnter' }, {
            callback = function()
                -- try_lint without arguments runs the linters defined in `linters_by_ft`
                -- for the current filetype
                require('lint').try_lint()
            end,
        })
    end,
}
