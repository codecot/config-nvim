-- ~/.config/nvim/init-safe.lua
-- Safe init that completely avoids the syntax.vim ALL events error

-- Method 1: Completely disable problematic syntax loading
vim.g.loaded_syntax_completion = 1
vim.g.loaded_syntax = 1

-- Method 2: Override the problematic autocmd function temporarily
local original_nvim_create_autocmd = vim.api.nvim_create_autocmd
vim.api.nvim_create_autocmd = function(event, opts)
  -- Block ALL event autocmds that cause E1155
  if type(event) == "string" and (event:upper() == "ALL" or event == "*") then
    return -1 -- Return dummy autocmd id
  end
  if type(event) == "table" then
    local filtered_events = {}
    for _, e in ipairs(event) do
      if e:upper() ~= "ALL" and e ~= "*" then
        table.insert(filtered_events, e)
      end
    end
    if #filtered_events == 0 then
      return -1
    end
    event = filtered_events
  end
  return original_nvim_create_autocmd(event, opts)
end

-- Load our configuration with error handling
pcall(require, "options")
pcall(require, "keymaps")

-- Load plugins with error handling
local plugins_ok, _ = pcall(require, "enhanced-plugins")
if not plugins_ok then
  -- Fallback to minimal plugins
  pcall(require, "minimal-plugins")
end

-- Restore original function and enable syntax after everything loads
vim.schedule(function()
  vim.api.nvim_create_autocmd = original_nvim_create_autocmd
  
  -- Load autocmds after syntax issues are resolved
  pcall(require, "autocmds")
  
  -- Set colorscheme with fallback
  local status_ok, _ = pcall(vim.cmd.colorscheme, "catppuccin")
  if not status_ok then
    pcall(vim.cmd.colorscheme, "default")
  end
  
  -- Safely enable syntax
  pcall(vim.cmd, "syntax enable")
end)

-- Create useful commands
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
