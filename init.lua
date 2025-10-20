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
vim.cmd("colorscheme tokyonight-moon")

-- File explorer (nvim-tree)
require("nvim-tree").setup({
  sort_by = "name",
  view = {
    width = 30,
    side = "left",
  },
  renderer = {
    group_empty = true,
    highlight_git = true,
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
  },
  filters = {
    dotfiles = false,
  },
})

-- Keymap to toggle tree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- Auto open tree if starting in a directory
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.isdirectory(vim.fn.expand("%")) == 1 then
      require("nvim-tree.api").tree.open()
    end
  end,
})
