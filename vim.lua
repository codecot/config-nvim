-- ~/.config/nvim/vim.lua
-- Workaround for E1155 error in Neovim 0.9.5

-- This file can be sourced before init.lua to prevent the E1155 error

-- Temporarily disable the problematic autocmd creation
local original_nvim_create_autocmd = vim.api.nvim_create_autocmd

vim.api.nvim_create_autocmd = function(event, opts)
  -- Skip problematic ALL event autocmds that cause E1155
  if type(event) == "string" and event:upper() == "ALL" then
    return -1 -- Return dummy autocmd id
  end
  return original_nvim_create_autocmd(event, opts)
end

-- Restore original function after syntax loading is complete
vim.schedule(function()
  vim.api.nvim_create_autocmd = original_nvim_create_autocmd
end)
