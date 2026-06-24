# Neovim Configuration

A personal Neovim configuration written in Lua. The Default profile is a
modern, Python-first IDE built on Neovim's native LSP API; a legacy Complex
profile is kept for older setups.

- Plugin manager: [lazy.nvim](https://github.com/folke/lazy.nvim)
- Theme: [Catppuccin](https://github.com/catppuccin/nvim)
- LSP / completion: native `vim.lsp` + `mason.nvim` + `nvim-cmp`
- Target runtime: **Neovim 0.11+** for the Default profile (native LSP API)

### Python IDE features (Default profile)

| Area        | Tooling                                              |
| ----------- | --------------------------------------------------- |
| LSP         | `basedpyright` (types/IntelliSense) + `ruff` (lint) |
| Completion  | `nvim-cmp` + LuaSnip                                 |
| Formatting  | `conform.nvim` → `ruff` (format-on-save)            |
| Debugging   | `nvim-dap` + `nvim-dap-python` (debugpy) + dap-ui   |
| Testing     | `neotest` + `neotest-python` (pytest)               |
| Virtualenv  | `venv-selector.nvim` (`:VenvSelect`)                |
| Highlight   | `nvim-treesitter` (main branch) — `python` parser   |

All language servers and tools are installed automatically by `mason` on
first use — nothing system-wide is needed beyond:

- **Neovim 0.11+** — the IDE layer uses the native LSP API. On an older
  runtime the layer is skipped automatically (see *Installing / upgrading
  Neovim* below); the rest of the editor still loads.
- **Python 3** and **Node.js** (Node is required by `basedpyright`)
- **`fd`** on `PATH` — only for `:VenvSelect`. On Ubuntu the package is
  `fd-find` and the binary is `fdfind`, so expose it under the expected name:

  ```bash
  sudo apt install fd-find
  mkdir -p ~/.local/bin && ln -sf "$(command -v fdfind)" ~/.local/bin/fd
  ```

### Installing / upgrading Neovim

The IDE layer needs **Neovim 0.11+**; distro packages are often older. Two easy
ways to get a current build:

```bash
# Option A — snap (tracks latest stable)
sudo snap install nvim --classic

# Option B — official tarball (no snap / FUSE needed)
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
```

If an old `apt` Neovim is installed, remove it first (`sudo apt remove neovim`)
and run `hash -r` so the shell finds the new binary. Verify with
`nvim --version` (want `≥ 0.11`), then run `nvim "+Lazy! sync" +qa`.

Key bindings are buffer-local and discoverable via which-key (`<leader>` is
space). Highlights: `gd`/`gr`/`K` (LSP nav/hover), `<leader>ca` (code action),
`<leader>rn` (rename), `<leader>cf` (format), `<leader>d*` (debug),
`<leader>t*` (test), `<leader>vs` (select venv). See `QUICK-REFERENCE.md`.

## Installation

Back up any existing config, then clone this repo into `~/.config/nvim`:

```bash
mv ~/.config/nvim ~/.config/nvim.backup 2>/dev/null

git clone git@github.com:codecot/config-nvim.git ~/.config/nvim

nvim   # lazy.nvim will install plugins on first launch
```

On first launch, wait for the plugins to install and then restart Neovim.

## Configuration profiles

The active profile is the file named `init.lua`. The Default profile ships as
`init.lua`. To switch to the Complex profile, copy it over `init.lua` from the
repo root:

```bash
cd ~/.config/nvim
cp init-complex.lua init.lua        # then restart Neovim
```

| Profile  | File               | What it loads                                                                                       | When to use                                                                 |
| -------- | ------------------ | --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------- |
| Default  | `init.lua`         | `options`, `keymaps`, `autocmds`, `enhanced-plugins` + `plugins/ide` (LSP/DAP/test), minimal fallback | Day-to-day setup. The full Python IDE. Needs **Neovim 0.11+**.              |
| Complex  | `init-complex.lua` | `options`, `keymaps`, `plugins` (the older pinned LSP set)                                           | Legacy profile, predates the IDE layer. Kept for older Neovim; unmaintained. |

See `QUICK-REFERENCE.md` for the day-to-day keybindings.

## Verification scripts

Three Bash scripts live at the repo root. They are optional — they only
sanity-check that Neovim starts with this config and that the repo is tidy.
Run them from the repo root:

| Script            | Purpose                                                                                     | Success looks like                                                            |
| ----------------- | ------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| `test-config.sh`  | Checks that the core Lua files exist and that `nvim --headless` starts without crashing.    | Lines marked `✓` for each file and for the two startup probes.                |
| `test-final.sh`   | Broader smoke test: basic load, clean startup, plugin load, which-key load, colorscheme load. | Five `✓` lines in the test summary; a `⚠` on the colorscheme step is fine on a fresh clone before plugins are installed. |
| `verify-repo.sh`  | Lists the files tracked by git and checks the repo does not accidentally track `lazy-lock.json`, private config, or plugin data directories. | The three checklist items at the bottom are all `✅`.                         |

```bash
./test-config.sh
./test-final.sh
./verify-repo.sh
```

A failure that is clearly caused by the local environment (missing `nvim`,
plugins not yet installed, etc.) rather than this repo is expected on a
fresh clone.

## Repository layout

```text
~/.config/nvim/
├── init.lua                   # active / Default profile
├── init-complex.lua           # LSP / experimental profile (Neovim 0.10+)
├── lua/
│   ├── options.lua            # vim settings
│   ├── keymaps.lua            # key bindings
│   ├── autocmds.lua           # autocommands
│   ├── enhanced-plugins.lua   # Default profile: UI/editor base + IDE import
│   ├── plugins/
│   │   └── ide.lua            # LSP, completion, format, debug, test, venv
│   ├── cmp-config.lua         # nvim-cmp setup
│   ├── minimal-plugins.lua    # fallback plugin set used by init.lua
│   ├── plugins.lua            # legacy plugin set used by init-complex.lua
│   ├── lsp.lua               # legacy LSP setup (Complex profile)
│   └── no-compiler-plugins.lua
├── test-config.sh             # smoke-test script
├── test-final.sh              # broader smoke-test script
├── verify-repo.sh             # repo hygiene check
├── PROJECT.md                 # structured project description (for automation)
├── QUICK-REFERENCE.md         # day-to-day keybindings
├── TESTING.md                 # manual test / troubleshooting notes
└── docs/archive/              # historical status / completion notes
```

## More documentation

- `QUICK-REFERENCE.md` — essential keybindings and commands.
- `TESTING.md` — manual test recipes and troubleshooting steps.
- `PROJECT.md` — structured project description intended for automation.
- `docs/archive/` — historical completion / status notes from earlier
  iterations; kept for context, not required reading.

## License

[MIT](LICENSE).
