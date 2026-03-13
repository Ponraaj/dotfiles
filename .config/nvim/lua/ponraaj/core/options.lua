-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Core Options
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local opt = vim.opt

-- Leader key (must be set before lazy.nvim loads)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ── Line Numbers ──────────────────────────────────────────────
opt.number = true
opt.relativenumber = true

-- ── Tabs & Indentation ───────────────────────────────────────
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- ── Search ───────────────────────────────────────────────────
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- ── Appearance ───────────────────────────────────────────────
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.showmode = false       -- lualine handles this
opt.pumheight = 10         -- popup menu height

-- ── Splits ───────────────────────────────────────────────────
opt.splitbelow = true
opt.splitright = true

-- ── System Integration ───────────────────────────────────────
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.writebackup = false

-- ── Timing ───────────────────────────────────────────────────
opt.updatetime = 250
opt.timeoutlen = 300

-- ── Completion ───────────────────────────────────────────────
opt.completeopt = { "menu", "menuone", "noselect" }

-- ── Misc ─────────────────────────────────────────────────────
opt.fillchars = { eob = " " }  -- hide ~ on empty lines
opt.shortmess:append("sI")     -- disable intro message
opt.iskeyword:append("-")      -- treat foo-bar as one word
