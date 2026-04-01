local M = {}
local ns = vim.api.nvim_create_namespace("track_changes")

-- Highlight groups
vim.api.nvim_set_hl(0, "TrackAdd", { bg = "#2e4e2e" })
vim.api.nvim_set_hl(0, "TrackDelete", { fg = "#aa4444", strikethrough = true })

local function clear(buf)
    if vim.api.nvim_buf_is_valid(buf) then
        vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
    end
end

-- Run git word-diff
local function run_diff(file)
    -- Using the strict regex [^[:space:]]+ to treat whole words as units
    local cmd = { 
        "git", "diff", "--no-color", 
        "--word-diff=porcelain", 
        "--word-diff-regex=[^[:space:]]+", 
        "--", file 
    }
    local result = vim.fn.systemlist(cmd)
    if vim.v.shell_error ~= 0 and #result == 0 then return nil end
    return result
end

local function show_changes(buf)
    if buf == 0 then buf = vim.api.nvim_get_current_buf() end
    if not vim.api.nvim_buf_is_valid(buf) then return end
    clear(buf)
    
    local file = vim.api.nvim_buf_get_name(buf)
    if file == "" or vim.fn.filereadable(file) == 0 then return end

    local diff = run_diff(file)
    if not diff then return end

    local line = 0
    local col = 0
    local i = 1
    local total_lines = vim.api.nvim_buf_line_count(buf)

    while i <= #diff do
        local l = diff[i]

        if vim.startswith(l, "@@") then
            local start = l:match("%+(%d+)")
            line = (tonumber(start) or 1) - 1
            col = 0
        elseif vim.startswith(l, "~") then
            line = line + 1
            col = 0
        elseif vim.startswith(l, "-") or vim.startswith(l, "+") then
            local del_acc = ""
            local add_acc = ""
            
            -- Accumulator: Group all consecutive changes together
            while i <= #diff and (vim.startswith(diff[i], "-") or vim.startswith(diff[i], "+")) do
                if vim.startswith(diff[i], "-") then
                    del_acc = del_acc .. diff[i]:sub(2)
                else
                    add_acc = add_acc .. diff[i]:sub(2)
                end
                i = i + 1
            end
            i = i - 1 -- Adjust pointer back

            if line < total_lines then
                local line_content = vim.api.nvim_buf_get_lines(buf, line, line + 1, true)[1] or ""
                local line_len = #line_content
                local safe_col = math.min(col, line_len)
                
                -- The start anchor for both effects, moved back by 1 with a safeguard
                local offset_start_col = math.max(0, safe_col - 1)

                -- 1. Apply Deletion (Strikethrough)
                if #del_acc > 0 then
                    pcall(vim.api.nvim_buf_set_extmark, buf, ns, line, offset_start_col, {
                        virt_text = { { del_acc, "TrackDelete" } },
                        virt_text_pos = "inline",
                        priority = 200,
                    })
                end

                -- 2. Apply Addition (Highlight)
                if #add_acc > 0 then
                    -- Note: end_col still uses the original text length relative to safe_col
                    local end_col = math.min(safe_col + #add_acc, line_len)
                    
                    pcall(vim.api.nvim_buf_set_extmark, buf, ns, line, offset_start_col, {
                        end_col = end_col,
                        hl_group = "TrackAdd",
                        priority = 100,
                    })
                    col = col + #add_acc
                end
            end
        else
            -- Plain text: advance column counter
            col = col + #l
        end
        i = i + 1
    end
end

function M.update()
    show_changes(0)
end

function M.setup()
    local group = vim.api.nvim_create_augroup("TrackChangesGroup", { clear = true })
    
    -- standard refresh triggers
    vim.api.nvim_create_autocmd(
        { "BufEnter", "TextChanged", "TextChangedI", "BufWritePost", "FocusGained", "ShellCmdPost" },
        {
            group = group,
            callback = function()
                vim.schedule(function()
                    show_changes(0)
                end)
            end
        }
    )

    -- Explicit trigger for staging (Gitsigns / GitGutter)
    vim.api.nvim_create_autocmd("User", {
        group = group,
        pattern = { "GitSignsUpdate", "GitGutter" },
        callback = function()
            vim.schedule(function()
                show_changes(0)
            end)
        end,
    })
end

return M
