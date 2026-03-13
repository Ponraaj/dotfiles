-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Navbuddy — navigation tree (navic companion)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

return {
  {
    "SmiteshP/nvim-navbuddy",
    cmd = "Navbuddy",
    dependencies = {
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      window = {
        border = "rounded",
        size = "60%",
      },
      lsp = { auto_attach = true },
    },
    keys = {
      { "<leader>cn", "<cmd>Navbuddy<CR>", desc = "Navigation (Navbuddy)" },
    },
  },
}
