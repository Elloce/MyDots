local config = require('session.config.config')
local util = require('session.util.util')

local M = {}
M.options = {}

M.setup = function(opts)
    M.options = vim.tbl_deep_extend('force', M.options, config.default, opts)
end

local save_session = function() end
vim.api.nvim_create_user_command('Session', function(command)
    util.switch(command.args, {
        pause = {
            callback = function()
                M.options.paused = not M.options.paused
                vim.notify(string.format('Session paused: %s', M.options.paused))
            end,
        },
        save = {
            callback = function()
                vim.notify('Saved session ')
                save_session()
            end,
        },
    }).callback()
end, {
    nargs = 1,
    complete = function(_, _, _)
        return { 'pause', 'save' }
    end,
})
vim.api.nvim_create_autocmd('VimLeave', {
    group = vim.api.nvim_create_augroup('session-save', { clear = true }),
    callback = function()
        if not M.options.paused then
            save_session()
        end
    end,
})

return M
