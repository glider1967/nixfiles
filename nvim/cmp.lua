-- Setup nvim-cmp.
local cmp = require 'cmp'
local lspkind = require 'lspkind'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args) vim.fn["vsnip#anonymous"](args.body) end
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({select = true})
  }),
  sources = cmp.config.sources({
    {name = 'nvim_lsp'}, {name = 'nvim_lsp_signature_help'},
    {name = 'nvim_lua'}, {name = 'vsnip'}
  }, {{name = 'buffer'}}),
  formatting = {
    format = lspkind.cmp_format({mode = 'symbol', maxwidth = 50})
  },
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config
      .sources({{name = 'cmp_git'}}, {{name = 'buffer'}})
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({{name = 'buffer'}},
                               {{name = 'nvim_lsp_document_symbol'}})
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config
      .sources({{name = 'path'}}, {{name = 'cmdline'}})
})

