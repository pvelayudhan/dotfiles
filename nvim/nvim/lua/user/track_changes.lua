-- lua/user/track_changes.lua
local M = {}
local ns = vim.api.nvim_create_namespace("track_changes")

-- Highlight groups
vim.api.nvim_set_hl(0, "TrackAdd", { bg = "#2e4e2e" })
vim.api.nvim_set_hl(0, "TrackDelete", { fg = "#aa4444", strikethrough = true })

-- Helper: get line length
local function get_line_len(buf, line)
  local lines = vim.api.nvim_buf_get_lines(buf, line, line + 1, true)
  if #lines == 0 then return 0 end
  return #lines[1]
end

-- Helper: clamp col to the line length
local function clamp_col(buf, line, col)
  local len = get_line_len(buf, line)
  return math.max(0, math.min(col, len))
end

-- Clear existing extmarks
local function clear(buf)
  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
end

-- Run git word diff
local function run_diff(file)
  return vim.fn.systemlist({
    "git",
    "diff",
    "--no-color",
    "--word-diff=porcelain",
    "--",
    file
  })
end

-- Show changes in buffer
local function show_changes(buf)
  clear(buf)
  local file = vim.api.nvim_buf_get_name(buf)
  if file == "" then return end
  
  local diff = run_diff(file)
  local line = 0
  local col = 0
  
  for _, l in ipairs(diff) do
    if vim.startswith(l, "@@") then
      local start = l:match("%+(%d+)")
      line = tonumber(start) - 1
      col = 0
    elseif vim.startswith(l, "+") then
      local text = l:sub(2)
      local start_col = clamp_col(buf, line, col)
      local end_col = clamp_col(buf, line, col + #text)
      
      -- Only set extmark if we have a valid range
      if start_col <= end_col and line >= 0 then
        pcall(vim.api.nvim_buf_set_extmark, buf, ns, line, start_col, {
          end_col = end_col,
          hl_group = "TrackAdd",
        })
      end
      col = col + #text
    elseif vim.startswith(l, "-") then
      local text = l:sub(2)
      local safe_col = clamp_col(buf, line, col)
      
      if line >= 0 then
        pcall(vim.api.nvim_buf_set_extmark, buf, ns, line, safe_col, {
          virt_text = { { text, "TrackDelete" } },
          virt_text_pos = "inline",
        })
      end
    elseif l == "~" then
      line = line + 1
      col = 0
    else
      col = col + #l
    end
  end
end

-- Public function to update current buffer
function M.update()
  show_changes(0)
end

-- Setup autocmds
function M.setup()
  vim.api.nvim_create_autocmd(
    { "BufEnter", "TextChanged", "TextChangedI", "BufWritePost" },
    {
      callback = function()
        show_changes(0)
      end
    }
  )
end

return M
