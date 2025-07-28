local M = {
    "echasnovski/mini.tabline",
    commit = "ff7a050721352580184db1ff203286c1032d5b54",
    lazy = false,
}

function M.config()
    require('mini.tabline').setup()
end

return M
