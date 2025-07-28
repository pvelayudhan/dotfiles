-- Set your preferred colorscheme here
--local default_colorscheme = "binary"

local M = {
    {
        "sainnhe/gruvbox-material",
        commit = "f5f912fbc7cf2d45da6928b792d554f85c7aa89a",
        event = "VimEnter",
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            vim.g.gruvbox_material_enable_italic = 0
            vim.g.gruvbox_material_disable_italic_comment = 1
            vim.g.gruvbox_material_transparent_background = 2
            vim.g.gruvbox_material_better_performance = 1
            vim.g.gruvbox_material_foreground = "material"
            vim.cmd.colorscheme("gruvbox-material")
        end,
    },
    {
        "jackplus-xyz/binary.nvim",
        commit = "0a0422551dfc9e8b02c00b133f63d72a75938d81"
    }
}

-- Load the selected colorscheme at startup
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.cmd.colorscheme(default_colorscheme)
    end,
})

return M
