-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

local servers = { "html", "cssls", "clangd" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- Custom setup for Pyright
lspconfig.pyright.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/pyright-langserver", "--stdio" },
}

-- Custom setup for gopls
lspconfig.gopls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  cmd = { "gopls" },  -- Ensure this is the correct command to start gopls
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
      usePlaceholders = true,
      completeUnimported = true,
      importShortcut = "Definition",
    },
  },
}

-- Custom clangd configuration for single-file development
lspconfig.clangd.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--header-insertion=iwyu",
    "--suggest-missing-includes",
    "--all-scopes-completion",
    "--pch-storage=memory",
    "--enable-config",
    "--fallback-style=Google",
    "--compile-commands-dir=.",  -- Look for compile_commands.json in current directory
    "--offset-encoding=utf-16",  -- Fixes some encoding issues
    "--header-insertion-decorators", -- Better header insertion
    "-j=4",  -- Number of workers
    "--query-driver=/usr/bin/g++", -- Use system g++ for includes
  },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true,
    semanticHighlighting = true,
    fallbackFlags = {  -- Default compile flags for single files
      "-std=c++17",
      "-Wall",
      "-Wextra",
      "-pedantic",
      "-I.",  -- Include current directory
      "-I/usr/include",  -- System includes
      "-I/usr/local/include",
    },
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
}
