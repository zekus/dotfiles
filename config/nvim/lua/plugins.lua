require('paq') {
  'savq/paq-nvim'; -- paq-nvim manages itself

  -- Tree-sitter
  'nvim-treesitter/nvim-treesitter';
  'nvim-treesitter/playground';

  -- LSP
  'williamboman/mason.nvim';
  'williamboman/mason-lspconfig.nvim';
  'neovim/nvim-lspconfig';
  'folke/trouble.nvim';
  'jose-elias-alvarez/null-ls.nvim';

  -- Autocomplete
  'hrsh7th/cmp-nvim-lsp';
  'hrsh7th/cmp-buffer';
  'hrsh7th/cmp-path';
  'hrsh7th/cmp-cmdline';
  'hrsh7th/nvim-cmp';

  -- Snippets
  'hrsh7th/cmp-vsnip';
  'hrsh7th/vim-vsnip';
  'rafamadriz/friendly-snippets';

  -- Utilities
  'windwp/nvim-autopairs';
  'ThePrimeagen/harpoon'; -- better marks
  'folke/which-key.nvim'; -- better marks

  -- Files tree
  'kyazdani42/nvim-tree.lua';

  -- Expose the neovim history tree
  'mbbill/undotree';

  -- Comments
  'terrortylor/nvim-comment';
  'JoosepAlviste/nvim-ts-context-commentstring'; -- (check the treesitter config)

  -- Telescope
  'nvim-lua/popup.nvim';
  'nvim-lua/plenary.nvim';
  'nvim-telescope/telescope.nvim';

  -- Colors
  'kyazdani42/nvim-web-devicons';
  'norcalli/nvim-base16.lua';
  'folke/tokyonight.nvim'; -- not base16
  'ful1e5/onedark.nvim'; -- not base16

  -- Status line and bufferline
  'hoob3rt/lualine.nvim';
  'romgrk/barbar.nvim';
  'SmiteshP/nvim-navic'; -- statusline/winbar component using lsp

  -- Code Testing
  'janko-m/vim-test';

  -- Terminal
  'kassio/neoterm';

  -- Better clipboard management
  'svermeulen/vim-easyclip';

  -- Resize windows easily
  'jimsei/winresizer';

  -- Git
  'samoshkin/vim-mergetool';
  'lewis6991/gitsigns.nvim';
  'TimUntersberger/neogit';

  -- Co-Pilot
  -- 'github/copilot.vim';
}
