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
    "asibhossen897/competitest.nvim",
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
  { "wakatime/vim-wakatime", lazy = false },

  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1  -- Only enable if make is available
      },
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      require("telescope").setup({
        extensions = {
          file_browser = {
            theme = "ivy",
            hijack_netrw = true,
          },
        },
      })
      -- Load extensions safely
      local function load_extension(name)
        local ok = pcall(require("telescope").load_extension, name)
        if not ok then
          vim.notify("Failed to load telescope extension: " .. name, vim.log.levels.WARN)
        end
      end
      
      load_extension("file_browser")
      -- Only load fzf if the native library exists
      if vim.fn.filereadable(vim.fn.stdpath("data") .. "/lazy/telescope-fzf-native.nvim/build/libfzf.so") == 1 then
        load_extension("fzf")
      end
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css", "cpp", "c"
      },
    },
  },
}
