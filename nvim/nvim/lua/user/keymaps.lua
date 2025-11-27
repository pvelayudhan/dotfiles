local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "<C-i>", "<C-i>", opts)


-- window ---------------------------------------------------------------------
-- Ctrl + a vim directional key to move to a different window
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Ctrl + a vim directional key to move to a different window
keymap("t", "<C-h>", "<C-\\><C-n><C-w>h", opts)
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j", opts)
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k", opts)
keymap("t", "<C-l>", "<C-\\><C-n><C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- terminal -------------------------------------------------------------------
-- Press Ctrl + \ to open a new terminal buffer
keymap("n", "<C-\\>", ":tabnew | term<CR>", opts)

-- Press Ctrl + \ to open a new terminal buffer
keymap('t', '<C-\\>', '<C-\\><C-n>', { noremap = true, silent = true })

-- delete ---------------------------------------------------------------------
-- Stay in indent mode
keymap("v", "D", "\"_d", opts)

-- search ---------------------------------------------------------------------
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "g#", "g#zz", opts)
keymap("n", "<leader>ht", ":set hlsearch! hlsearch?<CR>", opts)

-- misc -----------------------------------------------------------------------
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Paste without yanking
keymap("x", "p", [["_dP]])

vim.cmd [[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<CR>]]
vim.cmd [[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<CR>]]

keymap("n", "<RightMouse>", "<cmd>:popup mousemenu<CR>")

--Startup time
keymap("n", "<leader>su", ":lua print(require('lazy').stats().startuptime)<CR>", opts)

-- Getting the current directory
keymap("n", "<leader>td", ":lua print(vim.fn.getcwd())<CR>", opts)

-- Move to current buffer's directory
keymap("n", "<leader>rr", ":cd %:h<CR>", opts)

--- Buffer management
keymap("n", "<S-l>", ":bnext<CR>zz", opts)
keymap("n", "<S-h>", ":bprevious<CR>zz", opts)
keymap("n", "<leader>D", ":bp | sp | bn | bd<CR>", opts)
keymap("n", "<leader>b", ":BW<CR>", opts)
keymap("n", "<leader>q", ":bp | sp | bn | bd<CR>", opts)

-- Neat formatting of parentheses and commas
keymap("n", "<leader>so", "vip:s/)/\\r&/g<CR>vip:s/[(,]\\n\\@!/&\\r/g<CR>vip<ESC>vgq", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Preserving join function lost by visual move J command
keymap("v", "<leader>j", "<S-j>", opts)

keymap("n", "<F1>", ":make<CR>")

-- window picking
keymap("n", "-", ":lua PickWin()<CR>", opts)
keymap("n", "=", ":lua SwapWin()<CR>", opts)

-- tab picking
keymap("n", "<Tab>", ":tabn<CR>", opts)

-- cursorline highlight
keymap("n", "<leader>hl", ":set cursorline<CR>", opts)
keymap("n", "<leader>hn", ":set nocursorline<CR>", opts)

-- conceal level
keymap("n", "<leader>nc", ":set conceallevel=0<CR>", opts)
keymap("n", "<leader>cn", ":set conceallevel=2<CR>", opts)

-- syntax highlighting
keymap("n", "<leader>ss", ":syntax sync fromstart<CR>")
keymap("n", "<leader>ns", ":set syntax=OFF<CR>")
keymap("n", "<leader>sn", ":set syntax=ON<CR>")

-- spelling
keymap("n", "<leader>ys", ":set spell<CR>", opts)
keymap("n", "<leader>sy", ":set nospell<CR>", opts)

-- color column
keymap("n", "<leader>cc", ":execute 'set colorcolumn=' . (&colorcolumn == '' ? '77' : '')<CR>", opts)

-- colorscheme
keymap("n", "<leader>cl", ":set background=light<CR>", opts)
keymap("n", "<leader>cd", ":set background=dark<CR>", opts)

-- indentation
keymap("n", "<leader>i", "vip=", opts)

-- plugins --------------------------------------------------------------------
-- oil
keymap("n", "<leader>mk", ":lua require('oil').toggle_float()<CR>", opts)

-- telescope
keymap("n", "<leader>ci", ":Telescope bibtex<CR>", opts)
keymap("i", "<C-i>", "<cmd>Telescope bibtex<CR>", opts)
keymap("n", "<leader>fb", ":Telescope file_browser hidden=true use_df=true follow_symlinks=true<CR>", opts)
keymap("n", "<leader>fc", ":Telescope colorscheme<CR>", opts)
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope grep_string search=<CR>", opts)
keymap("n", "<leader>fj", ":Telescope oldfiles<CR>", opts)
keymap("n", "<leader>fm", ":Telescope marks<CR>", opts)
keymap("n", "<leader>fo", ":Telescope git_commits<CR>", opts)
keymap("n", "<leader>fr", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fu", ":Telescope buffers<CR>", opts)

-- gitsigns
keymap("n", "^", ":Gitsigns prev_hunk<CR>", opts)
keymap("n", "&", ":Gitsigns next_hunk<CR>", opts)
keymap("n", "gp", ":Gitsigns preview_hunk<CR>", opts)
keymap("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", opts)
keymap("n", "<leader>gs", ":Gitsigns toggle_signs<CR>", opts)

-- diffview
keymap( "n", "<leader>gd", ":DiffviewFileHistory %<CR>", opts)
keymap( "n", "<leader>gb", ":DiffviewFileHistory<CR>", opts)

-- slime
keymap( "n", "<leader>rf", ":lua kitty('')<CR>", opts)
keymap("n", ";", ":lua SelectParagraph()<CR>:SlimeSend<CR>}j", opts)
keymap("v", ";", ":SlimeSend<CR>", opts)
keymap("n", "<A-;>", "<Plug>SlimeParagraphSend", opts)

-- goyo
keymap("n", "<leader>zm", ":Goyo<CR>", opts)

-- copilot
keymap("n", "<leader>kk", ":Copilot toggle<CR>", opts)

-- custom functions -----------------------------------------------------------
-- session management
keymap("n", "<leader>ms", ":lua SaveSession()<CR>", opts)
keymap("n", "<leader>os", ":source Session.vim<CR>", opts)

-- insert current date and time
keymap("n", "<leader>id", ":lua CurrentDate()<CR>", opts)
keymap("n", "<leader>it", ":lua CurrentTime()<CR>", opts)

-- when browsing filename.* (like filename.md), open filename.pdf
keymap("n", "<leader>op", ":lua OpenMatchingPdf()<CR>", opts)

-- turn a line into a header by reaching the column limit with dashes
keymap("n", "<leader>hs", ":lua HashHeader({caps = false})<CR>", opts)
keymap("n", "<leader>hS", ":lua HashHeader({caps = true})<CR>", opts)

-- hacky way to recursively break up nested code into multiple lines
keymap("n", "<leader>sl", ":lua SplitLine()<CR>", opts)

-- strips trailing whitespace from all lines in a file
keymap("n", "<leader>sw", ":lua StripWhitespace()<CR>", opts)

-- shortcuts to a regularly edited file
keymap("n", "<leader>ww", ":e ~/Documents/prash/journal/prash.md<CR>", opts)
keymap("n", "<leader>wm", ":e ~/Documents/prash/journal/music.csv<CR>", opts)
keymap("n", "<leader>wj", ":e ~/Documents/prash/journal-2/1.typ<CR>", opts)
