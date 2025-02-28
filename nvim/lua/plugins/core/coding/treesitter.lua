return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        opts = {
            -- A list of parser names, or "all" (the listed parsers MUST always be installed)
            ensure_installed = { 'c', 'lua', 'python', 'go', 'vim', 'vimdoc', 'query', 'markdown', 'markdown_inline' },

            sync_install = false,

            auto_install = true,

            ignore_install = {},

            highlight = {
                enable = true,

                additional_vim_regex_highlighting = ensure_installed,
            },
        },
    },
}
