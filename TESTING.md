# Neovim Configuration Testing & Troubleshooting Guide

## Quick Test Commands

Test your enhanced Neovim configuration with these commands:

```bash
# 1. Basic startup test
nvim --version

# 2. Test configuration loading
nvim --headless -c "echo 'Config loaded'" -c "qa"

# 3. Interactive test - open Neovim and try these:
nvim
# Inside Neovim:
# :checkhealth
# <Space>? (shows which-key help)
# <Space>ff (find files)
# <Space>e (file explorer)
```

## Configuration Switching

```bash
cd ~/.config/nvim

# Use the Complex / LSP config (for Neovim 0.10+)
cp init-complex.lua init.lua

# Revert to the Default config
git checkout init.lua
```

## Common Issues & Solutions

### 1. Plugin Loading Errors

```bash
# Clear plugin cache if needed
rm -rf ~/.local/share/nvim/lazy/
# Then restart Neovim
```

### 2. Colorscheme Not Found

- The config includes fallback handling
- Catppuccin will be installed automatically on first run

### 3. LSP Keybindings Don't Work

- On first use, `mason` installs the servers in the background — wait for
  `:Mason` to show `basedpyright`/`ruff` as installed, then reopen the file
- `basedpyright` needs Node.js on `PATH`
- Check `:checkhealth lsp` and `:LspInfo`

### Python IDE smoke test

```bash
# Open a Python file and confirm the IDE attaches:
nvim example.py
# Inside Neovim:
# :Mason          → basedpyright, ruff, debugpy installed
# :checkhealth     → lsp / treesitter / dap sections OK
# K / gd / gr      → hover / definition / references
# <leader>cf       → format with ruff
# <leader>db,<leader>dc → debug; <leader>tt → run nearest test
# :VenvSelect      → pick a virtualenv (needs the `fd` CLI)
```

### 4. Performance Issues

- The Default config loads the enhanced plugin set, falling back to the
  minimal plugin set (`lua/minimal-plugins.lua`) if it fails to load

## Key Features Summary

### Enhanced Configuration Includes:

- ✅ Beautiful start screen (alpha-nvim)
- ✅ Buffer tabs (bufferline.nvim)
- ✅ Keybinding discovery (which-key.nvim)
- ✅ Git integration (gitsigns.nvim)
- ✅ Indentation guides (indent-blankline.nvim)
- ✅ Text manipulation (nvim-surround)
- ✅ Enhanced file explorer and fuzzy finder
- ✅ Better autocmds and options
- ✅ Improved keymaps

### Both Profiles Include:

- ✅ Stable, pinned plugin versions
- ✅ Error handling and fallbacks
- ✅ Clean, organized structure
- ✅ Well-commented code

## Next Steps

1. **Test the configuration**: Open Neovim and try the features
2. **Learn the shortcuts**: Use `<Space>?` to see available commands
3. **Customize**: Modify colors, keybindings, or add languages as needed
4. **Consider upgrading**: Neovim 0.10+ will enable LSP features

## Profiles

- `init.lua` - Default profile (enhanced plugin set, minimal fallback)
- `init-complex.lua` - LSP-enabled profile (for Neovim 0.10+)

Switch to Complex by copying it over `init.lua`; revert with
`git checkout init.lua`.
