local M = {
    'stevearc/oil.nvim',
    commit = "685cdb4ffa74473d75a1b97451f8654ceeab0f4a",
    dependencies = {
        {
            "nvim-tree/nvim-web-devicons", 
            commit = "f1420728f59843eb2ef084406b3d0201a0a0932d",
        }
    },
}

function M.config()
    require('oil').setup({
        lsp_file_methods = {
            enabled = false
        },
        keymaps = {
            ["-"]     = { "actions.parent", mode = "n" },
            ["<C-c>"] = { "actions.close", mode = "n" },
            ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
            ["<C-l>"] = { "actions.refresh", },
            ["<C-p>"] = { "actions.preview", },
            ["<C-s>"] = { "actions.select", opts = { vertical = true } },
            ["<C-t>"] = { "actions.select", opts = { tab = true } },
            ["<CR>"]  = { "actions.select", },
            ["_"]     = { "actions.open_cwd", mode = "n" },
            ["`"]     = { "actions.cd", mode = "n" },
            ["g."]    = { "actions.toggle_hidden", mode = "n" },
            ["g?"]    = { "actions.show_help", mode = "n" },
            ["g\\"]   = { "actions.toggle_trash", mode = "n" },
            ["gs"]    = { "actions.change_sort", mode = "n" },
            ["gx"]    = { "actions.open_external" },
            ["q"]     = { "actions.close" },
            ["~"]     = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        },
        win_options = {
            wrap = false,
            signcolumn = "no",
            cursorcolumn = false,
            foldcolumn = "0",
            spell = false,
            list = false,
            conceallevel = 3,
            concealcursor = "nvic",
        },
        -- Configuration for the floating window in oil.open_float
        float = {
            -- Padding around the floating window
            padding = 2,
            -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
            max_width = 0,
            max_height = 0,
            border = "rounded",
            win_options = {
                winblend = 0,
                winhl = "Normal:Normal,FloatBorder:Normal,FloatTitle:Title",
            },
            -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
            get_win_title = nil,
            -- preview_split: Split direction: "auto", "left", "right", "above", "below".
            preview_split = "auto",
            -- This is the config that will be passed to nvim_open_win.
            -- Change values here to customize the layout
            override = function(conf)
                return conf
            end,
        },
        show_hidden = true,
    })
end

return M
