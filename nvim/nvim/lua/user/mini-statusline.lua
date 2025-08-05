local M = {
  "echasnovski/mini.statusline",
  lazy = false,
}

function M.config()
  local MiniStatusline = require("mini.statusline")

  -- First, call setup
  MiniStatusline.setup({ use_icons = true })

  -- Show macro recording status (if any)
  local function recording_status()
    local reg = vim.fn.reg_recording()
    if reg == "" then return "" end
    return "⏺ @" .. reg
  end

  -- Custom section for word count
  local function section_wordcount()
    if vim.bo.buftype ~= "" then return "" end
    local wc = vim.fn.wordcount()
    return (wc and wc.words and wc.words > 0) and (" " .. wc.words) or ""
  end

  -- Add auto-command to update statusline when recording starts/stops
  vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
    callback = function()
      vim.cmd("redrawstatus")
    end
  })

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
    local recording     = recording_status()

    return MiniStatusline.combine_groups({
      { hl = mode_hl,                  strings = { mode } },
      { hl = 'MiniStatuslineDevinfo',  strings = { git, diff, diagnostics, lsp } },
      '%<',
      { hl = 'MiniStatuslineFilename', strings = { filename } },
      '%=',
      { hl = 'MiniStatuslineFileinfo', strings = { wordcount, recording } }, -- ⬅ word count added here
      { hl = mode_hl,                  strings = { location } },
    })
  end
end

return M
