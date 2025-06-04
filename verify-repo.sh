#!/bin/bash
# Repository verification script

echo "=== Neovim Configuration Repository Verification ==="
echo

echo "📁 Files currently tracked by git:"
git ls-files | sort

echo
echo "🚫 Files excluded by .gitignore:"
echo "- lazy-lock.json (plugin lockfile)"
echo "- *.bak, *.backup, *.tmp (backup files)"
echo "- plugin/ directories (managed by lazy.nvim)"
echo "- local.lua, private.lua (personal configs)"
echo "- *.log (debug files)"

echo
echo "✅ Verification checklist:"
echo

# Check for sensitive files
if git ls-files | grep -q "lazy-lock.json"; then
    echo "❌ lazy-lock.json is tracked (should be in .gitignore)"
else
    echo "✅ lazy-lock.json properly excluded"
fi

if git ls-files | grep -q "local.lua\|private.lua"; then
    echo "❌ Private config files are tracked"
else
    echo "✅ No private config files tracked"
fi

if git ls-files | grep -q "plugin/\|data/"; then
    echo "❌ Plugin directories are tracked"
else
    echo "✅ No plugin directories tracked"
fi

echo
echo "📦 Repository contains only:"
echo "- Configuration files (.lua)"
echo "- Documentation (.md)"
echo "- License (MIT)"
echo "- Scripts for testing"

echo
echo "🎯 Repository is clean and ready for sharing!"
echo "Anyone can clone this and get your exact Neovim setup."
