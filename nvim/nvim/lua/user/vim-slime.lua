local M = {
    "jpalardy/vim-slime",
    commit = "507107dd24c9b85721fa589462fd5068e0f70266",
    event = "VimEnter"
}

function M.config()
    vim.cmd([[
        let g:slime_target = "kitty"
        let g:slime_default_config = { "window_id": "1", "listen_on": "unix:/tmp/mykitty" }
        let g:slime_python_ipython = 1
        let g:slime_dont_ask_default = 1
        let g:slime_cell_delimiter = "```"
    ]])
end

return M
