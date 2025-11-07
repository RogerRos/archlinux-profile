-- Leader key
vim.g.mapleader = " "

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

-- No swap (clean setup)
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false

-- Enable filetype, plugins and syntax
vim.cmd([[
  filetype plugin indent on
  syntax on
]])

-- TokyoNight colorscheme - transparencia
require("tokyonight").setup({
  style = "moon",
  transparent = true,
  terminal_colors = true,
  styles = {
    sidebars = "transparent",
    floats = "transparent",
  },
})
vim.cmd("colorscheme tokyonight-moon")

-- elimina fondo en grupos comunes (incluye NvimTree)
vim.api.nvim_set_hl(0, "Normal",        { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC",      { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat",   { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn",    { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer",   { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeNormal",{ bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeNormalNC",{ bg = "none" })

-- Icons
require("nvim-web-devicons").setup({ default = true })

-- File explorer (nvim-tree)
require("nvim-tree").setup({
  sort_by = "name",
  view = {
    width = 30,
    side = "left",
  },
  on_attach = function(bufnr)
    local api = require("nvim-tree.api")
    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    api.config.mappings.default_on_attach(bufnr)
    vim.keymap.set("n", "<Right>", api.node.open.edit, opts("Open"))
    vim.keymap.set("n", "<Left>", api.node.navigate.parent_close, opts("Close"))
  end,
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

-- Treesitter (modern syntax highlighting)
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "java", "lua", "vim", "vimdoc", "query",
    "python", "c", "cpp", "html", "css",
    "javascript", "typescript", "json", "yaml"
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
})
