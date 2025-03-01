-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Keep signcolumn on by default
-- vim.opt.signcolumn = 'number'

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in status line
-- vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- don't timeout in keymap sequence
vim.opt.timeout = false

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

-- No more annoying swap file
vim.opt.swapfile = false

-- show more info
vim.opt.list = true
vim.opt.listchars = {
  -- eol = '󰌑',
  tab = ' ',
  trail = '·',
  nbsp = '␣',
}

-- bordered diag msg
vim.diagnostic.config {
  float = {
    border = 'rounded',
  },
}

-- sensible tab because i hate 8 space tab
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
