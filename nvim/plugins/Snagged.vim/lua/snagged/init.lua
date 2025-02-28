local M = {}

M.config = {
    options = {
        max_items = 5,
    },
}

M.setup = function(opts)
    M.config = vim.tbl_deep_extend('force', M.config, opts)
end

local list = {}
local idx = 0

local save_list = function() end

M.add_item = function(item)
    save_list()
end
M.remove_item = function(index) end
M.select_item = function(index) end
M.show_panel = function() end

return M
