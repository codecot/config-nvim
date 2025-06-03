-- ~/.config/nvim/lua/autocmds.lua
-- Auto commands for better Neovim experience

-- Safety check for Neovim version compatibility
if vim.fn.has('nvim-0.9') == 0 then
  return
end

-- Additional safety: Only create autocmds if no syntax errors are detected
local syntax_error_detected = false
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    -- Check if E1155 occurred during startup
    local messages = vim.api.nvim_exec2("messages", { output = true })
    if messages.output:match("E1155") then
      syntax_error_detected = true
      vim.notify("E1155 detected - using minimal autocmds", vim.log.levels.WARN)
    end
  end,
})

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Wrap autocmd creation in pcall for error safety
local function safe_autocmd(event, opts)
  if syntax_error_detected then
    return -- Skip if syntax errors detected
  end
  local success, err = pcall(autocmd, event, opts)
  if not success then
    vim.notify("Autocmd creation failed: " .. tostring(err), vim.log.levels.WARN)
  end
end

-- General settings
local general = augroup("General", { clear = true })

-- Highlight on yank
safe_autocmd("TextYankPost", {
  group = general,
  desc = "Highlight yanked text",
  callback = function()
    pcall(vim.highlight.on_yank, { higroup = "Visual", timeout = 200 })
  end,
})

-- Remove trailing whitespace on save
safe_autocmd("BufWritePre", {
  group = general,
  desc = "Remove trailing whitespace",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    pcall(vim.cmd, [[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- Auto close nvim-tree when it's the last window
safe_autocmd("BufEnter", {
  group = general,
  desc = "Auto close nvim-tree",
  callback = function()
    if vim.fn.winnr("$") == 1 and vim.bo.filetype == "NvimTree" then
      pcall(vim.cmd, "quit")
    end
  end,
})

-- Restore cursor position
safe_autocmd("BufReadPost", {
  group = general,
  desc = "Restore cursor position",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Auto resize panes when window is resized
safe_autocmd("VimResized", {
  group = general,
  desc = "Auto resize panes",
  callback = function()
    pcall(vim.cmd, "tabdo wincmd =")
  end,
})

-- File type specific settings
local filetype = augroup("FileType", { clear = true })

-- Disable auto commenting on new line
safe_autocmd("FileType", {
  group = filetype,
  desc = "Disable auto commenting",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Set indentation for specific file types
safe_autocmd("FileType", {
  group = filetype,
  pattern = { "lua", "python", "javascript", "typescript", "json", "yaml" },
  desc = "Set indentation",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

-- Wrap text in markdown and text files
safe_autocmd("FileType", {
  group = filetype,
  pattern = { "markdown", "text", "gitcommit" },
  desc = "Wrap text",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.textwidth = 80
  end,
})

-- Terminal settings
local terminal = augroup("Terminal", { clear = true })

safe_autocmd("TermOpen", {
  group = terminal,
  desc = "Terminal settings",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    pcall(vim.cmd, "startinsert")
  end,
})

-- Alpha (start screen) settings
local alpha_group = augroup("Alpha", { clear = true })

safe_autocmd("User", {
  group = alpha_group,
  pattern = "AlphaReady",
  desc = "Disable status line for alpha",
  callback = function()
    vim.opt.laststatus = 0
  end,
})

safe_autocmd("BufUnload", {
  group = alpha_group,
  buffer = 0,
  desc = "Enable status line after alpha",
  callback = function()
    vim.opt.laststatus = 3
  end,
})
