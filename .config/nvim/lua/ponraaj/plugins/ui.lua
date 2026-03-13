-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- UI — Colorscheme, statusline, bufferline, which-key
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

return {
  -- ── Colorscheme: Catppuccin Mocha ─────────────────────────
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000, -- load before everything else
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = false,
        integrations = {
          cmp = true,
          gitsigns = true,
          indent_blankline = { enabled = true },
          mason = true,
          neo_tree = true,
          navic = { enabled = true },
          noice = true,
          notify = true,
          telescope = { enabled = true },
          treesitter = true,
          which_key = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- ── Statusline: Lualine ────────────────────────────────────
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons", "SmiteshP/nvim-navic" },
    config = function()
      local navic_ok, navic = pcall(require, "nvim-navic")
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          globalstatus = true,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = { statusline = { "neo-tree" } },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = {
            { "filename", path = 1 }, -- relative path
            {
              function()
                return navic_ok and navic.get_location() or ""
              end,
              cond = function()
                return navic_ok and navic.is_available()
              end,
            },
          },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- ── Buffer Tabs: Bufferline ────────────────────────────────
  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim" },
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          diagnostics = "nvim_lsp",
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer",
              text_align = "center",
              separator = true,
            },
          },
          separator_style = "thin",
          show_buffer_close_icons = true,
          show_close_icon = false,
          always_show_bufferline = false, -- hide when only one buffer
        },
      })
    end,
  },

  -- ── Which-Key: Keymap hints ────────────────────────────────
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      local wk = require("which-key")
      wk.setup({
        plugins = {
          marks = true,
          registers = true,
        },
        win = {
          border = "rounded",
        },
      })

      -- Register group labels for which-key popup
      wk.add({
        { "<leader>b", group = "Buffer" },
        { "<leader>c", group = "Code" },
        { "<leader>d", group = "Debug" },
        { "<leader>f", group = "Find (Telescope)" },
        { "<leader>g", group = "Git" },
        { "<leader>h", group = "Git hunks" },
        { "<leader>l", group = "Lazy" },
        { "<leader>q", group = "Quit/session" },
        { "<leader>r", group = "Rename" },
        { "<leader>s", group = "Search" },
        { "<leader>t", group = "Terminal" },
        { "<leader>u", group = "UI" },
        { "<leader>w", group = "Windows" },
        { "<leader>x", group = "Trouble/quickfix" },
        { "<leader><tab>", group = "Tabs" },
      })
    end,
  },
}
