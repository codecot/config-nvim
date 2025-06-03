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

# Use minimal stable config
cp init-minimal.lua init.lua

# Use enhanced config (current)
cp init-enhanced.lua init.lua

# Use complex config (for Neovim 0.10+)
cp init-complex.lua init.lua
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

- LSP keybindings are set up but LSP servers need to be installed
- Current config works without LSP for basic editing

### 4. Performance Issues

- Switch back to minimal config if enhanced version is too heavy
- The minimal config has all essential features

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

### Both Configurations Include:

- ✅ Stable plugin versions for Neovim 0.9.5
- ✅ Error handling and fallbacks
- ✅ Clean, organized structure
- ✅ Well-commented code

## Next Steps

1. **Test the configuration**: Open Neovim and try the features
2. **Learn the shortcuts**: Use `<Space>?` to see available commands
3. **Customize**: Modify colors, keybindings, or add languages as needed
4. **Consider upgrading**: Neovim 0.10+ will enable LSP features

## Backup Strategy

Your configurations are safely backed up:

- `init-minimal.lua` - Working minimal version
- `init-enhanced.lua` - Feature-rich version
- `init-complex.lua` - Original with LSP (for future use)

You can always revert to any version by copying it to `init.lua`.
