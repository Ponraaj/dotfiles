-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap

-- Escape wiht jk
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set({ "i", "s" }, "<Tab>", function()
  local ls = require("luasnip")
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  else
    -- If no snippet to expand, send a regular tab
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
  end
end, { silent = true })

-- For jumping backward in snippets
keymap.set({ "i", "s" }, "<S-Tab>", function()
  local ls = require("luasnip")
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })
