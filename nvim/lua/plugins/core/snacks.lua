return {
	lazy = false,
	"folke/snacks.nvim",
	opts = {
		indent = { enabled = true },
		notifier = { enabled = true },
		picker = { enabled = true },
	},
	keys = {
		{
			"<leader><leader>",
			function()
				Snacks.picker.files({ desc = "Find Files" })
			end,
		},
		{
			"<leader>/",
			function()
				Snacks.picker.grep()
			end,
		},
		{
			"<leader>G",
			function()
				Snacks.picker.git_files()
			end,
		},
		{
			"<leader>fn",
			function()
				Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
			end,
		},
		{
			"<leader>b",
			function()
				Snacks.picker.buffers()
			end,
		},
		{
			"<leader>fh",
			function()
				Snacks.picker.help()
			end,
		},
		{
			"<leader>C",
			function()
				Snacks.picker.colorschemes()
			end,
		},
		{
			"<leader>n",
			function()
				Snacks.notifier.show_history()
			end,
		},
		-- Lsp
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Goto Definition",
		},
		{
			"gD",
			function()
				Snacks.picker.lsp_declarations()
			end,
			desc = "Goto Declaration",
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
			desc = "References",
		},
		{
			"gI",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "Goto Implementation",
		},
		{
			"gy",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "Goto T[y]pe Definition",
		},
		{
			"<leader>ss",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "LSP Symbols",
		},
		{
			"<leader>sS",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "LSP Workspace Symbols",
		},
		-- etc
		{ "T", "<cmd>lua Snacks.terminal()<cr>" },
	},
}
