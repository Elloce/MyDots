vim.g.mapleader = ' '

vim.cmd 'set path+=**'

vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.swapfile = false

vim.opt.tabstop = 4

vim.opt.number = true
vim.opt.wrap = false
--vim.cmd [[highlight cursorline gui=bold guifg=green guibg=red]]
--vim.cmd [[highlight CursorColumn gui=bold guifg=red guibg=red]]
--vim.cmd [[highlight Visual gui=bold guifg=None guibg=purple]]

vim.keymap.set('n', '<leader>x', '<cmd>so %<cr>', { desc = 'source current file' })
