-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.autoread = true
vim.opt.updatetime = 250
vim.o.clipboard = "unnamedplus"

vim.diagnostic.config({
  virtual_text = true, -- Show inline errors
  signs = true, -- Show signs in the gutter
  underline = true, -- Underline the error text
  update_in_insert = false, -- Don't update diagnostics in insert mode
  severity_sort = true, -- Sort by severity
})
