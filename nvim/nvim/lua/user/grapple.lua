local M = {
    "cbochs/grapple.nvim",
    commit = "b41ddfc1c39f87f3d1799b99c2f0f1daa524c5f7",
    opts = {
        scope = "global",
        icons = false, -- setting to "true" requires "nvim-web-devicons"
        status = false,
    },
    keys = {
        { "<leader>ha", "<cmd>Grapple toggle<cr>", desc = "Tag a file" },
        { "<leader>hp", "<cmd>Grapple toggle_tags<cr>", desc = "Toggle tags menu" },

        { "<leader>1", "<cmd>Grapple select index=1<cr>zz", desc = "Select first tag" },
        { "<leader>2", "<cmd>Grapple select index=2<cr>zz", desc = "Select second tag" },
        { "<leader>3", "<cmd>Grapple select index=3<cr>zz", desc = "Select third tag" },
        { "<leader>4", "<cmd>Grapple select index=4<cr>zz", desc = "Select fourth tag" },

        { "<leader>j", "<cmd>Grapple cycle_tags next<cr>zz", desc = "Go to next tag" },
        { "<leader>k", "<cmd>Grapple cycle_tags prev<cr>zz", desc = "Go to previous tag" },
    },
}

return M
