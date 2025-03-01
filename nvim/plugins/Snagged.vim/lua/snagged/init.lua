local util = require('snagged.util')

local M = {}

M.config = {
    options = {
        max_items = 5,
        state_path = vim.fn.stdpath('data') .. '/snagged',
    },
}

local state = {
    list = {},
    args = { 'show', 'add', 'remove', 'next', 'prev' },
    popup = { win = -1, buf = -1 },
}

M.setup = function(opts)
    M.config = vim.tbl_deep_extend('force', M.config, opts)
    -- load list
    --
    if vim.fn.filereadable(M.config.options.state_path) == 1 then
        for _, v in pairs(vim.fn.readfile(M.config.options.state_path)) do
            table.insert(state.list, v)
        end
    end
end

local add_to_list = function(item)
    if not util.has_item(item, state.list) then
        table.insert(state.list, item)
    end
end

local save_state = function()
    local fd, _ = vim.uv.fs_open(M.config.options.state_path, 'w', 438)
    for i = 1, #state.list do
        ---@diagnostic disable-next-line: param-type-mismatch
        vim.uv.fs_write(fd, state.list[i] .. '\n')
    end
end

M.add_item = function()
    if table.maxn(state.list) > M.config.options.max_items - 1 then
        vim.notify(string.format('Max items in list (%s)', M.config.options.max_items), vim.log.levels.WARN)
        return
    end
    local buf = vim.api.nvim_get_current_buf()
    local name = vim.fn.bufname(buf)
    add_to_list(name)
    --vim.print(state.list, table.maxn(state.list))
    save_state()
end
M.remove_item = function() end
M.select_item = function() end
M.show_panel = function()
    --vim.print(state.list)
    if not vim.api.nvim_win_is_valid(state.popup.win) then
        state.popup = util.create_window({ width = 96, height = 16 })
        vim.api.nvim_buf_set_lines(state.popup.buf, 1, 1, false, state.list)
    else
        vim.api.nvim_win_hide(state.popup.win)
    end
end

vim.api.nvim_create_user_command('Snagged', function(command)
    if command.args == state.args[1] then
        M.show_panel()
    end
    if command.args == state.args[2] then
        M.add_item()
    end
end, {
    nargs = 1,
    complete = function(_, _, _)
        return state.args
    end,
})

return M
