# Neovim Configuration

A personal Neovim configuration written in Lua, organised as a small set of
startup profiles so the same repo can be used on machines with different
Neovim versions and resource budgets.

- Plugin manager: [lazy.nvim](https://github.com/folke/lazy.nvim)
- Theme: [Catppuccin](https://github.com/catppuccin/nvim)
- Target runtime: **Neovim 0.9.5+** (some profiles need 0.10+)

## Installation

Back up any existing config, then clone this repo into `~/.config/nvim`:

```bash
mv ~/.config/nvim ~/.config/nvim.backup 2>/dev/null

git clone git@github.com:codecot/config-nvim.git ~/.config/nvim

nvim   # lazy.nvim will install plugins on first launch
```

On first launch, wait for the plugins to install and then restart Neovim.

## Configuration profiles

The repo ships several `init-*.lua` files. The active profile is whichever
file is named `init.lua`. To switch profiles, copy the desired variant over
`init.lua` from the repo root:

```bash
cd ~/.config/nvim
cp init-safe.lua init.lua        # then restart Neovim
```

| Profile  | File                 | What it loads                                                                    | When to use                                                             |
| -------- | -------------------- | -------------------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| Safe     | `init-safe.lua`      | `options`, `keymaps`, `enhanced-plugins` (falls back to `minimal-plugins`), with a guard against the Neovim 0.9.5 `E1155` startup error | Default / stable fallback. This is the content of the shipped `init.lua`. |
| Minimal  | `init-minimal.lua`   | `options`, `keymaps`, `autocmds`, `enhanced-plugins`                             | Lightweight setup — same plugin set as Enhanced but without the E1155 guard. |
| Enhanced | `init-enhanced.lua`  | `options`, `keymaps`, `autocmds`, `enhanced-plugins`                             | Main richer profile (identical to Minimal today; kept as a named target for future divergence). |
| Complex  | `init-complex.lua`   | `options`, `keymaps`, `plugins` (the LSP-enabled plugin set)                     | Full / experimental profile. Requires **Neovim 0.10+** for the LSP features. |

`init-enhanced-backup.lua` is a literal backup of `init-enhanced.lua` and is
not intended to be used directly.

See `QUICK-REFERENCE.md` for the day-to-day keybindings and
`E1155-FIX.md` if you hit the `E1155: Cannot define autocommands for ALL
events` error on Neovim 0.9.5.

## Verification scripts

Three Bash scripts live at the repo root. They are optional — they only
sanity-check that Neovim starts with this config and that the repo is tidy.
Run them from the repo root:

| Script            | Purpose                                                                                     | Success looks like                                                            |
| ----------------- | ------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| `test-config.sh`  | Checks that the core Lua files exist and that `nvim --headless` starts without crashing.    | Lines marked `✓` for each file and for the two startup probes.                |
| `test-final.sh`   | Broader smoke test: basic load, absence of the `E1155` error, plugin load, which-key load, colorscheme load. | Five `✓` lines in the test summary; a `⚠` on the colorscheme step is fine on a fresh clone before plugins are installed. |
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
├── init.lua                   # active profile (currently a copy of init-safe.lua)
├── init-safe.lua              # safe profile (E1155-guarded)
├── init-minimal.lua           # lightweight profile
├── init-enhanced.lua          # main richer profile
├── init-complex.lua           # LSP / experimental profile (Neovim 0.10+)
├── init-enhanced-backup.lua   # backup copy of init-enhanced.lua
├── vim.lua                    # auxiliary Vim-side settings
├── lua/
│   ├── options.lua            # vim settings
│   ├── keymaps.lua            # key bindings
│   ├── autocmds.lua           # autocommands
│   ├── plugins.lua            # plugin set used by init-complex.lua (with LSP)
│   ├── enhanced-plugins.lua   # plugin set used by safe/minimal/enhanced
│   ├── minimal-plugins.lua    # fallback plugin set used by init-safe.lua
│   ├── no-compiler-plugins.lua
│   ├── lsp.lua
│   └── cmp-config.lua
├── test-config.sh             # smoke-test script
├── test-final.sh              # broader smoke-test script
├── verify-repo.sh             # repo hygiene check
├── PROJECT.md                 # structured project description (for automation)
├── QUICK-REFERENCE.md         # day-to-day keybindings
├── TESTING.md                 # manual test / troubleshooting notes
├── E1155-FIX.md               # notes on the Neovim 0.9.5 E1155 startup error
└── docs/archive/              # historical status / completion notes
```

## More documentation

- `QUICK-REFERENCE.md` — essential keybindings and commands.
- `TESTING.md` — manual test recipes and troubleshooting steps.
- `E1155-FIX.md` — details on the Neovim 0.9.5 `E1155` startup error and the
  workaround used by `init-safe.lua` / `init.lua`.
- `PROJECT.md` — structured project description intended for automation.
- `docs/archive/` — historical completion / status notes from earlier
  iterations; kept for context, not required reading.

## License

[MIT](LICENSE).
