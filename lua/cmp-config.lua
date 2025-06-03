-- Simple autocompletion setup for Neovim 0.9.5
local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
  return
end

local luasnip_status_ok, luasnip = pcall(require, "luasnip")
if luasnip_status_ok then
  -- Load friendly snippets
  require("luasnip.loaders.from_vscode").lazy_load()
end

cmp.setup({
  snippet = {
    expand = function(args)
      if luasnip_status_ok then
        luasnip.lsp_expand(args.body)
      end
    end,
  },
  
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip_status_ok and luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip_status_ok and luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),
  
  formatting = {
    format = function(entry, vim_item)
      -- Simple formatting
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      
      return vim_item
    end,
  },
})

