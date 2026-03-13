-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Spectre — search/replace UI
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

return {
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      live_update = true,
      highlight = {
        search = "SpectreSearch",
        replace = "SpectreReplace",
      },
    },
    keys = {
      {
        "<leader>sr",
        function()
          require("spectre").open()
        end,
        desc = "Search and replace",
      },
      {
        "<leader>sr",
        function()
          require("spectre").open_visual()
        end,
        mode = "v",
        desc = "Search and replace (visual)",
      },
    },
  },
}
