local Snapped = {}
Snapped.opt = {}
Snapped.setup = function(opts)
	opts = opts or {}
	vim.tbl_deep_extend("force", Snapped.opt, opts)
end

Snacks.toggle.zen()
