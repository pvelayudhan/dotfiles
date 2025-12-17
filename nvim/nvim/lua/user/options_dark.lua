vim.opt.background     = "dark"
vim.opt.backup         = false                      -- creates a backup file
vim.opt.clipboard      = "unnamedplus"              -- allows neovim to access the system clipboard
vim.opt.cmdheight      = 0                          -- more space in the neovim command line for displaying messages
vim.opt.completeopt    = { "menuone", "noselect" }  -- mostly just for cmp
vim.opt.conceallevel   = 0                          -- so that `` is visible in markdown files
vim.opt.cursorline     = true                       -- highlighting of the current line
vim.opt.expandtab      = true                       -- convert tabs to spaces
vim.opt.fileencoding   = "utf-8"                    -- the encoding written to a file
vim.opt.foldenable     = true                       -- allow folding
vim.opt.foldmethod     = "marker"                   -- use comment characters to define fold boundaries
vim.opt.guifont        = "monospace:h17"            -- the font used in graphical neovim applications
vim.opt.hlsearch       = false                      -- highlight all matches on previous search pattern
vim.opt.ignorecase     = true                       -- ignore case in search patterns
vim.opt.laststatus     = 2                          -- only the last window will always have a status line
vim.opt.linebreak      = true
vim.opt.mouse          = "a"                        -- allow the mouse to be used in neovim
vim.opt.number         = true                       -- set numbered lines
vim.opt.numberwidth    = 4                          -- set number column width to 2 {default 4}
vim.opt.pumblend       = 10
vim.opt.pumheight      = 10                         -- pop up menu height
vim.opt.relativenumber = true                       -- set relative numbered lines
vim.opt.ruler          = false
vim.opt.scrolloff      = 8                          -- minimal number of screen lines to keep above and below the cursor
vim.opt.shiftwidth     = 4                          -- the number of spaces inserted for each indentation
vim.opt.showbreak      = '|'                        -- symbol prefixing wrapped lines
vim.opt.showcmd        = false                      -- hide (partial) command in the last line of the screen (for performance)
vim.opt.showmode       = false                      -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline    = 1                          -- always show tabs
vim.opt.sidescrolloff  = 8                          -- minimal number of screen columns to keep to the left and right of the cursor if wrap is `false`
vim.opt.signcolumn     = "yes"                      -- always show the sign column, otherwise it would shift the text each time
vim.opt.smartcase      = true                       -- smart case
vim.opt.spell          = false                      -- disable default spell checking
vim.opt.splitbelow     = true                       -- force all horizontal splits to go below current window
vim.opt.splitright     = true                       -- force all vertical splits to go to the right of current window
vim.opt.swapfile       = false                      -- creates a swapfile
vim.opt.termguicolors  = true                       -- set term gui colors (most terminals support this)
vim.opt.timeoutlen     = 1000                       -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile       = true                       -- enable persistent undo
vim.opt.updatetime     = 100                        -- faster completion (4000ms default)
vim.opt.writebackup    = false                      -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

vim.opt.iskeyword:remove('.')                       -- don't treat periods as word joiners
vim.opt.jumpoptions:append "view"
vim.opt.shortmess:append "c"                        -- hide all completion messages
vim.opt.whichwrap:append "<,>,[,],h,l"              -- keys allowed to move to the previous/next line when the beginning/end of line is reached

-- Indentation
vim.api.nvim_command('set cinkeys-=0#')
vim.api.nvim_command('set cino=(s,m1,p0,+0')
vim.opt.autoindent  = true
vim.opt.cindent     = true
vim.opt.smartindent = false                         -- make indenting smarter again
vim.opt.smarttab    = true
vim.opt.softtabstop = 4                             -- four space tabs
vim.opt.tabstop     = 4                             -- four space tabs


-- Transparency
--vim.api.nvim_set_hl(0, 'Normal',      { bg = 'none' })
--vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
--vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
--vim.api.nvim_set_hl(0, 'Pmenu',       { bg = 'none' })
--vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none' }) 

vim.g.loaded_perl_provider    = 0
vim.g.loaded_node_provider    = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider    = 0
vim.g.loaded_gem_provider     = 0

-- Other
vim.g._ts_force_sync_parsing = true                    -- Workaround for: https://github.com/neovim/neovim/issues/32660

vim.diagnostic.config({ virtual_text = true })
