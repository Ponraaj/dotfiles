-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- LSP Plugin Stack
-- Mason handles binary installation.
-- Actual server config uses native vim.lsp.config() in core/lsp.lua
-- nvim-lspconfig is required by mason-lspconfig (runtime configs)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

return {
  -- ── Mason: portable LSP/DAP/linter installer ──────────────
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    lazy = false,
    opts = {
      ui = { border = "rounded" },
    },
  },

  -- ── LSP configs (required by mason-lspconfig) ─────────────
  -- Provides server configs on runtimepath; we still use vim.lsp.config
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = false,
  },

  -- ── Navic: LSP breadcrumbs ─────────────────────────────────
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    init = function()
      vim.g.navic_silence = true
    end,
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      highlight = true,
      separator = "  ",
      depth_limit = 0,
      depth_limit_indicator = "..",
      safe_output = true,
      lazy_update_context = true,
    },
  },

  -- ── SchemaStore: JSON/YAML schema catalog ─────────────────
  -- Lazy-loaded, loaded on demand by LSP before_init
  {
    "b0o/schemastore.nvim",
    lazy = true,
    version = false,
  },

  -- ── Mason-LSPConfig: bridges Mason ↔ server names ─────────
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      ensure_installed = {
        "lua_ls",
        "gopls",
        "clangd",
        "ts_ls",
        "basedpyright",
        "ruff",
        "rust_analyzer",
        "jsonls",
      },
      -- LSP servers are enabled explicitly in core/lsp.lua after configs are defined
      automatic_enable = false,
    },
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
  },
}
