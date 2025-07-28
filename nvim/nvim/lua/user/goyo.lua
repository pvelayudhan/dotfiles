local M = {
    'junegunn/goyo.vim',
}

function M.config()
    vim.cmd([[
        let g:goyo_width = "70%"
    ]])
end

return M

