-- ~/.config/nvim/init.lua
-- Default profile: options, keymaps, autocmds and the enhanced plugin set.
-- To use the LSP / experimental profile instead, copy init-complex.lua over
-- this file and restart Neovim.

-- Enable syntax early, before plugins register their FileType autocommands.
-- Some Neovim builds error with `E1155: Cannot define autocommands for ALL
-- events` when the stock syntax/syntax.vim runs `au! FileType *` against a
-- large autocommand table (i.e. the default post-init `syntax on`). Running it
-- now, while that table is still small, sources the file cleanly once and makes
-- the later default a no-op. Highlighting itself is handled by treesitter.
pcall(vim.cmd, "syntax enable")

require("options")
require("keymaps")
require("autocmds")

-- Load the enhanced plugin set, falling back to the minimal set if it fails.
local plugins_ok = pcall(require, "enhanced-plugins")
if not plugins_ok then
  pcall(require, "minimal-plugins")
end

-- Set colorscheme after plugins are loaded, with a graceful fallback.
vim.schedule(function()
  local status_ok = pcall(vim.cmd.colorscheme, "catppuccin")
  if not status_ok then
    vim.notify("Colorscheme not found, using default", vim.log.levels.WARN)
  end
end)

-- Useful commands
vim.api.nvim_create_user_command("ReloadConfig", function()
  for name, _ in pairs(package.loaded) do
    if name:match("^user") or name:match("^options") or name:match("^keymaps") then
      package.loaded[name] = nil
    end
  end
  dofile(vim.env.MYVIMRC)
  vim.notify("Config reloaded!", vim.log.levels.INFO)
end, { desc = "Reload Neovim config" })

vim.api.nvim_create_user_command("ToggleBackground", function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end, { desc = "Toggle background" })
