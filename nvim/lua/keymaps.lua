local keys = {}

keys["<A-w>"] = {
	action = "<cmd>w<cr>",
	desc = "Quick save",
}
keys["<A-q>"] = {
	action = "<cmd>q!<cr>",
	desc = "Quick quit",
}
keys["<C-A-j>"] = {
	action = "VyP",
	desc = "copy and paste line",
}
keys["<A-j>"] = {
	action = "<cmd>m +1<cr>",
	desc = "move line down",
	mode = "v",
}
keys["<A-k>"] = {
	action = "<cmd>m -2<cr>",
	desc = "move line up",
	mode = "v",
}
keys["<Esc>"] = {
	action = "<cmd>nohlsearch<cr>",
	desc = "clear search terms",
}

keys["<leader>x"] = {
	action = "<cmd>!gcc % | ./a.out <cr>",
	desc = "",
}
keys["<leader>q"] = {
	action = function()
		vim.lsp.diagnostic.setloclist()
	end,
	desc = "open diagnostic list?",
}

for k, v in pairs(keys) do
	local mode = v.mode or "n"
	vim.keymap.set(mode, k, v.action, { desc = v.desc })
end
