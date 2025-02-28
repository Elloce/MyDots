local util = require('session.util.util')

local M = {}
M.config = {
    options = {
        path = '',
        paused = false,
    },
}

M.setup = function(opts)
    M.config = vim.tbl_deep_extend('force', M.config, opts)
    --vim.print(M.config)
end

local get_path = function(path)
    local pwd = vim.fn.split(vim.uv.cwd() .. '', '/')
    path = path or pwd[#pwd]
    local full_path = vim.fn.stdpath('config') .. '/' .. M.config.options.path .. pwd[#pwd] .. '.vim'
    return full_path
end

local save_session = function()
    vim.cmd('mks! ' .. get_path())
end

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
                vim.notify(string.format('Saved session -> %s', get_path()))
                save_session()
            end,
        },
        valid = {
            callback = function()
                vim.notify(string.format('path %s', M.config.options.path))
            end,
        },
        load = {
            callback = function()
                if require('snacks') then
                    Snacks.picker.select(util.path_contents(M.config.options.path), {}, function(item, _)
                        --vim.print(item)
                        vim.cmd('source ' .. M.config.options.path .. '/' .. item)
                    end)
                end
            end,
        },
    }).callback()
end, {
    nargs = 1,
    complete = function(_, _, _)
        return { 'pause', 'save', 'load', 'valid' }
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

-- Snacks.picker.select({ '1', '2', '3', '4' }, {}, function(item, idx) print(item .. ',' .. idx) end)
--vim.print(vim.fn.stdpath('config') .. '/' .. 'session/')
--Snacks.picker.files({ cwd = M.config.options.path })

return M
