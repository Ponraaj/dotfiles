-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- LSP Configuration — Neovim 0.11+ Native API
-- Uses vim.lsp.config() + vim.lsp.enable() instead of nvim-lspconfig
-- Loaded on VeryLazy event from init.lua
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- ── LSP Keymaps (attached per-buffer when an LSP connects) ──
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("ponraaj-lsp-attach", { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    -- Attach nvim-navic for breadcrumbs when supported
    local navic_ok, navic = pcall(require, "nvim-navic")
    if navic_ok and client and client.server_capabilities.documentSymbolProvider then
      navic.attach(client, event.buf)
    end

    -- Navigation
    map("gd", vim.lsp.buf.definition, "Go to definition")
    map("gD", vim.lsp.buf.declaration, "Go to declaration")
    map("gi", vim.lsp.buf.implementation, "Go to implementation")
    map("gr", vim.lsp.buf.references, "Show references")
    map("gt", vim.lsp.buf.type_definition, "Go to type definition")

    -- Information
    map("K", vim.lsp.buf.hover, "Hover documentation")
    map("<C-k>", vim.lsp.buf.signature_help, "Signature help")

    -- Actions
    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")

    -- Formatting (manual)
    map("<leader>cf", function()
      vim.lsp.buf.format({ bufnr = event.buf, async = true })
    end, "Format buffer")

    -- ── Auto-format on save ───────────────────────────────────
    if client and client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = event.buf,
        callback = function()
          vim.lsp.buf.format({
            bufnr = event.buf,
            id = client.id,
            async = false,
          })
        end,
      })
    end

    -- Diagnostics
    map("<leader>d", vim.diagnostic.open_float, "Show diagnostics")
    map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
    map("]d", vim.diagnostic.goto_next, "Next diagnostic")
  end,
})

-- ── Diagnostic Display ──────────────────────────────────────
vim.diagnostic.config({
  virtual_text = { prefix = "●", spacing = 4 },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
})

-- Diagnostic signs in the gutter
local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- ── Global LSP Capabilities ─────────────────────────────────
-- Extend capabilities for all servers with cmp-nvim-lsp support
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
  capabilities = vim.tbl_deep_extend("force", capabilities, cmp_lsp.default_capabilities())
end

-- Helper function to find root directory using vim.fs.root()
-- This prevents LSP from restarting when switching files in the same project
local function get_root_dir(fname)
  return vim.fs.root(fname, { ".git", ".hg", ".svn", "Cargo.toml", "go.mod", "package.json" })
end

-- Apply shared config to ALL LSP servers
-- Using root_dir instead of root_markers for stable project detection
-- Adding reuse_client to prevent LSP restarts on file save/buffer switch
vim.lsp.config("*", {
  capabilities = capabilities,
  root_dir = get_root_dir,
  -- Reuse existing client if it's already running for the same root
  reuse_client = function(client, fname)
    local root = get_root_dir(fname)
    if root then
      for _, existing_client in ipairs(vim.lsp.get_clients()) do
        if existing_client.name == client.name and existing_client.config.root_dir == root then
          return true
        end
      end
    end
    return false
  end,
})

-- ── Mason Setup (installs LSP server binaries) ──────────────
-- Configured via lazy.nvim opts in plugins/lsp.lua

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Server Configurations (Neovim 0.11+ native vim.lsp.config)
-- Each call merges with the global "*" config above
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- ── Lua ─────────────────────────────────────────────────────
vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml" },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
      completion = { callSnippet = "Replace" },
    },
  },
})

-- ── Go ──────────────────────────────────────────────────────
vim.lsp.config("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod" },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
      gofumpt = true,  -- Use gofumpt for formatting
    },
  },
})

-- ── C/C++ ───────────────────────────────────────────────────
vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=llvm",
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  root_markers = { ".clangd", ".clang-tidy", ".clang-format", "compile_commands.json", "compile_flags.txt" },
})

-- ── TypeScript / JavaScript ─────────────────────────────────
vim.lsp.config("ts_ls", {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json" },
})

-- ── Python ──────────────────────────────────────────────────
vim.lsp.config("basedpyright", {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json" },
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
      },
    },
    -- Use ruff for formatting (requires ruff installed via mason)
    python = {
      formatting = {
        provider = "ruff",
      },
    },
  },
})

-- ── Rust ─────────────────────────────────────────────────────
vim.lsp.config("rust_analyzer", {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", "rust-project.json" },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
        loadOutDirsFromCheck = true,
      },
      checkOnSave = {
        command = "clippy",
      },
      procMacro = {
        enable = true,
      },
    },
  },
})

-- ── JSON ─────────────────────────────────────────────────────
-- Uses before_init to lazy-load schemastore only when LSP starts
vim.lsp.config("jsonls", {
  filetypes = { "json", "jsonc" },
  -- before_init runs when LSP attaches, ensuring schemastore is loaded
  before_init = function(_, new_config)
    new_config.settings.json.schemas = new_config.settings.json.schemas or {}
    vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
  end,
  settings = {
    json = {
      format = { enable = true },
      validate = { enable = true },
    },
  },
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Enable all configured servers via custom FileType autocmd
-- Using vim.lsp.start() directly instead of vim.lsp.enable() to avoid
-- timing issues where FileType fires before vim.lsp.enable() sets up autocommands
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
local lsp_servers = {
  "lua_ls",
  "gopls",
  "clangd",
  "ts_ls",
  "basedpyright",
  "rust_analyzer",
  "jsonls",
}

-- Create autocmd to start LSPs when FileType is set
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if not ft or ft == "" then return end

    for _, server_name in ipairs(lsp_servers) do
      local config = vim.lsp.config[server_name]
      if config and config.filetypes and vim.tbl_contains(config.filetypes, ft) then
        -- Check if not already attached
        local clients = vim.lsp.get_clients({ bufnr = args.buf, name = server_name })
        if #clients == 0 then
          vim.lsp.start(config, { bufnr = args.buf })
        end
      end
    end
  end,
})
