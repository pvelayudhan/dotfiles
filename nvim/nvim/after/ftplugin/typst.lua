local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<leader>hs", ":lua HashHeader({caps = false}, '//')<CR>", opts)
keymap("n", "<leader>hS", ":lua HashHeader({caps = true}, '//')<CR>", opts)
