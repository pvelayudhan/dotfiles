local M = {
    "ggandor/leap.nvim",
    commit = "2b68ddc0802bd295e64c9e2e75f18f755e50dbcc"
}

function M.config()
    require('leap').create_default_mappings()
end

return M
