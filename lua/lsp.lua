-- Very simple LSP Configuration for Neovim 0.9.5
local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  vim.notify("LSPConfig not available", vim.log.levels.WARN)
  return
end

-- Setup Mason only if available
local mason_ok, mason = pcall(require, "mason")
if mason_ok then
  mason.setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    }
  })
  
  -- Setup mason-lspconfig only if available
  local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
  if mason_lspconfig_ok then
    mason_lspconfig.setup({
      ensure_installed = {
        "tsserver",
        "lua_ls",
        "jsonls",
        "html",
        "cssls",
      },
      automatic_installation = true,
    })
  end
end

-- Basic capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Common on_attach function
local function on_attach(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  
  -- LSP keymaps
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)
end

-- Basic server configs
local servers = {
  tsserver = {},
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false
        },
        telemetry = { enable = false }
      }
    }
  },
  html = {},
  cssls = {},
  jsonls = {},
}

-- Setup servers
for server_name, server_config in pairs(servers) do
  server_config.capabilities = capabilities
  server_config.on_attach = on_attach
  
  local setup_ok, _ = pcall(lspconfig[server_name].setup, server_config)
  if not setup_ok then
    -- Silently continue if server setup fails
  end
end
