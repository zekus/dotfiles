-- setup some aliases
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

-- install the packages
cmd 'packadd paq-nvim'               -- load the package manager

require 'paq-nvim' {
  'savq/paq-nvim';    -- paq-nvim manages itself
  'nvim-treesitter/nvim-treesitter';
  'neovim/nvim-lspconfig';
}
