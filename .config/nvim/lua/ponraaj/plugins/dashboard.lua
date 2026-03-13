-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Dashboard: mini.starter - Lightweight startup screen
-- Shows recent files, sessions, and quick actions
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

return {
  {
    "echasnovski/mini.starter",
    version = "*",
    event = "VimEnter",
    config = function()
      local starter = require("mini.starter")

      starter.setup({
        evaluate_single = true,
        items = {
          -- Quick actions (static items)
          { name = "Find File", action = "Telescope find_files", section = "Actions" },
          { name = "Recent Files", action = "Telescope oldfiles", section = "Actions" },
          { name = "New File", action = "ene | startinsert", section = "Actions" },
          { name = "File Explorer", action = "Neotree toggle", section = "Actions" },
          
          -- Recent files from current directory (function that returns items)
          starter.sections.recent_files(5, true, true),
          
          -- General recent files (function that returns items)
          starter.sections.recent_files(5, false, true),
          
          -- Sessions (function that returns items)
          -- Note: requires mini.sessions to be set up
          starter.sections.sessions(5, true),
        },
        content_hooks = {
          starter.gen_hook.adding_bullet("  "),
          starter.gen_hook.indexing("all", { "Actions" }),
          starter.gen_hook.padding(3, 2),
        },
        header = table.concat({
          "",
          "   ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
          "   ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
          "   ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
          "   ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
          "   ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
          "   ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
          "",
        }, "\n"),
        footer = "",
      })
    end,
  },
}
