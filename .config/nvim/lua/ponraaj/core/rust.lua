-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Rustaceanvim configuration (must be set before plugin loads)
-- Docs: https://github.com/mrcjkb/rustaceanvim/blob/master/doc/rustaceanvim.txt
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

---@type rustaceanvim.Opts
vim.g.rustaceanvim = {
  tools = {
    test_executor = "background",
    code_actions = {
      ui_select_fallback = true,
    },
  },
  server = {
    default_settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
        },
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
  dap = {
    autoload_configurations = true,
  },
}
