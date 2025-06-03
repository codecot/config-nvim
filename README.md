# 🚀 Modern Neovim Configuration

A comprehensive, production-ready Neovim configuration optimized for development with multiple configuration variants for different use cases.

![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-blue.svg?style=for-the-badge)

## ✨ Features

- 🎨 **Beautiful UI** with Catppuccin theme and modern status line
- 🔍 **Fuzzy Finding** with Telescope for files and text search
- 🌳 **File Explorer** with nvim-tree for project navigation
- 📝 **Smart Editing** with auto-pairs, surround, and text manipulation
- 🗂️ **Buffer Management** with tab-style buffer line
- 🔧 **Key Discovery** with which-key for learning shortcuts
- 🎯 **Git Integration** with signs and branch information
- 📊 **Syntax Highlighting** with Treesitter
- 🏠 **Start Screen** with Alpha dashboard
- 🔄 **Auto Commands** for enhanced workflow
- ⚡ **Performance Optimized** for Neovim 0.9.5+

## 🎯 Multiple Configuration Variants

| Configuration       | Description                                                   | Best For                |
| ------------------- | ------------------------------------------------------------- | ----------------------- |
| `init.lua`          | **Main config** - Full featured with E1155 error handling     | Daily development work  |
| `init-safe.lua`     | **Zero errors** - All features with complete error prevention | Production environments |
| `init-minimal.lua`  | **Lightweight** - Essential plugins only                      | Low-resource systems    |
| `init-enhanced.lua` | **Feature-rich** - Maximum functionality                      | Power users             |
| `init-complex.lua`  | **LSP ready** - Full language server support                  | Neovim 0.10+ upgrade    |

## 🚀 Quick Start

### Prerequisites

- Neovim 0.9.5+ (tested on 0.9.5)
- Git
- A terminal with true color support
- Optional: A [Nerd Font](https://www.nerdfonts.com/) for icons

### Installation

```bash
# Backup existing configuration
mv ~/.config/nvim ~/.config/nvim.backup

# Clone this repository
git clone git@github.com:codecot/config-nvim.git ~/.config/nvim

# Start Neovim (plugins will auto-install)
nvim
```

### First Launch

1. **Wait for plugins to install** (automatic on first launch)
2. **Restart Neovim** after installation completes
3. **Press `<Space>` + `?`** to see available keybindings
4. **Run `:checkhealth`** to verify everything is working

## ⌨️ Key Bindings

### Essential Shortcuts

| Key         | Action            | Description                       |
| ----------- | ----------------- | --------------------------------- |
| `<Space>`   | **Leader Key**    | Primary modifier for all commands |
| `<Space>?`  | **Help**          | Show all available keybindings    |
| `<Space>ff` | **Find Files**    | Fuzzy file finder                 |
| `<Space>fg` | **Find Text**     | Search text in all files          |
| `<Space>e`  | **File Explorer** | Toggle nvim-tree                  |
| `Shift+h/l` | **Buffer Nav**    | Previous/Next buffer              |
| `<C-s>`     | **Save**          | Save current file                 |
| `jk`        | **Exit Insert**   | Quick escape from insert mode     |

### Advanced Navigation

| Key         | Action              | Mode   |
| ----------- | ------------------- | ------ |
| `gd`        | Go to definition    | Normal |
| `gr`        | Go to references    | Normal |
| `K`         | Hover documentation | Normal |
| `<Space>ca` | Code actions        | Normal |
| `gcc`       | Toggle line comment | Normal |
| `gc`        | Toggle comment      | Visual |

### Window Management

| Key                      | Action           |
| ------------------------ | ---------------- |
| `<C-h/j/k/l>`            | Navigate windows |
| `<C-Up/Down/Left/Right>` | Resize windows   |
| `<Space>w`               | Save file        |
| `<Space>q`               | Quit             |

## 📦 Included Plugins

### Core Plugins

- **[lazy.nvim](https://github.com/folke/lazy.nvim)** - Modern plugin manager
- **[catppuccin](https://github.com/catppuccin/nvim)** - Beautiful pastel theme
- **[which-key.nvim](https://github.com/folke/which-key.nvim)** - Key binding discovery

### Navigation & UI

- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)** - Fuzzy finder
- **[nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)** - File explorer
- **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)** - Status line
- **[bufferline.nvim](https://github.com/akinsho/bufferline.nvim)** - Buffer tabs
- **[alpha-nvim](https://github.com/goolord/alpha-nvim)** - Start screen

### Editing & Development

- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Syntax highlighting
- **[nvim-autopairs](https://github.com/windwp/nvim-autopairs)** - Auto brackets
- **[nvim-surround](https://github.com/kylechui/nvim-surround)** - Text manipulation
- **[Comment.nvim](https://github.com/numToStr/Comment.nvim)** - Smart commenting
- **[indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)** - Indent guides

### Git Integration

- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)** - Git decorations

### Utilities

- **[mini.icons](https://github.com/echasnovski/mini.icons)** - Icon support
- **[plenary.nvim](https://github.com/nvim-lua/plenary.nvim)** - Utility library

## 🔧 Configuration Structure

```
~/.config/nvim/
├── init.lua                    # Main configuration file
├── init-safe.lua              # Error-free variant
├── init-minimal.lua           # Lightweight variant
├── init-enhanced.lua          # Feature-rich variant
├── init-complex.lua           # LSP-ready variant
├── lua/
│   ├── options.lua            # Vim settings and options
│   ├── keymaps.lua            # Key bindings
│   ├── autocmds.lua           # Auto commands
│   ├── enhanced-plugins.lua   # Full plugin configuration
│   ├── minimal-plugins.lua    # Essential plugins only
│   └── ...                    # Additional configurations
├── FINAL-STATUS.md            # Detailed status documentation
├── QUICK-REFERENCE.md         # User quick reference
└── README.md                  # This file
```

## 🔄 Switching Configurations

```bash
cd ~/.config/nvim

# Switch to error-free configuration
cp init-safe.lua init.lua

# Switch to minimal configuration
cp init-minimal.lua init.lua

# Switch to enhanced configuration
cp init-enhanced.lua init.lua

# Switch to LSP-ready configuration (requires Neovim 0.10+)
cp init-complex.lua init.lua
```

## 🛠️ Customization

### Changing Theme

Edit the theme in your plugin configuration:

```lua
-- In lua/enhanced-plugins.lua
require("catppuccin").setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha
})
```

### Adding New Plugins

Add to the lazy.nvim setup in your plugins file:

```lua
{
  "author/plugin-name",
  config = function()
    -- Plugin configuration
  end
}
```

### Modifying Key Bindings

Edit `lua/keymaps.lua`:

```lua
vim.keymap.set("n", "<leader>your_key", ":YourCommand<CR>", { desc = "Description" })
```

## 🩺 Troubleshooting

### Common Issues

1. **Plugins not loading**: Run `:Lazy sync` to reinstall plugins
2. **Key bindings not working**: Check for conflicts with `:checkhealth which-key`
3. **Colorscheme issues**: Ensure terminal supports true colors
4. **Performance issues**: Try the minimal configuration

### Health Checks

```vim
:checkhealth
:checkhealth which-key
:checkhealth telescope
:checkhealth nvim-treesitter
```

### Reset Configuration

```bash
# Backup current config
mv ~/.config/nvim ~/.config/nvim.backup

# Fresh installation
git clone git@github.com:codecot/config-nvim.git ~/.config/nvim
```

## 📈 Performance

This configuration is optimized for performance:

- ⚡ **Lazy loading** for all plugins
- 🔄 **Minimal startup time** with deferred loading
- 🎯 **Selective parsing** with Treesitter
- 💾 **Efficient file handling** with proper options

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This configuration is open source and available under the [MIT License](LICENSE).

## 🙏 Acknowledgments

- [Neovim](https://neovim.io/) team for the amazing editor
- [Catppuccin](https://catppuccin.com/) for the beautiful theme
- Plugin authors for their incredible work
- Neovim community for inspiration and support

## 📞 Support

- 📖 Check the [documentation files](FINAL-STATUS.md) for detailed information
- 🔍 Use the [quick reference guide](QUICK-REFERENCE.md) for shortcuts
- 🐛 Open an issue for bugs or feature requests
- 💬 Start a discussion for questions

---

**Happy coding with Neovim! 🎉**

> This configuration has been tested and optimized for daily development work. It strikes a balance between functionality and performance while maintaining compatibility with Neovim 0.9.5+.
