-- Basic settings
vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.smartindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.wrap = false
vim.o.cursorline = true
vim.o.splitbelow = true
vim.o.splitright = true

-- Enable filetype, plugins and syntax
vim.cmd([[
  filetype plugin indent on
  syntax on
]])

-- TokyoNight colorscheme
require("tokyonight").setup({
  style = "moon",
  transparent = false,
  terminal_colors = true,
})
vim.cmd("colorscheme tokyonight")
