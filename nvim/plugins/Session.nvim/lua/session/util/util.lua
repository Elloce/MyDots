local M = {}

M.switch = function(key, tbl)
    if tbl[key] ~= nil then
        return tbl[key]
    end
end

M.path = function() end

M.path_contents = function(path)
    local contents = {}
    for c in vim.fs.dir(path) do
        table.insert(contents, c)
    end
    return contents
end

return M
