return {
    {
        'echasnovski/mini.nvim',
        version = '*',
        event = 'VimEnter',
        --   dependencies = { 'nvim-tree/nvim-web-devicons', opts = {} },
        keys = {
            { '<A-/>', '<cmd>bn<cr>', desc = 'Next buffer' },
            { '<A-.>', '<cmd>bp<cr>', desc = 'Previous buffer' },
            { '<A-ESC>', '<cmd>bd<cr>', desc = 'unloads buffer' },
            { '<C-o>', '<cmd>lua MiniFiles.open()<cr>' },
            { 'Gs', '<cmd>Git status<cr>' },
            { 'Ga', '<cmd>Git add .<cr>' },
            { 'Gc', '<cmd>Git commit<cr>' },
            { 'Gd', '<cmd>lua MiniDiff.toggle_overlay()<cr>' },
        },
        config = function()
            require('mini.pairs').setup({})
            require('mini.files').setup({})
            require('mini.surround').setup({})
            require('mini.git').setup({})
            require('mini.diff').setup({
                view = {
                    style = 'sign',
                    signs = { add = '+', change = '~', delete = '-' },
                },
            })
        end,
    },
}
