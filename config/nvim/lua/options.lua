local options = {
  expandtab = true, -- Use spaces instead of tabs
  ignorecase = true, -- Ignore case
  joinspaces = false, -- No double spaces with join
  list = true, -- Show some invisible characters
  number = true, -- Show line numbers
  relativenumber = true, -- Relative line numbers
  scrolloff = 4, -- Lines of context
  shiftround = true, -- Round indent
  shiftwidth = 2, -- Size of an indent
  sidescrolloff = 8, -- Columns of context
  smartcase = true, -- Do not ignore case with capitals
  smartindent = true, -- Insert indents automatically
  splitbelow = true, -- Put new windows below current
  splitright = true, -- Put new windows right of current
  tabstop = 2, -- Number of spaces tabs count for
  termguicolors = true, -- True color support
  wrap = false, -- Disable line wrap
  completeopt = "menuone,noselect", -- Completion menu
  fileencoding = "utf-8", -- The encoding written to file
  cursorline = true, -- Enable highlighting of the current line
  showtabline = 2, -- Always show tabs
  showmode = false, -- We don't need to see things like -- INSERT -- anymore
  backup = false, -- This is recommended by coc
  writebackup = false, -- This is recommended by coc
  signcolumn = "yes", -- Always show the signcolumn, otherwise it would shift the text each time
  hidden = true, -- Required to keep multiple buffers open multiple buffers
  title = true,
  titlestring = "%<%F%=%l/%L - nvim",
  cmdheight = 2, -- More space for displaying messages
  conceallevel = 0, -- So that I can see `` in markdown files
  updatetime = 300, -- Faster completion
  colorcolumn = '99999', -- fix indentline
  inccommand = 'split', -- make substitution work in realtime
  titleold =  "'..TERMINAL..'"
}

for name, value in pairs(options) do
  vim.opt[name] = value
end

TERMINAL = vim.fn.expand('$TERMINAL')

vim.opt.shortmess:append 'c' -- Don't pass messages to |ins-completion-menu|.
vim.opt.iskeyword:append '-' -- treat dash separated words as a word text object"
-- vim.opt.whichwrap:append { "<", ">", "[", "]", "h", "l" } -- move to next line with these keys

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function ()
    vim.highlight.on_yank({on_visual = false})
  end
}) -- disabled in visual mode
