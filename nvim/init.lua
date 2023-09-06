local opt = vim.opt

opt.mouse = 'a'

opt.swapfile = false
opt.backup = false
opt.hidden = true
opt.clipboard = "unnamedplus"

opt.relativenumber = true
opt.list = true
opt.smartindent = true
opt.listchars = {tab = '>-', trail = '*', nbsp = '+'}
opt.visualbell = true

opt.showmatch = true

opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4

opt.ignorecase = true
opt.smartcase = true
opt.wrapscan = true

opt.helplang = 'ja'

opt.updatetime = 300

opt.showtabline = 2

vim.cmd("colorscheme nightfox")
vim.cmd("source ~/nixfiles/nvim/bufferline.lua")
vim.cmd("source ~/nixfiles/nvim/lualine.lua")
vim.cmd("source ~/nixfiles/nvim/telescope.lua")
vim.cmd("source ~/nixfiles/nvim/lspconfig.lua")
vim.cmd("source ~/nixfiles/nvim/lspsaga.lua")
vim.cmd("source ~/nixfiles/nvim/cmp.lua")
vim.cmd("source ~/nixfiles/nvim/lean.lua")

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}

require'Comment'.setup()

require'toggleterm'.setup{
  open_mapping = [[<c-t>]]
}

require'neo-tree'.setup{}
vim.cmd([[nnoremap <leader>f :Neotree reveal<cr>]])

local scrollbar = require'scrollbar'
vim.api.nvim_create_autocmd({"WinScrolled", "VimResized", "QuitPre"}, {
  callback = function() scrollbar.show() end
})
vim.api.nvim_create_autocmd({"WinEnter", "FocusGained"}, {
  callback = function() scrollbar.show() end
})
vim.api.nvim_create_autocmd({"WinLeave", "BufLeave",
    "BufWinLeave", "FocusLost"}, {
  callback = function() scrollbar.clear() end
})
