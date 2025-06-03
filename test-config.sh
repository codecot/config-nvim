#!/bin/bash
# ~/.config/nvim/test-config.sh
# Script to test Neovim configuration

echo "Testing Neovim Enhanced Configuration..."
echo "========================================"

# Check if files exist
echo "Checking configuration files..."
for file in init.lua lua/options.lua lua/keymaps.lua lua/autocmds.lua lua/enhanced-plugins.lua; do
    if [ -f "$file" ]; then
        echo "✓ $file exists"
    else
        echo "✗ $file missing"
    fi
done

echo ""
echo "Testing Neovim startup..."

# Test basic startup
if nvim --headless -c "echo 'Basic test passed'" -c "qa" 2>/dev/null; then
    echo "✓ Basic Neovim startup works"
else
    echo "✗ Basic Neovim startup failed"
fi

# Test plugin loading
if nvim --headless -c "lua require('lazy').setup({})" -c "echo 'Plugin system works'" -c "qa" 2>/dev/null; then
    echo "✓ Lazy.nvim plugin system works"
else
    echo "✗ Lazy.nvim plugin system failed"
fi

echo ""
echo "Configuration test complete!"
echo "To test manually:"
echo "  nvim"
echo "  :checkhealth"
echo "  <Space>? (to see which-key help)"
echo "  <Space>ff (to test telescope)"
echo "  <Space>e (to test file explorer)"
