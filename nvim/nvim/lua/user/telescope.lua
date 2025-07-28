local M = {
    "nvim-telescope/telescope.nvim",
    commit = "a4ed82509cecc56df1c7138920a1aeaf246c0ac5",
    cmd = { "Telescope" },
    lazy = true,
    dependencies = {
        {
            "nvim-lua/plenary.nvim",
        },
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            lazy = true,
        },
        {
            "nvim-telescope/telescope-bibtex.nvim",
        },
        {
            "nvim-telescope/telescope-file-browser.nvim",
        },
        {
            "nvim-telescope/telescope-ui-select.nvim",
        },
    },
}

M.opts = {
    defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        file_ignore_patterns = { ".git/", "node_modules" },
    },
}

function M.config()
    local telescope = require "telescope"
    telescope.setup {
        extensions = {
            ["ui-select"] = {
                require("telescope.themes").get_dropdown {}
            },
            fzf = {
                fuzzy = true,                    -- false will only do exact matching
                override_generic_sorter = true,  -- override the generic sorter
                override_file_sorter = true,     -- override the file sorter
                case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
            },
            file_browser = {
                mappings = {
                    i = {
                        -- Insert path while respecting symbolic links and relative paths
                        ["<C-i>"] = function(prompt_bufnr)
                            local entry = require("telescope.actions.state").get_selected_entry()
                            local file_abs_path = entry.path
                            require("telescope.actions").close(prompt_bufnr)
                            -- ls just on symbolic links
                            local handle, err = io.popen("ls -la . | grep '\\->'")
                            -- Handle potential error related to io.popen
                            if not handle then
                                print("Error: ", err)
                                return
                            end
                            local paths = {}
                            for line in handle:lines() do
                                -- Extract the paths before and after the "->" arrow
                                local _, _, before, after = line:find("(%S+)%s+->%s+(%S+)")
                                if before and after then
                                    table.insert(paths, {before = before, after = after})
                                end
                            end
                            handle:close()
                            -- loop through table of symbolic links and compare with full path
                            for _, path in ipairs(paths) do
                                local trimmed_abs_path = string.sub(file_abs_path, 1, #path.after)
                                if string.lower(trimmed_abs_path) == string.lower(path.after) then
                                    local no_prefix_path = string.sub(file_abs_path, #path.after + 1, -1)
                                    file_abs_path = path.before .. "/" .. no_prefix_path
                                end
                            end
                            local my_path = vim.fn.expand('%:p:h') .. "/"
                            if string.sub(file_abs_path, 1, #my_path) == my_path then
                                file_abs_path = string.sub(file_abs_path, #my_path + 1, -1)
                            end
                            vim.api.nvim_put({file_abs_path}, "", false, true)
                        end,
                        -- Insert absolute path
                        ["<C-o>"] = function(prompt_bufnr)
                            local entry = require("telescope.actions.state").get_selected_entry()
                            local file_abs_path = entry.path
                            require("telescope.actions").close(prompt_bufnr)
                            vim.api.nvim_put({file_abs_path}, "", false, true)
                        end,
                    }
                },
            },
            bibtex = {
                mappings = {
                    --i = {
                    --    ["<CR>"] = require('telescope-bibtex.actions').key_append([[\citep{%s}]]), -- a string with %s to be replaced by the citation key
                    --    ["<M-CR>"] = require('telescope-bibtex.actions').key_append([[\cite{%s}]]), -- a string with %s to be replaced by the citation key
                    --}
                }
            }
        }
    }
    telescope.load_extension 'fzf'
    telescope.load_extension "bibtex"
    telescope.load_extension "file_browser"
    telescope.load_extension "ui-select"
end

return M
