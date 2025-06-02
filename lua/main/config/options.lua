-----------
-- THEME --
-----------
vim.opt.background = "dark"
-- Syntax highlighting
vim.opt.syntax = "enable"
-- Highlight the cursor column
vim.opt.cursorcolumn = false
-- Highlight the cursor line
vim.opt.cursorline = true
-- Text encoding
vim.opt.encoding = "utf-8"
-- Enable 24-bit color
vim.opt.termguicolors = true
-- How bold is floating windows. 0 is fully opaque
vim.opt.winblend = 0
-- Border of floating windows
vim.opt.winborder = ""
-- Get GUI style of the cursor, the following is copied from VIM help
vim.opt.guicursor =
    "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
-- GUI font
vim.opt.guifont = "monospace:h17"

-- Not sure what to do with this yet
vim.opt.fillchars:append({})

------------
-- COLUMN --
------------
-- Turn on number column
vim.opt.number = true
-- Set relative number column
vim.opt.relativenumber = true
-- Width of number column
vim.opt.numberwidth = 4
-- Turn on sign columns
vim.opt.signcolumn = "yes"
-- How to format the status column
vim.opt.statuscolumn = ""

----------
-- LINE --
----------
-- Height of command-line
vim.opt.cmdheight = 2
-- Height of command-line windows
vim.opt.cmdwinheight = 7
-- Turn on ruler
vim.opt.ruler = true
-- Set ruler format
vim.opt.rulerformat = ""
-- Show the current mode (e.g. INSERT, NORMAL,...)
vim.opt.showmode = true
-- Format status line
vim.opt.statusline = ""
-- Always show tabline
vim.opt.showtabline = 2
-- Space between lines
vim.opt.linespace = 0
-- Format tab line
vim.opt.tabline = ""
-- Maximum number of tab pages
vim.opt.tabpagemax = 50

-----------
-- TITLE --
-----------
-- Enable title
vim.opt.title = true
-- Length of title
vim.opt.titlelen = 85
-- Format title string
vim.opt.titlestring = ""

------------
-- INDENT --
------------
-- Expand tab to spaces
vim.opt.expandtab = true
-- How many spaces is a tab
vim.opt.tabstop = 4
-- How many spaces to shift ('>' and '<' commands)
vim.opt.shiftwidth = 4
-- How many spaces that a <Tab> counts for performing editing
vim.opt.softtabstop = 4
-- Auto indenting when starting a new line
vim.opt.smartindent = true
-- When <Tab> at begin of the lines, auto-size the tab size. When <BS>, delete spaces equal to the 'tabstop'
vim.opt.smarttab = true

----------------
-- COMPLETION --
----------------
-- Use a popup menu to show the possible completions (even when only one is available)
vim.opt.completeopt = { "menu", "menuone", "popup" }
-- Maximum number of items in popup menu
vim.opt.pumheight = 10

----------
-- FOLD --
----------
-- Set to "all" to close a fold whenever the cursor is not in it
vim.opt.foldclose = ""
-- How to draw foldcolumn ("0": disable foldcolumn)
vim.opt.foldcolumn = "0"
-- Enable fold
vim.opt.foldenable = true
-- Lines starting with with char in list are ignored when 'foldmethod' is indent
vim.opt.foldignore = "#"
-- Fold with higher level will be closed
vim.opt.foldlevel = 0
-- Set 'foldlevel' when starting to edit another buffer in a window. Disable by setting to negative number
vim.opt.foldlevelstart = 99
-- Set fold method
vim.opt.foldmethod = "indent"

------------
-- SEARCH --
------------
-- Highlight matches
vim.opt.hlsearch = true
-- When substituting, show results in the current window instead
vim.opt.inccommand = "nosplit"
-- Show the matches when typing a search command
vim.opt.incsearch = true
-- Ignore case when search
vim.opt.ignorecase = true
-- Override 'ignorecase' option when the search pattern contains upper case characters.
vim.opt.smartcase = true

---------------
-- LIST MODE --
---------------
-- Turn on list mode
vim.opt.list = true
-- Set 'listchars' for list mode
vim.opt.listchars = {
    -- eol = "$",
    -- Tab
    tab = "-->",
    -- Leading space show "|" every tab
    leadmultispace = "|...",
    -- Trailing space
    trail = " ",
    -- When line goes beyond the right border of windows
    extends = "",
    -- When line goes beyond the left border of windows
    precedes = "",
}

---------
-- TAG --
---------
-- Follow the 'smartcase' and 'ignorecase' options when searching the tags file
vim.opt.tagcase = "followscs"

------------
-- SCROLL --
------------
-- Number of lines to scroll. Set to 0 to use default value (half window size)
vim.opt.scroll = 0
-- Number of columns to scroll. Only valid when 'wrap' is off
vim.opt.sidescroll = 1
-- Minimal number screen lines to keep above and below the cursor
vim.opt.scrolloff = 8
-- Minimal number screen columns to keep left and right of the cursor
vim.opt.sidescrolloff = 8

----------
-- WRAP --
----------
-- Put break symbol at the start of lines that have been wrapped
vim.opt.showbreak = "> "
-- Enable wrap
vim.opt.wrap = false
-- Number of characters from the right window border when wrapping start
vim.opt.wrapmargin = 0

-------------
-- BRACKET --
-------------
-- Briefly show the matching bracket when a bracket is inserted
vim.opt.showmatch = true
-- Time to show the matching bracket (in tenths of a second)
vim.opt.matchtime = 2

-----------
-- SPLIT --
-----------
-- When split horizontally, add new window bellow
vim.opt.splitbelow = true
-- When split vertically, add new window to the right
vim.opt.splitright = true
-- Keep the text on the same screen line when resizing horizontal splits
vim.opt.splitkeep = "screen"

----------------
-- SWAP FILES --
----------------
-- Use a swapfile for buffer
vim.opt.swapfile = true
-- After typing this many characters the swap file will be written
vim.opt.updatecount = 200
-- How many ms nothing is typed the swap file will be written. Also used for 'CursorHold' event
vim.opt.updatetime = 1000

------------
-- BACKUP --
------------
vim.opt.backup = false

----------
-- UNDO --
----------
-- Where to save undo files
vim.opt.undodir = vim.fs.joinpath(vim.fn.stdpath("state"), "nvim/undo")
-- Enable undofile
vim.opt.undofile = true
-- Maximum number that can be undone
vim.opt.undolevels = 1000
-- Save the whole buffer for undo when reloading it (not sure what this means)
vim.opt.undoreload = 10000

----------
-- MISC --
----------
-- Use the clipboard as '+' register for yank
vim.opt.clipboard:append("unnamedplus")
-- When on, a buffer becomes hidden when it is abandoned
vim.opt.hidden = true
-- Length of stored history entries of ":" commands
vim.opt.history = 10000
-- Count "-" as words
vim.opt.iskeyword:append("-")
-- When jump backward, preserve the relative position of cursor on screen
vim.opt.jumpoptions = "stack,view"
-- Turn on mouse on all modes
vim.opt.mouse = "a"
