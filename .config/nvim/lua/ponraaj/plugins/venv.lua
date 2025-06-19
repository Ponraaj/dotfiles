return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
  },
  lazy = false, -- Changed to false to ensure it loads early
  branch = "regexp",
  cmd = "VenvSelect",
  keys = {
    { "<leader>vs", "<cmd>VenvSelect<cr>" },
    { "<leader>vc", "<cmd>VenvSelectCached<cr>" },
  },
  ft = "python",
  opts = {
    auto_refresh = true,
    notify_user_on_venv_activation = true,
  },

  config = function(_, opts)
    require("venv-selector").setup(opts)

    -- Simple auto-activation function
    local function auto_select_venv()
      local cwd = vim.fn.getcwd()

      -- Check for Poetry project
      if vim.fn.filereadable(cwd .. "/pyproject.toml") == 1 then
        vim.cmd("VenvSelect")
        return
      end

      -- Check for Pipenv project
      if vim.fn.filereadable(cwd .. "/Pipfile") == 1 then
        vim.cmd("VenvSelect")
        return
      end

      -- Check for common venv directories
      local venv_dirs = { "venv", ".venv", "env", ".env" }
      for _, dir in ipairs(venv_dirs) do
        if vim.fn.isdirectory(cwd .. "/" .. dir) == 1 then
          vim.cmd("VenvSelect")
          return
        end
      end

      -- Check for requirements.txt or setup.py
      if vim.fn.filereadable(cwd .. "/requirements.txt") == 1 or vim.fn.filereadable(cwd .. "/setup.py") == 1 then
        vim.cmd("VenvSelect")
        return
      end
    end

    -- Auto-select when opening Python files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "python",
      callback = function()
        vim.defer_fn(auto_select_venv, 500)
      end,
    })

    -- Auto-select when changing to Python project directories
    vim.api.nvim_create_autocmd("DirChanged", {
      pattern = "*",
      callback = function()
        local cwd = vim.fn.getcwd()
        local has_python_project = vim.fn.filereadable(cwd .. "/pyproject.toml") == 1
          or vim.fn.filereadable(cwd .. "/Pipfile") == 1
          or vim.fn.filereadable(cwd .. "/requirements.txt") == 1
          or vim.fn.filereadable(cwd .. "/setup.py") == 1
          or vim.fn.glob(cwd .. "/*.py") ~= ""

        if has_python_project then
          vim.defer_fn(auto_select_venv, 300)
        end
      end,
    })
  end,
}
