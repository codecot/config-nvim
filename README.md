# Neovim Configuration

A personal Neovim configuration written in Lua, organised as two startup
profiles so the same repo can be used on machines with different Neovim
versions and resource budgets.

- Plugin manager: [lazy.nvim](https://github.com/folke/lazy.nvim)
- Theme: [Catppuccin](https://github.com/catppuccin/nvim)
- Target runtime: **Neovim 0.9+** (the Complex profile needs 0.10+)

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

| Profile  | File               | What it loads                                                                          | When to use                                                       |
| -------- | ------------------ | -------------------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| Default  | `init.lua`         | `options`, `keymaps`, `autocmds`, `enhanced-plugins` (falls back to `minimal-plugins`) | Day-to-day setup. This is the shipped `init.lua`.                 |
| Complex  | `init-complex.lua` | `options`, `keymaps`, `plugins` (the LSP-enabled plugin set)                            | Full / experimental profile. Requires **Neovim 0.10+** for LSP.   |

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
│   ├── plugins.lua            # plugin set used by init-complex.lua (with LSP)
│   ├── enhanced-plugins.lua   # plugin set used by safe/minimal/enhanced
│   ├── minimal-plugins.lua    # fallback plugin set used by init.lua
│   ├── no-compiler-plugins.lua
│   ├── lsp.lua
│   └── cmp-config.lua
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
