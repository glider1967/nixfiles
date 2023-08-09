local opt = vim.opt

opt.mouse = 'a'

opt.swapfile = false
opt.backup = false
opt.hidden = true
opt.clipboard = "unnamedplus"

opt.number = true
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

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}
