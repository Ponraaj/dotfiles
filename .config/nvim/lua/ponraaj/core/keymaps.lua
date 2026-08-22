-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Keymaps (non-LSP — LSP keymaps live in core/lsp.lua)
-- LazyVim-style keymaps for better productivity
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local map = vim.keymap.set

-- ── General ──────────────────────────────────────────────────
-- Clear search highlight with Escape
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Save and quit shortcuts
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<C-q>", "<cmd>qa<CR>", { desc = "Quit all" })

-- Better up/down movement (handles wrapped lines)
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- ── Window Navigation ────────────────────────────────────────
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- ── Window Resizing ─────────────────────────────────────────
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- ── Window Management ───────────────────────────────────────
map("n", "<leader>-", "<C-w>s", { desc = "Split window below" })
map("n", "<leader>|", "<C-w>v", { desc = "Split window right" })
map("n", "<leader>wd", "<C-w>c", { desc = "Delete window" })
map("n", "<leader>wm", "<cmd>tab split<CR>", { desc = "Toggle zoom mode (maximize)" })

-- ── Move Lines ──────────────────────────────────────────────
map("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<CR>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<CR>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move up" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- ── Better Indenting ────────────────────────────────────────
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- ── Buffer Navigation ───────────────────────────────────────
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<CR>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bb", "<cmd>e #<CR>", { desc = "Switch to other buffer" })
map("n", "<leader>`", "<cmd>e #<CR>", { desc = "Switch to other buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
map("n", "<leader>bD", "<cmd>bdelete<CR><cmd>q<CR>", { desc = "Delete buffer and window" })
map("n", "<leader>bo", "<cmd>%bdelete|edit#|bdelete#<CR>", { desc = "Delete other buffers" })

-- ── Bufferline (Tab-like buffer management) ─────────────────
map("n", "<leader>bp", "<cmd>BufferLineTogglePin<CR>", { desc = "Toggle pin" })
map("n", "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete non-pinned buffers" })
map("n", "<leader>br", "<cmd>BufferLineCloseRight<CR>", { desc = "Delete buffers to the right" })
map("n", "<leader>bl", "<cmd>BufferLineCloseLeft<CR>", { desc = "Delete buffers to the left" })
map("n", "[B", "<cmd>BufferLineMovePrev<CR>", { desc = "Move buffer prev" })
map("n", "]B", "<cmd>BufferLineMoveNext<CR>", { desc = "Move buffer next" })

-- ── Tab Management ──────────────────────────────────────────
map("n", "<leader><tab>l", "<cmd>tablast<CR>", { desc = "Last tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<CR>", { desc = "Close other tabs" })
map("n", "<leader><tab>f", "<cmd>tabfirst<CR>", { desc = "First tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<CR>", { desc = "Next tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<CR>", { desc = "Close tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<CR>", { desc = "Previous tab" })

-- ── Neo-tree ────────────────────────────────────────────────
map("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle file explorer (root)" })
map("n", "<leader>E", "<cmd>Neotree toggle reveal_force_cwd<CR>", { desc = "Toggle file explorer (cwd)" })

-- ── Telescope ───────────────────────────────────────────────
map("n", "<leader><space>", "<cmd>Telescope find_files<CR>", { desc = "Find files (root dir)" })
map("n", "<leader>,", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<CR>", { desc = "Switch buffer" })
map("n", "<leader>/", "<cmd>Telescope live_grep<CR>", { desc = "Grep (root dir)" })
map("n", "<leader>:", "<cmd>Telescope command_history<CR>", { desc = "Command history" })
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files (root dir)" })
map("n", "<leader>fF", "<cmd>Telescope find_files cwd=.<CR>", { desc = "Find files (cwd)" })
map("n", "<leader>fg", "<cmd>Telescope git_files<CR>", { desc = "Find files (git-files)" })
map("n", "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<CR>", { desc = "Buffers" })
map("n", "<leader>fB", "<cmd>Telescope buffers<CR>", { desc = "Buffers (all)" })
map("n", "<leader>fc", "<cmd>Telescope find_files cwd=~/.config/nvim<CR>", { desc = "Find config file" })
map("n", "<leader>fC", "<cmd>Telescope commands<CR>", { desc = "Commands" })
map("n", "<leader>fe", "<cmd>Neotree toggle<CR>", { desc = "Explorer (root dir)" })
map("n", "<leader>fE", "<cmd>Neotree toggle reveal_force_cwd<CR>", { desc = "Explorer (cwd)" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent" })
map("n", "<leader>fR", "<cmd>Telescope oldfiles cwd=.<CR>", { desc = "Recent (cwd)" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help pages" })
map("n", "<leader>fH", "<cmd>Telescope highlights<CR>", { desc = "Highlights" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "Keymaps" })
map("n", "<leader>fm", "<cmd>Telescope marks<CR>", { desc = "Marks" })
map("n", "<leader>fM", "<cmd>Telescope man_pages<CR>", { desc = "Man pages" })
map("n", "<leader>fp", "<cmd>Telescope projects<CR>", { desc = "Projects" })
map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "LSP Symbols" })
map("n", "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<CR>", { desc = "LSP Workspace Symbols" })

-- ── Search & Grep ───────────────────────────────────────────
map("n", "<leader>sg", "<cmd>Telescope live_grep<CR>", { desc = "Grep (root dir)" })
map("n", "<leader>sG", "<cmd>Telescope live_grep cwd=.<CR>", { desc = "Grep (cwd)" })
map("n", "<leader>sw", '<cmd>Telescope grep_string<CR>', { desc = "Word (root dir)" })
map("v", "<leader>sw", '<cmd>Telescope grep_string<CR>', { desc = "Selection (root dir)" })
map("n", "<leader>sW", '<cmd>Telescope grep_string cwd=.<CR>', { desc = "Word (cwd)" })
map("v", "<leader>sW", '<cmd>Telescope grep_string cwd=.<CR>', { desc = "Selection (cwd)" })
map("n", "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Buffer lines" })
map("n", "<leader>sB", "<cmd>Telescope live_grep grep_open_files=true<CR>", { desc = "Grep open buffers" })
map("n", "<leader>sC", "<cmd>Telescope commands<CR>", { desc = "Commands" })
map("n", "<leader>sh", "<cmd>Telescope help_tags<CR>", { desc = "Help pages" })
map("n", "<leader>sH", "<cmd>Telescope highlights<CR>", { desc = "Highlights" })
map("n", "<leader>sk", "<cmd>Telescope keymaps<CR>", { desc = "Keymaps" })
map("n", "<leader>sl", "<cmd>Telescope loclist<CR>", { desc = "Location list" })
map("n", "<leader>sm", "<cmd>Telescope marks<CR>", { desc = "Marks" })
map("n", "<leader>sM", "<cmd>Telescope man_pages<CR>", { desc = "Man pages" })
map("n", "<leader>sq", "<cmd>Telescope quickfix<CR>", { desc = "Quickfix list" })
map("n", "<leader>sR", "<cmd>Telescope resume<CR>", { desc = "Resume" })
map("n", "<leader>ss", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "LSP Symbols" })
map("n", "<leader>sS", "<cmd>Telescope lsp_workspace_symbols<CR>", { desc = "LSP Workspace Symbols" })
map("n", "<leader>st", "<cmd>TodoTelescope<CR>", { desc = "Todo" })
map("n", "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<CR>", { desc = "Todo/Fix/Fixme" })
map("n", "<leader>sa", "<cmd>Telescope autocommands<CR>", { desc = "Autocommands" })
map("n", "<leader>sc", "<cmd>Telescope command_history<CR>", { desc = "Command history" })
map("n", "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Diagnostics" })
map("n", "<leader>sD", "<cmd>Telescope diagnostics<CR>", { desc = "Workspace diagnostics" })
map("n", "<leader>sj", "<cmd>Telescope jumplist<CR>", { desc = "Jumps" })
map("n", "<leader>sp", "<cmd>lua require('lazy').plugins()<CR>", { desc = "Search for plugin spec" })
map("n", "<leader>s\"/", "<cmd>Telescope search_history<CR>", { desc = "Search history" })

-- ── Scroll & Search (centered) ─────────────────────────────
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centered)" })
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev search result (centered)" })

-- ── Git ────────────────────────────────────────────────────
map("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>", { desc = "Git blame line" })
map("n", "<leader>gB", "<cmd>Gitsigns blame<CR>", { desc = "Git blame (buffer)" })
map("n", "<leader>gL", "<cmd>Gitsigns setloclist<CR>", { desc = "Git log (cwd)" })
map("n", "<leader>gf", "<cmd>Gitsigns diffthis<CR>", { desc = "Git current file history" })
map("n", "<leader>gl", "<cmd>Gitsigns setqflist<CR>", { desc = "Git log" })
map("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "Git status" })
map("n", "<leader>gS", "<cmd>Telescope git_stash<CR>", { desc = "Git stash" })
map("n", "<leader>gd", "<cmd>Gitsigns diffthis<CR>", { desc = "Git diff (hunks)" })
map("n", "<leader>gD", "<cmd>Gitsigns diffthis ~<CR>", { desc = "Git diff (origin)" })

-- ── Git Hunks ──────────────────────────────────────────────
map("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
map("v", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
map("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
map("v", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
map("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>", { desc = "Stage buffer" })
map("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>", { desc = "Reset buffer" })
map("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>", { desc = "Undo stage hunk" })
map("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Preview hunk" })
map("n", "<leader>hb", "<cmd>Gitsigns blame_line<CR>", { desc = "Blame line" })
map("n", "<leader>hB", "<cmd>Gitsigns blame<CR>", { desc = "Blame buffer" })
map("n", "<leader>hd", "<cmd>Gitsigns diffthis<CR>", { desc = "Diff this" })
map("n", "<leader>hD", "<cmd>Gitsigns diffthis ~<CR>", { desc = "Diff this ~" })
map("n", "]h", "<cmd>Gitsigns next_hunk<CR>", { desc = "Next hunk" })
map("n", "[h", "<cmd>Gitsigns prev_hunk<CR>", { desc = "Prev hunk" })

-- ── Quickfix & Location List ───────────────────────────────
map("n", "<leader>xl", "<cmd>lopen<CR>", { desc = "Location list" })
map("n", "<leader>xq", "<cmd>copen<CR>", { desc = "Quickfix list" })
map("n", "[q", "<cmd>cprevious<CR>", { desc = "Previous quickfix" })
map("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix" })
map("n", "[l", "<cmd>lprevious<CR>", { desc = "Previous location" })
map("n", "]l", "<cmd>lnext<CR>", { desc = "Next location" })

-- ── Diagnostics ────────────────────────────────────────────
map("n", "<leader>cd", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Line diagnostics" })
map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", { desc = "Next diagnostic" })
map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { desc = "Prev diagnostic" })
map("n", "]e", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>", { desc = "Next error" })
map("n", "[e", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>", { desc = "Prev error" })
map("n", "]w", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.WARN})<CR>", { desc = "Next warning" })
map("n", "[w", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.WARN})<CR>", { desc = "Prev warning" })

-- ── Todo Comments ──────────────────────────────────────────
map("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo comment" })
map("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Prev todo comment" })
map("n", "<leader>xt", "<cmd>TodoTrouble<CR>", { desc = "Todo (Trouble)" })
map("n", "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<CR>", { desc = "Todo/Fix/Fixme (Trouble)" })
map("n", "<leader>st", "<cmd>TodoTelescope<CR>", { desc = "Todo" })
map("n", "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<CR>", { desc = "Todo/Fix/Fixme" })

-- ── Format ─────────────────────────────────────────────────
map({ "n", "x" }, "<leader>cf", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format buffer (LSP)" })

map({ "n", "x" }, "<leader>cF", function()
  vim.lsp.buf.format({ async = true, filter = function(client)
    return client.name == "null-ls"
  end })
end, { desc = "Format buffer (null-ls)" })

-- ── LSP Navigation ─────────────────────────────────────────
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Goto definition" })
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { desc = "References" })
map("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "Goto implementation" })
map("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { desc = "Goto type definition" })
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { desc = "Goto declaration" })
map("n", "gK", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Signature help" })
map("n", "]]", "<cmd>lua vim.lsp.buf.references()<CR>", { desc = "Next reference" })
map("n", "[[", "<cmd>lua vim.lsp.buf.references()<CR>", { desc = "Prev reference" })

-- ── LSP Actions ────────────────────────────────────────────
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Hover" })
map("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Signature help" })
map({ "n", "x" }, "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Code action" })
map("n", "<leader>cc", "<cmd>lua vim.lsp.codelens.run()<CR>", { desc = "Run codelens" })
map("n", "<leader>cC", "<cmd>lua vim.lsp.codelens.refresh()<CR>", { desc = "Refresh codelens" })
map("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename" })
map("n", "<leader>cA", "<cmd>lua vim.lsp.buf.code_action({ apply = true, context = { only = { 'source' }, diagnostics = {} } })<CR>", { desc = "Source action" })

-- ── LSP Info ───────────────────────────────────────────────
map("n", "<leader>cl", "<cmd>LspInfo<CR>", { desc = "Lsp info" })
map("n", "<leader>cm", "<cmd>Mason<CR>", { desc = "Mason" })

-- ── Toggles ────────────────────────────────────────────────
map("n", "<leader>uf", "<cmd>lua vim.g.autoformat = not vim.g.autoformat<CR>", { desc = "Toggle auto format (global)" })
map("n", "<leader>uF", "<cmd>lua vim.b.autoformat = not vim.b.autoformat<CR>", { desc = "Toggle auto format (buffer)" })
map("n", "<leader>us", "<cmd>set spell!<CR>", { desc = "Toggle spelling" })
map("n", "<leader>uw", "<cmd>set wrap!<CR>", { desc = "Toggle wrap" })
map("n", "<leader>uL", "<cmd>set relativenumber!<CR>", { desc = "Toggle relative number" })
map("n", "<leader>ud", "<cmd>lua vim.diagnostic.disable()<CR>", { desc = "Toggle diagnostics" })
map("n", "<leader>ul", "<cmd>set number!<CR>", { desc = "Toggle line numbers" })
map("n", "<leader>uc", "<cmd>lua vim.o.conceallevel = vim.o.conceallevel == 0 and 2 or 0<CR>", { desc = "Toggle conceal level" })
map("n", "<leader>uT", "<cmd>lua local buf=vim.api.nvim_get_current_buf(); if vim.treesitter.highlighter.active[buf] then vim.treesitter.stop(buf) else vim.treesitter.start(buf) end<CR>", { desc = "Toggle treesitter highlight" })
map("n", "<leader>ub", "<cmd>lua vim.o.background = vim.o.background == 'dark' and 'light' or 'dark'<CR>", { desc = "Toggle dark background" })
map("n", "<leader>ug", "<cmd>IBLToggle<CR>", { desc = "Toggle indent guides" })
map("n", "<leader>uh", "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>", { desc = "Toggle inlay hints" })
map("n", "<leader>uC", "<cmd>Telescope colorscheme<CR>", { desc = "Colorschemes" })
map("n", "<leader>uZ", "<cmd>tab split<CR>", { desc = "Toggle zoom mode" })
map("n", "<leader>uz", "<cmd>ZenMode<CR>", { desc = "Toggle zen mode" })

-- ── Lazy ───────────────────────────────────────────────────
map("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Lazy" })
map("n", "<leader>L", "<cmd>Lazy update<CR>", { desc = "LazyVim changelog" })

-- ── New File & Quit ────────────────────────────────────────
map("n", "<leader>fn", "<cmd>enew<CR>", { desc = "New file" })
map("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Quit all" })

-- ── Terminal (Toggleterm + Native) ─────────────────────────
-- Note: Terminal keymaps are set via autocmd in terminal.lua
-- See <C-h/j/k/l> navigation in terminal mode there
-- Default toggle with Ctrl+\ (uses direction from setup - vertical)
map({ "n", "i" }, "<C-\\>", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
-- Native vim terminal splits (for nested layouts)
map("n", "<leader>ts", "<cmd>split | terminal<CR>", { desc = "Terminal in horizontal split (native)" })
map("n", "<leader>tS", "<cmd>vsplit | terminal<CR>", { desc = "Terminal in vertical split (native)" })
map("n", "<leader>tn", "<cmd>enew | terminal<CR>", { desc = "Terminal in new buffer" })
-- Lazygit (LazyVim style)
map("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>", { desc = "Lazygit" })
-- Lazydocker (LazyVim style)
map("n", "<leader>dd", "<cmd>lua _lazydocker_toggle()<CR>", { desc = "Lazydocker" })

-- ── Misc ───────────────────────────────────────────────────
-- Don't yank on paste in visual mode
map("x", "p", [['_dP]], { desc = "Paste without yanking" })


-- Redraw / clear hlsearch / diff update
map("n", "<leader>ur", "<cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", { desc = "Redraw / clear hlsearch / diff update" })

-- Keywordprg
map("n", "<leader>K", "<cmd>norm! K<CR>", { desc = "Keywordprg" })

-- Add comment below/above (requires Comment.nvim)
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<CR>fxa<bs>", { desc = "Add comment below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<CR>fxa<bs>", { desc = "Add comment above" })

-- Inspect
map("n", "<leader>ui", "<cmd>Inspect<CR>", { desc = "Inspect pos" })
map("n", "<leader>uI", "<cmd>InspectTree<CR>", { desc = "Inspect tree" })
