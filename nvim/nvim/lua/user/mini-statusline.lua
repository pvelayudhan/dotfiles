local M = {
  "echasnovski/mini.statusline",
  lazy = false,
}

function M.config()
  local MiniStatusline = require("mini.statusline")

  -- First, call setup
  MiniStatusline.setup({ use_icons = true })

  -- Custom section for word count
  local function section_wordcount()
    if vim.bo.buftype ~= "" then return "" end
    local wc = vim.fn.wordcount()
    return (wc and wc.words and wc.words > 0) and (" " .. wc.words) or ""
  end

  -- Override the active content with a custom layout
  MiniStatusline.config.content.active = function()
    local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
    local git           = MiniStatusline.section_git({ trunc_width = 40 })
    local diff          = MiniStatusline.section_diff({ trunc_width = 75 })
    local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
    local lsp           = MiniStatusline.section_lsp({ trunc_width = 75 })
    local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
    local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
    local location      = MiniStatusline.section_location({ trunc_width = 75 })
    local wordcount     = section_wordcount()

    return MiniStatusline.combine_groups({
      { hl = mode_hl,                  strings = { mode } },
      { hl = 'MiniStatuslineDevinfo',  strings = { git, diff, diagnostics, lsp } },
      '%<',
      { hl = 'MiniStatuslineFilename', strings = { filename } },
      '%=',
      { hl = 'MiniStatuslineFileinfo', strings = { wordcount } }, -- ⬅ word count added here
      { hl = mode_hl,                  strings = { location } },
    })
  end
end

return M
