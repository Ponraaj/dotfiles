-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap

-- Escape wiht jk
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

local luasnip = require("luasnip")

vim.keymap.set({ "i", "s" }, "<Tab>", function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end, { silent = true })
