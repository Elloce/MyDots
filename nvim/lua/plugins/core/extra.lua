return {
	"tpope/vim-sleuth",
	{
		"tpope/vim-fugitive",
		keys = {
			{ "Ga", "<cmd>Git add .<cr>" },
			{ "Gs", "<cmd>Git status<cr>" },
			{ "Gc", "<cmd>Git commit<cr>" },
		},
	},
	{
		"echasnovski/mini.diff",
		opts = {
			view = {
				style = "sign",
				signs = { add = "+", change = "~", delete = "-" },
			},
		},
	},
	{ "echasnovski/mini.surround", opts = {} },
	{ "echasnovski/mini.pairs", opts = {} },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
	{
		"akinsho/bufferline.nvim",
		event = "BufEnter",
		opts = { options = {
			diagnostics_indicator = "nvim_lsp",
		} },
		keys = {
			{ "<A-/>", "<cmd>BufferLineCycleNext<cr>" },
			{ "<A-.>", "<cmd>BufferLineCyclePrev<cr>" },
		},
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		init = function()
			vim.cmd("colorscheme kanagawa-dragon")
			require("lualine").setup({
				options = {
					theme = require("lualine.themes.kanagawa"),
				},
			})
		end,
		config = true,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		opts = {
			close_if_last_window = true,
			filesystem = { filtered_items = { visible = true } },
		},
		keys = { { "<leader>e", "<cmd>Neotree toggle<cr>" } },
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	}, -- lazy.nvim
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			--"rcarriga/nvim-notify",
		},
	},
}
