return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      prettier = {
        options = {
          tabWidth = 2,
          singleQuote = true,
          bracketSpacing = false,
          parser = "flow",
          trailingComma = "es5",
        },
      },
    },
    formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      svelte = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      toml = { "prettier" },
      markdown = { "prettier" },
      lua = { "stylua" },
      python = { "isort" },
      cpp = { "clang-format" },
      rust = { "rustfmt" },
    },
  },
}
