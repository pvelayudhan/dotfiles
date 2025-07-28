-- Disable automatic comment formatting
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    callback = function()
        vim.cmd "set formatoptions-=cro"
    end,
})

-- Exit certain filetypes with 'q'
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = {
        "qf",
        "git",
        "help",
        "man",
        "lspinfo",
        "",
    },
    callback = function()
        vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
      ]]
    end,
})

-- Automatically resize splits when the neovim is resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
    callback = function()
        vim.cmd "tabdo wincmd ="
    end,
})

-- Check if the buffer has been modified
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    pattern = { "*" },
    callback = function()
        vim.cmd "checktime"
    end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    callback = function()
        vim.highlight.on_yank { higroup = "Visual", timeout = 40 }
    end,
})

-- After exiting a snippet, cancel the session so that tabbing around later
--  doesn't jump backwards
-- https://github.com/L3MON4D3/LuaSnip/issues/258#issuecomment-1429989436
vim.api.nvim_create_autocmd('ModeChanged', {
    pattern = '*',
    callback = function()
        if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
            and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
            and not require('luasnip').session.jump_active
        then
            require('luasnip').unlink_current()
        end
    end
})

-- Open binary files
-- From https://powersnail.com/2024/open-binary-files-external/
vim.api.nvim_create_autocmd("BufReadCmd", {
    pattern = "*.pdf",
    callback = function()
        local filename = vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
        vim.cmd("silent !sioyek --new-window " .. filename)
        vim.cmd("let tobedeleted = bufnr('%') | b# | exe \"bd! \" . tobedeleted")
    end
})

-- Open image files
vim.api.nvim_create_autocmd("BufReadCmd", {
    pattern = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },
    callback = function()
        local filename = vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
        vim.cmd("silent !feh " .. filename .. " &")
        vim.cmd("let tobedeleted = bufnr('%') | b# | exe \"bd! \" . tobedeleted")
    end
})

-- Close buffers without necessarily closing the window
vim.api.nvim_create_user_command(
    "BW",
    function(args)
        -- Remove the current buffer from the argument list
        vim.cmd("silent! argdelete " .. vim.fn.expand("%"))
        -- Switch to the previous buffer, ensuring the window stays open
        vim.cmd("bp | sp | bn")
        -- Wipe out the current buffer
        vim.cmd("bwipeout" .. (args.bang and "!" or "") .. " " .. args.args)
    end,
    { nargs = "*", bang = true }
)

-- Send entire code cell to REPL
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.qmd", "*.rmd" },
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "'", "<Plug>SlimeSendCell", { noremap = true, silent = true })
  end,
})

-- Remap <CR> in Oil to our custom behavior
vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function()
    vim.keymap.set("n", "<CR>", OilOpen, { buffer = true, desc = "Custom enter behavior for Oil" })
  end,
})
