return {
  "L3MON4D3/LuaSnip",
  tag = "v2.3.0",
  build = "make install_jsregexp",
  dependencies = { "rafamadriz/friendly-snippets" },
  config = function()
    local ls = require("luasnip")

    -- Load snippets from the correct paths
    require("luasnip.loaders.from_lua").lazy_load({
      paths = { "~/.config/nvim/snippets/" },
    })
    require("luasnip.loaders.from_snipmate").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}
