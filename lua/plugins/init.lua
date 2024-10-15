return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- This line enables the plugin to run before saving
    opts = require "configs.conform",
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require "configs.null-ls"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local nvchad_lsp = require "nvchad.configs.lspconfig"
      local on_attach = nvchad_lsp.on_attach
      local capabilities = nvchad_lsp.capabilities

      local lspconfig = require "lspconfig"

      -- Configure your language servers here
      local servers = { "html", "cssls", "clangd", "gopls", "pyright" }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }
      end

      -- You can add more custom LSP configurations here if needed
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "html-lsp",
        "css-lsp",
        "ruff",
        "gopls",
        "clang-format",
        "pyright",
        "black",
        "gofumpt",
        "pyright-langserver",
      },
    },
  },
  {
    "xeluxee/competitest.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    config = function()
      require("competitest").setup()
    end,
  },
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = {
  --     ensure_installed = {
  --       "vim", "lua", "vimdoc",
  --       "html", "css"
  --     },
  --   },
  -- },
}
