# PROJECT

## What this project does

A Neovim editor configuration written in Lua, intended to be cloned into
`~/.config/nvim`. The Default profile (`init.lua`) is a modern, Python-first
IDE built on Neovim's native LSP API; a legacy Complex profile
(`init-complex.lua`) is kept for older setups.

## Main technologies

- Neovim 0.11+ for the Default profile (native `vim.lsp` API)
- Lua (configuration language)
- [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management
- LSP/tooling via `mason.nvim`: `basedpyright`, `ruff`, `lua_ls`, `debugpy`
- `nvim-cmp` (completion), `conform.nvim` (format), `nvim-dap` (debug),
  `neotest` (test), `nvim-treesitter` (highlight, master branch)
- Bash for the local verification/test scripts

## Project structure

- `init.lua` — main entry point loaded by Neovim; the Default profile (IDE).
- `init-complex.lua` — legacy LSP profile, selectable by copying it over
  `init.lua`. Predates the IDE layer; unmaintained.
- `lua/` — modular configuration: `options.lua`, `keymaps.lua`,
  `autocmds.lua`, `enhanced-plugins.lua` (UI/editor base + IDE import),
  `plugins/ide.lua` (LSP/completion/format/debug/test/venv), `cmp-config.lua`,
  `minimal-plugins.lua` (fallback), and the legacy `plugins.lua` / `lsp.lua` /
  `no-compiler-plugins.lua`.
- `lazy-lock.json` — pinned plugin versions managed by lazy.nvim.
- `test-config.sh`, `test-final.sh`, `verify-repo.sh` — Bash scripts that
  smoke-test the config and verify repository contents.
- `specs/` — task specifications consumed by automation.
- `README.md` — primary human entry point.
- `QUICK-REFERENCE.md`, `TESTING.md` — supporting documentation kept at the
  repo root.
- `docs/archive/` — historical completion/status notes (`FINAL-STATUS.md`,
  `FINAL-SUCCESS.md`, `MISSION-COMPLETE.md`, `REPO-SUMMARY.md`,
  `REPOSITORY-STATUS.md`, `IMPROVEMENTS.md`) preserved for context only.

## How to run locally

```bash
# Back up any existing Neovim config
mv ~/.config/nvim ~/.config/nvim.backup 2>/dev/null

# Clone into Neovim's config directory
git clone git@github.com:codecot/config-nvim.git ~/.config/nvim

# Launch Neovim — lazy.nvim will install plugins on first run
nvim
```

To smoke-test the configuration without launching the UI:

```bash
./test-config.sh
./test-final.sh
./verify-repo.sh
```

To switch to the Complex profile, copy it over `init.lua` (e.g.
`cp init-complex.lua init.lua`) and restart Neovim.

## How to deploy

There is no deploy story. This is a personal Neovim configuration installed
locally by cloning into `~/.config/nvim`; there is no server, package, or
release pipeline.

## Key external dependencies

- GitHub — hosts this repo and every plugin pulled in by `lazy-lock.json`
  (Catppuccin, Telescope, nvim-tree, lualine, bufferline, alpha-nvim,
  nvim-treesitter, nvim-autopairs, nvim-surround, Comment.nvim,
  indent-blankline, gitsigns, mini.icons, plenary, which-key, lazy.nvim, plus
  the IDE layer: mason, nvim-lspconfig, nvim-cmp, conform, nvim-dap, neotest,
  venv-selector).
- `mason` downloads language servers/tools (`basedpyright`, `ruff`, `lua_ls`,
  `debugpy`) on first use; `basedpyright` needs Node.js, `:VenvSelect` needs
  the `fd` CLI.
- No databases, APIs, or remote services are contacted at runtime.
