-- Enhanced init.lua for Neovim 0.9.5
-- Switch between this and the minimal version as needed

require("options")
require("keymaps")
require("autocmds")
require("enhanced-plugins")

-- Set colorscheme with fallback
vim.schedule(function()
  local status_ok, _ = pcall(vim.cmd.colorscheme, "catppuccin")
  if not status_ok then
    vim.notify("Colorscheme not found, using default", vim.log.levels.WARN)
  end
end)

-- Create some useful commands
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
