vim.api.nvim_create_user_command('Test', function(command)
    vim.notify(string.format('Test: %s ', command.args))
end, {
    nargs = 1,
    desc = 'desc',
    complete = function(_, _, _)
        return { 'one', 'two', 'three' }
    end,
})
