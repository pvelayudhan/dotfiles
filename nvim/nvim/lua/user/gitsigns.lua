local M = {
    "lewis6991/gitsigns.nvim",
    commit = "43b0c856ae5f32a195d83f4a27fe21d63e6c966c",
    event = "BufEnter",
    cmd = "Gitsigns",
}

M.config = function()
    require("gitsigns").setup {
        watch_gitdir = {
            interval = 1000,
            follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        update_debounce = 200,
        max_file_length = 40000,
        preview_config = {
            border = "rounded",
            style = "minimal",
            relative = "cursor",
            row = 0,
            col = 1,
        },
    }
end

return M
