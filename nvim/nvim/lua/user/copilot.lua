local M = {
    'Exafunction/windsurf.vim',
    event = 'BufEnter'
}

return M

--local M = {
--    "zbirenbaum/copilot.lua",
--    commit = "7ba73866b9b3c696f80579c470c6eec374d3acec",
--    cmd = "Copilot",
--    config = function()
--        require('copilot').setup({
--            panel = {
--                enabled = false,
--                auto_refresh = false,
--                keymap = {
--                    jump_prev = "[[",
--                    jump_next = "]]",
--                    accept = "<CR>",
--                    refresh = "gr",
--                    open = "<M-CR>"
--                },
--                layout = {
--                    position = "bottom", -- | top | left | right
--                    ratio = 0.4
--                },
--            },
--            suggestion = {
--                enabled = true,
--                auto_trigger = true,
--                debounce = 75,
--                keymap = {
--                    accept = "<M-l>",
--                    accept_word = false,
--                    accept_line = false,
--                    next = "<M-]>",
--                    prev = "<M-[>",
--                    dismiss = "<C-]>",
--                },
--            },
--            filetypes = {
--                yaml = false,
--                markdown = true,
--                help = false,
--                gitcommit = false,
--                gitrebase = false,
--                hgcommit = false,
--                svn = false,
--                cvs = false,
--                ["."] = false,
--            },
--            copilot_node_command = 'node', -- Node.js version must be > 18.x
--            server_opts_overrides = {},
--        })
--    end,
--}
--
--return M
