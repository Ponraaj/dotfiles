-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Terminal: Toggleterm - Toggleable terminal in splits
-- Based on official toggleterm.nvim documentation
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        persist_mode = true,
        direction = "vertical",
        close_on_exit = true,
        shell = vim.o.shell,
        auto_scroll = true,
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })

      -- Terminal window mappings (buffer-local)
      -- This is the OFFICIAL way from toggleterm docs
      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        -- Exit terminal mode
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        -- Window navigation from terminal (vim + tmux)
        vim.keymap.set('t', '<C-h>', [[<C-\><C-n><Cmd>TmuxNavigateLeft<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<C-\><C-n><Cmd>TmuxNavigateDown<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<C-\><C-n><Cmd>TmuxNavigateUp<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<C-\><C-n><Cmd>TmuxNavigateRight<CR>]], opts)
        vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
      end

      -- Set up autocmd for terminal mappings (all terminals including native)
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*",
        callback = function()
          set_terminal_keymaps()
        end,
        desc = "Set terminal keymaps for all terminals",
      })

      -- Custom terminals
      local Terminal = require("toggleterm.terminal").Terminal

      -- Lazygit terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        hidden = true,
        direction = "float",
        float_opts = {
          border = "curved",
        },
        on_open = function(term)
          vim.cmd("startinsert!")
        end,
        on_close = function(term)
          vim.cmd("startinsert!")
        end,
      })

      function _G._lazygit_toggle()
        lazygit:toggle()
      end

      -- Lazydocker terminal
      local lazydocker = Terminal:new({
        cmd = "lazydocker",
        hidden = true,
        direction = "float",
        float_opts = {
          border = "curved",
        },
        on_open = function(term)
          vim.cmd("startinsert!")
        end,
        on_close = function(term)
          vim.cmd("startinsert!")
        end,
      })

      function _G._lazydocker_toggle()
        lazydocker:toggle()
      end
    end,
    keys = {
      -- Default toggle (uses setup direction - vertical)
      { "<C-\\>", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal", mode = { "n", "i" } },
      -- Direction-specific toggles
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", desc = "Terminal vertical split", mode = { "n" } },
      { "<leader>tV", "<cmd>ToggleTerm direction=vertical size=60<CR>", desc = "Terminal vertical split (wide)", mode = { "n" } },
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Terminal horizontal split", mode = { "n" } },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Terminal floating", mode = { "n" } },
      { "<leader>tt", "<cmd>ToggleTerm direction=tab<CR>", desc = "Terminal in tab", mode = { "n" } },
      -- Standard vim split + terminal (for nested layouts within toggleterm)
      { "<leader>ts", "<cmd>split | terminal<CR>", desc = "Terminal in horizontal split (vim native)", mode = { "n" } },
      { "<leader>tS", "<cmd>vsplit | terminal<CR>", desc = "Terminal in vertical split (vim native)", mode = { "n" } },
      { "<leader>tn", "<cmd>enew | terminal<CR>", desc = "Terminal in new buffer", mode = { "n" } },
      -- Lazygit (LazyVim style)
      { "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>", desc = "Lazygit", mode = { "n" } },
      -- Lazydocker (LazyVim style)
      { "<leader>dd", "<cmd>lua _lazydocker_toggle()<CR>", desc = "Lazydocker", mode = { "n" } },
    },
  },
}
