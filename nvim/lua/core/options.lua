--------------------
-- GLOBAL SETTINGS --
--------------------
vim.o.timeoutlen = 300

------------
-- EDITOR --
------------
vim.o.mouse = ''            -- Disable mouse
vim.o.cursorline = true     -- Show vertical highlight line where cursor is
vim.o.guicursor = ''        -- Always keep block cursor
vim.o.number = true         -- Show line numbers
vim.o.relativenumber = true -- Show relative line numbers
vim.o.signcolumn = 'yes'    -- Always show the sign column
vim.o.scrolloff = 1         -- Min number of lines to keep above and below cursor
vim.o.winborder = 'rounded' -- Rounded outline around popups
vim.o.splitright = true     -- When splitting vertically, put new window on the right
vim.o.expandtab = true      -- Uses spaces for tabs
vim.o.tabstop = 2           -- Number of spaces that a <Tab> is displayed as
vim.o.softtabstop = 2       -- Number of spaces that a <Tab> writes or deletes
vim.o.shiftwidth = 0        -- Number of spaces used when indenting (0: use value for 'tabstop')
vim.o.autoindent = true     -- Copy indent from current line when starting a new line
vim.o.smartindent = true    -- Do smart autoindenting when starting a new line
vim.o.smarttab = true       -- Insert <Tab> according to specified widths
vim.opt.completeopt:append('noselect')

-- FILE HANDLING --
vim.o.backup = false        -- Don't create backup files
vim.o.writebackup = false   -- Don't create backup files before writing
vim.o.swapfile = false      -- Don't create swapfiles
vim.o.undofile = true       -- Persistent undo

-- WHITE SPACE --
vim.o.showbreak = '↪ '      -- Character to show on line breaks

vim.o.list = true           -- Enable white space characters
vim.opt.listchars = {       -- Custom white space characters
  tab = '▏ ',
  leadmultispace = '▏ ',
  eol = '¬',
  extends = '…',
  precedes = '…',
  nbsp = '·',
  trail = '~',
}

--------------------
-- SEARCH PATTERN --
--------------------
vim.opt.path:append('**')
vim.o.wildignorecase = true -- Ignore text case when using tab to complete
vim.o.ignorecase = true     -- Ignore case in search pattern (needed for smartcase)
vim.o.smartcase = true      -- Consider case only once an uppercase character is used (overrides ignorecase)

vim.opt.wildignore:append('*/node_modules/*')
