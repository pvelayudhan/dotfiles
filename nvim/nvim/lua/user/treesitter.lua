local M = {
    "nvim-treesitter/nvim-treesitter",
    commit = "28d480e0624b259095e56f353ec911f9f2a0f404", -- 2025-05-05
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
}
function M.config()
    require("nvim-treesitter.configs").setup {
        ignore_install = {},
        ensure_installed = {},
        sync_install = false,
        auto_install = false,
        highlight = {
            enable = true,
            disable = function(lang, bufnr)
                local path = vim.api.nvim_buf_get_name(bufnr)
                local is_large_buffer = vim.api.nvim_buf_line_count(bufnr) > 4000
                return is_large_buffer
            end,
            additional_vim_regex_highlighting = false,
        },
        indent = { enable = false },
        textobjects = {
            select = {
                enable = true,
                -- Automatically jump forward to textobj, similar to targets.vim
                lookahead = true,
                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["at"] = "@class.outer",
                    ["it"] = "@class.inner",
                    ["ac"] = "@call.outer",
                    ["ic"] = "@call.inner",
                    ["aa"] = "@parameter.outer",
                    ["ia"] = "@parameter.inner",
                    ["al"] = "@loop.outer",
                    ["il"] = "@loop.inner",
                    ["ai"] = "@conditional.outer",
                    ["ii"] = "@conditional.inner",
                    ["a/"] = "@comment.outer",
                    ["i/"] = "@comment.inner",
                    ["ab"] = "@block.outer",
                    ["ib"] = "@block.inner",
                    ["as"] = "@statement.outer",
                    ["is"] = "@scopename.inner",
                    ["aA"] = "@attribute.outer",
                    ["iA"] = "@attribute.inner",
                    ["aF"] = "@frame.outer",
                    ["iF"] = "@frame.inner",
                },
            },
        },
    }
    vim.treesitter.language.register("markdown", "quarto")
    vim.treesitter.language.register("markdown", "rmd")
end

return M
