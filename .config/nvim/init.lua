-- ============================================================================
-- Ponraaj's Neovim Configuration
-- Neovim 0.11+ | Native LSP | lazy.nvim
-- ============================================================================

-- Load core settings first (options must come before plugins)
require("ponraaj.core.options")
require("ponraaj.core.keymaps")
require("ponraaj.core.rust")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
    }, true, {})
    return
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup plugins via lazy.nvim
-- Passing a module string makes lazy.nvim auto-discover all files
-- in lua/ponraaj/plugins/ and merge their return tables.
require("lazy").setup("ponraaj.plugins", {
  defaults = { lazy = true },
  install = { colorscheme = { "catppuccin" } },
  checker = { enabled = false },
  change_detection = { notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Load LSP configuration after plugins are loaded
-- This ensures all plugin dependencies (cmp-nvim-lsp, etc.) are available
require("ponraaj.core.lsp")
