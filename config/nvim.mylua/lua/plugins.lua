vim.cmd('packadd paq-nvim') -- load the package manager

require('paq-nvim') {
  {'savq/paq-nvim', opt = true}; -- paq-nvim manages itself

  -- tree-sitter
  'nvim-treesitter/nvim-treesitter';
  'nvim-treesitter/playground';

  -- LSP
  'neovim/nvim-lspconfig';
  'kabouzeid/nvim-lspinstall';
  'glepnir/lspsaga.nvim';
  'folke/trouble.nvim';
  'jose-elias-alvarez/null-ls.nvim';

  -- Autocomplete and Snippets
  'hrsh7th/nvim-compe';
  'honza/vim-snippets';

  -- utilities
  'windwp/nvim-autopairs';

  -- Files tree
  'kyazdani42/nvim-tree.lua';

  -- Comments
  'terrortylor/nvim-comment';
  'JoosepAlviste/nvim-ts-context-commentstring'; -- (check the treesitter config)

  -- telescope
  'nvim-lua/popup.nvim';
  'nvim-lua/plenary.nvim';
  'nvim-telescope/telescope.nvim';

  -- colors, colors, colors and icons
  'kyazdani42/nvim-web-devicons';
  'norcalli/nvim-base16.lua';

  -- status line and bufferline
  'hoob3rt/lualine.nvim';
  'romgrk/barbar.nvim';

  -- Code Testing
  'janko-m/vim-test';

  -- Terminal
  'kassio/neoterm';

  -- Better clipboard management
  'svermeulen/vim-easyclip';

  -- resize windows easily
  'jimsei/winresizer';

  -- git
  'samoshkin/vim-mergetool';
  'lewis6991/gitsigns.nvim';
}
