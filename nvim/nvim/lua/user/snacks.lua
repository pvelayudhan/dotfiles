local M = {
    {
        "folke/snacks.nvim",
        commit = "fe7cfe9800a182274d0f868a74b7263b8c0c020b",
        priority = 1000,
        lazy = false,
        opts = {
            bigfile     = { enabled = false },
            dashboard   = { enabled = false },
            explorer    = { enabled = false },
            indent      = { enabled = false },
            input       = { enabled = false },
            picker      = { enabled = true },
            notifier    = { enabled = false },
            quickfile   = { enabled = false },
            scope       = { enabled = false },
            scroll      = { enabled = false },
            statuscolumn= { enabled = false },
            words       = { enabled = false },
        },
    },
    {
        "krissen/snacks-bibtex.nvim",
        dependencies = { "folke/snacks.nvim" },
        opts = {
            format = "@%s"
        },
        keys = {
            {
                "<leader>ci",
                function()
                    require("snacks-bibtex").bibtex()
                end,
                desc = "BibTeX citations (Snacks)",
            },
        },
    },
}

return M
