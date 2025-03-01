local M = {}
M.create_window = function(opts)
    local width = opts.width or math.floor(vim.o.columns * 0.8)
    local height = opts.height or math.floor(vim.o.lines * 0.8)
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    local config = {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = 'single',
        focusable = true,
    }

    local buf = vim.api.nvim_create_buf(false, false)
    local w = vim.api.nvim_open_win(buf, true, config)
    return { win = w, buf = buf }
end

M.has_item = function(key, list)
    for i = 1, #list do
        if list[i] == key then
            return true
        end
    end
    return false
end

return M
