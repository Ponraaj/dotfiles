-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_autocmd({ "FileChangedShellPost" }, {
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.WARN)
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
  pattern = "*.env",
  callback = function()
    vim.diagnostic.enable(false)
  end,
})

-- Better auto-reload setup
local auto_reload_group = vim.api.nvim_create_augroup("AutoReload", { clear = true })

vim.api.nvim_create_autocmd({ "FileChangedShellPost", "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = auto_reload_group,
  pattern = "*",
  callback = function()
    if vim.fn.getcmdwintype() == "" then
      vim.cmd("checktime")
    end
  end,
})

-- Ensure conform is loaded
local conform = require("conform")

-- Auto-format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("ConformAutoFormat", {}),
  callback = function(args)
    local filetype = vim.bo[args.buf].filetype
    -- Check if there are formatters for the filetype
    if conform.get({ filetype = filetype }) then
      conform.format({ bufnr = args.buf })
    end
  end,
})
