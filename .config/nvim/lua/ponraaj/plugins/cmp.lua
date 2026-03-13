-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Completion — nvim-cmp with snippets and multiple sources
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    -- Snippet engine
    {
      "L3MON4D3/LuaSnip",
      build = "make install_jsregexp",
      dependencies = {
        "rafamadriz/friendly-snippets", -- community snippet collection
      },
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    -- Completion sources
    "hrsh7th/cmp-nvim-lsp", -- LSP completions
    "hrsh7th/cmp-buffer",   -- buffer words
    "hrsh7th/cmp-path",     -- file paths
    "saadparwaiz1/cmp_luasnip", -- snippet completions
    -- Formatting
    "onsails/lspkind.nvim", -- vscode-like icons
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        -- Navigate completion menu
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),

        -- Scroll docs
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        -- Trigger completion
        ["<C-Space>"] = cmp.mapping.complete(),

        -- Cancel
        ["<C-e>"] = cmp.mapping.abort(),

        -- Confirm selection (only if explicitly selected)
        ["<CR>"] = cmp.mapping.confirm({ select = false }),

        -- Tab: complete or jump through snippet
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),

        -- Shift-Tab: reverse
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),

      -- Source priority (order matters)
      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
        { name = "buffer", priority = 500, keyword_length = 3 },
        { name = "path", priority = 250 },
      }),

      -- Display formatting with icons
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },

      -- Ghost text preview
      experimental = {
        ghost_text = true,
      },
    })
  end,
}
