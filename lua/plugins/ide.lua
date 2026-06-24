-- Modern IDE layer (Neovim 0.11+ native LSP API), Python-first.
--
-- Imported by enhanced-plugins.lua via `{ import = "plugins.ide" }`. Provides:
--   * LSP        : mason + mason-lspconfig + nvim-lspconfig (basedpyright, ruff, lua_ls)
--   * Completion : nvim-cmp (config in lua/cmp-config.lua)
--   * Formatting : conform.nvim (ruff), format-on-save
--   * Debugging  : nvim-dap + nvim-dap-python (debugpy) + dap-ui
--   * Testing    : neotest + neotest-python (pytest)
--   * Virtualenv : venv-selector (requires the `fd` CLI on PATH)
--
-- Language tooling is installed on demand by mason; nothing system-wide is
-- required beyond Python 3, Node (for basedpyright) and optionally `fd`.
--
-- This whole layer targets the native LSP API (vim.lsp.config / vim.lsp.enable),
-- added in Neovim 0.11. On older Neovim it is skipped entirely so the same repo
-- still works on hosts with an older runtime (mason-lspconfig would otherwise
-- crash calling vim.lsp.enable). Such hosts get the UI/editor base only.
if vim.fn.has("nvim-0.11") == 0 then
  vim.schedule(function()
    vim.notify(
      "IDE layer (LSP/DAP/test) needs Neovim 0.11+; skipped on " .. tostring(vim.version()),
      vim.log.levels.WARN
    )
  end)
  return {}
end

return {
  -- Package manager for LSP servers, formatters and debuggers ---------------
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonToolsInstall" },
    build = ":MasonUpdate",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- Install CLI tools that are not LSP servers (formatters, debug adapters) --
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    event = "VeryLazy",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = { "ruff", "debugpy" },
        auto_update = false,
        run_on_start = true,
      })
    end,
  },

  -- LSP: mason-lspconfig bridges installed servers to nvim-lspconfig, which on
  -- Neovim 0.11+ ships the server definitions that the native vim.lsp loader
  -- reads. We configure with vim.lsp.config / vim.lsp.enable. ----------------
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local servers = { "basedpyright", "ruff", "lua_ls" }

      pcall(function()
        require("mason-lspconfig").setup({
          ensure_installed = servers,
          -- We enable servers explicitly below, after vim.lsp.config runs.
          automatic_enable = false,
        })
      end)

      -- Completion capabilities advertised to every server.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok_cmp then
        capabilities = vim.tbl_deep_extend("force", capabilities, cmp_lsp.default_capabilities())
      end
      vim.lsp.config("*", { capabilities = capabilities })

      -- basedpyright: type checking + IntelliSense.
      vim.lsp.config("basedpyright", {
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "standard",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "openFilesOnly",
            },
          },
        },
      })

      -- ruff: linting, import sorting, formatting (hover handled by basedpyright).
      vim.lsp.config("ruff", {})

      -- lua_ls: aware of the Neovim runtime when editing this config.
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })

      vim.lsp.enable(servers)

      -- Diagnostics presentation.
      vim.diagnostic.config({
        virtual_text = true,
        severity_sort = true,
        underline = true,
        update_in_insert = false,
        float = { border = "rounded", source = true },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
          },
        },
      })

      -- Buffer-local LSP keymaps, set when a server attaches.
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          -- Let basedpyright own hover; ruff only lints/formats.
          if client and client.name == "ruff" then
            client.server_capabilities.hoverProvider = false
          end

          local function map(keys, fn, desc)
            vim.keymap.set("n", keys, fn, { buffer = ev.buf, silent = true, desc = "LSP: " .. desc })
          end
          map("gd", vim.lsp.buf.definition, "Go to definition")
          map("gD", vim.lsp.buf.declaration, "Go to declaration")
          map("gr", vim.lsp.buf.references, "References")
          map("gi", vim.lsp.buf.implementation, "Implementation")
          map("K", vim.lsp.buf.hover, "Hover")
          map("<leader>rn", vim.lsp.buf.rename, "Rename")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("<leader>ds", vim.diagnostic.open_float, "Line diagnostics")
          map("[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Prev diagnostic")
          map("]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next diagnostic")
        end,
      })
    end,
  },

  -- Completion --------------------------------------------------------------
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("cmp-config")
    end,
  },

  -- Formatting: conform with ruff, format-on-save ---------------------------
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
        mode = { "n", "v" },
        desc = "Format buffer",
      },
    },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
        },
        format_on_save = function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 1500, lsp_format = "fallback" }
        end,
      })

      -- :FormatToggle [!]  — toggle autoformat globally (or for the buffer with !)
      vim.api.nvim_create_user_command("FormatToggle", function(args)
        if args.bang then
          vim.b.disable_autoformat = not vim.b.disable_autoformat
        else
          vim.g.disable_autoformat = not vim.g.disable_autoformat
        end
        local off = args.bang and vim.b.disable_autoformat or vim.g.disable_autoformat
        vim.notify("Autoformat " .. (off and "disabled" or "enabled"))
      end, { bang = true, desc = "Toggle format-on-save" })
    end,
  },

  -- Debugging: nvim-dap + Python adapter + UI -------------------------------
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
      { "theHamsta/nvim-dap-virtual-text", opts = {} },
      "mfussenegger/nvim-dap-python",
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "DAP: breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "DAP: continue/start" },
      { "<leader>di", function() require("dap").step_into() end, desc = "DAP: step into" },
      { "<leader>do", function() require("dap").step_over() end, desc = "DAP: step over" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "DAP: step out" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "DAP: REPL" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "DAP: toggle UI" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "DAP: terminate" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()

      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

      -- Prefer the debugpy that mason installs; fall back to system python.
      local mason_py = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
      local python = (vim.fn.executable(mason_py) == 1) and mason_py or "python3"
      pcall(function() require("dap-python").setup(python) end)

      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticWarn", linehl = "Visual" })
    end,
  },

  -- Testing: neotest + Python (pytest) --------------------------------------
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
    },
    keys = {
      { "<leader>tt", function() require("neotest").run.run() end, desc = "Test: nearest" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Test: file" },
      { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Test: debug nearest" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Test: summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Test: output" },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
            runner = "pytest",
          }),
        },
      })
    end,
  },

  -- Virtualenv selection (needs the `fd` CLI; see README) --------------------
  {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap-python",
    },
    ft = "python",
    keys = {
      { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Python: select venv" },
    },
    opts = {},
  },
}
