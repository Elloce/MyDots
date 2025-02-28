local M = {}

M.switch = function(key, tbl)
    if tbl[key] ~= nil then
        return tbl[key]
    end
end

return M
