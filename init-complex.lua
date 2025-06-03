-- ~/.config/nvim/init.lua

-- Load basic configuration
require("options")
require("keymaps")

-- Load plugins (this will configure everything)
require("plugins")

-- Set colorscheme after plugins are loaded
vim.schedule(function()
  pcall(vim.cmd.colorscheme, "catppuccin")
end)
