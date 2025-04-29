return {
  "SmiteshP/nvim-navbuddy",
  dependencies = {
    "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("nvim-navbuddy").setup()
  end,
}
