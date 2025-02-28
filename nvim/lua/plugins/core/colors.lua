return {
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd 'colorscheme kanagawa-dragon'
      require("lualine").setup({
        options = {
          theme = require("lualine.themes.kanagawa")
        }
      })
    end,
    config = true,
  },
}
