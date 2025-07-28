-- Makes a 79-char long title version of line under the cursor
function HashHeader(args, pattern)
    pattern = pattern or vim.bo.commentstring:gsub(" %%s", "")
    local line = vim.api.nvim_get_current_line()
    local prefix = pattern
    if ( string.len(line) > 0 ) then
        prefix = pattern .. " " .. line .. " "
    end
    --local fill = math.floor((79 - string.len(prefix)) / string.len(pattern))
    local fill = 79 - string.len(prefix)
    local newline = prefix .. string.rep("-", fill)
    if ( args.caps ) then
        newline = string.upper(newline)
    end
    vim.api.nvim_set_current_line(newline)
end

-- Places current time at cursor location
function CurrentDate()
    local date_raw = os.date("*t")
    local date = ("%04d-%02d-%02d"):format(date_raw.year, date_raw.month, date_raw.day)
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { date })
end

-- Places current time at cursor location
function CurrentTime()
    local time_raw = os.date("*t")
    local time = ("%02d:%02d"):format(time_raw.hour, time_raw.min)
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { time })
end

function OilWhitespaceReset()
    vim.cmd("%s/\\(....\\).\\(.\\)../\\1 \\2  /")
end

-- Define the function to apply two substitutions to the highlighted text
function LatexTableAlign()
    vim.cmd("Tabularize / & /l0")
    vim.cmd("Tabularize /\\\\\\\\")
end

function OpenMatchingPdf()
    local file_name = vim.fn.expand('%:p:r') -- Get the current file name without extension
    -- Modify this command to match your PDF viewer and path
    local pdf_command = 'tmux new -d sioyek --new-window ' .. file_name .. '.pdf &'
    -- Execute the command to open the PDF
    vim.fn.system(pdf_command)
end

function SelectParagraph()
    -- Get the current buffer and cursor position
    local bufnr = vim.api.nvim_get_current_buf()
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local row = cursor_pos[1] - 1
    -- Find the start and end of the paragraph
    local start_row = row
    local end_row = row
    -- Find the start of the paragraph
    while start_row > 0 and not vim.api.nvim_buf_get_lines(bufnr, start_row - 1, start_row, false)[1]:match("^%s*$") do
        start_row = start_row - 1
    end
    -- Find the end of the paragraph
    local line_count = vim.api.nvim_buf_line_count(bufnr)
    while end_row < line_count - 1 and not vim.api.nvim_buf_get_lines(bufnr, end_row + 1, end_row + 2, false)[1]:match("^%s*$") do
        end_row = end_row + 1
    end
    -- Adjust start_row if the first line contains backticks
    if start_row == 0 then
        if vim.api.nvim_buf_get_lines(bufnr, start_row, start_row + 1, false)[1]:match("^```") then
            start_row = start_row + 1
        end
    else
        if vim.api.nvim_buf_get_lines(bufnr, start_row, start_row + 1, false)[1]:match("^```") then
            start_row = start_row + 1
        end
    end
    -- Adjust end_row if the last line contains backticks
    if vim.api.nvim_buf_get_lines(bufnr, end_row, end_row + 1, false)[1]:match("^```") then
        end_row = end_row - 1
    end
    -- Select the paragraph
    vim.api.nvim_win_set_cursor(0, {start_row + 1, 0})
    vim.cmd('normal! V')
    vim.api.nvim_win_set_cursor(0, {end_row + 1, 0})
end

function SaveSession()
    local saveprompt = "Save to " .. vim.fn.getcwd() .. "? (Y/n): "
    vim.ui.input({ prompt = saveprompt }, function(input)
        if input == "y" or input == "" or input == "Y" then
            vim.cmd('mksession!')
            print("\nSession saved to " .. vim.fn.getcwd())
        else
            print("Session not saved.")
        end
    end)
end

function kitty(listen)
    local termpath = "/tmp/mykitty" .. listen
    local handle = io.popen("[ -e '" .. termpath .. "' ] && echo 1 || echo 0")
    local result = handle:read("*a")
    handle:close()
    result = string.sub(result, 1, 1)
    if (result == "0") then
        vim.cmd(string.format([[silent !kitty --listen-on=unix:%s -e tmux &]], termpath))
    else
        print("A window listening to " .. termpath .. " is already open!")
        local overwrite = vim.fn.input("Overwrite file? ([N/y]): ", "", "file")
        if (overwrite == "y") then
            vim.cmd(string.format([[!rm %s &]], termpath))
            vim.cmd(string.format([[silent !kitty --listen-on=unix:%s -e tmux &]], termpath))
        end
    end
end

function StripWhitespace()
    -- Save the cursor position
    local save_cursor = vim.fn.getpos('.')
    -- Strip whitespace from the current buffer
    vim.cmd([[ %s/\s\+$//e ]])
    -- Restore the cursor position
    vim.fn.setpos('.', save_cursor)
end

function PickWin()
    local winid = require'winpick'.select()
    if winid then
        vim.api.nvim_set_current_win(winid)
    end
end

function SwapWin()
    local winid1 = require'winpick'.select()
    local winid2 = require'winpick'.select()
    if not winid1 or not winid2 then
        print("Failed to obtain valid window IDs")
        return
    end
    vim.api.nvim_set_current_win(winid1)
    local buf1 = vim.api.nvim_win_get_buf(0)
    vim.api.nvim_set_current_win(winid2)
    local buf2 = vim.api.nvim_win_get_buf(0)
    vim.api.nvim_win_set_buf(winid1, buf2)
    vim.api.nvim_win_set_buf(winid2, buf1)
end

function SplitLine(line_max)
    -- Length of the line before breaking
    line_max = line_max or 79
    local line = vim.api.nvim_get_current_line()
    -- Content of line excluding quotes and leading whitespace
    local true_line = string.gsub(string.gsub(line, "^%s+", ""), '"', "")
    local lead_whitespace_len = string.len(string.match(line, "^%s*"))
    local true_segment_len = line_max - lead_whitespace_len - 3 -- for "",
    local n_new_lines = math.ceil(string.len(true_line) / true_segment_len)
    local line_num = vim.api.nvim_win_get_cursor(0)[1] - 1
    -- Replace current line
    vim.api.nvim_buf_set_lines(0, line_num, line_num + 1, false, {})
    -- Iteratively add new segments
    for i = 1, n_new_lines do
        local start_idx = (i - 1) * true_segment_len + 1
        local end_idx = i * true_segment_len
        local segment = ""
        if (i == n_new_lines) then
            segment = 
            string.rep(" ", lead_whitespace_len) .. '"' ..
            string.sub(true_line, start_idx, end_idx) .. '"'
        else
            segment = 
            string.rep(" ", lead_whitespace_len) .. '"' ..
            string.sub(true_line, start_idx, end_idx) .. '",'
        end
        vim.api.nvim_buf_set_lines(0, line_num, line_num, false, { segment })
        line_num = line_num + 1
    end
end

-- Function to shrink a CSV file (ChatGPT)
function ShrinkCSV()
    -- Save current cursor position
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    -- Get the current buffer's lines
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    -- Function to trim leading and trailing spaces
    local function trim(s)
        return s:match("^%s*(.-)%s*$")
    end
    -- Process each line to trim spaces from each column
    for i, line in ipairs(lines) do
        -- Split line into columns by commas
        local columns = vim.fn.split(line, ",")
        -- Trim spaces from each column
        for j, col in ipairs(columns) do
            columns[j] = trim(col)
        end
        -- Now ensure trailing commas are preserved (i.e., we don't remove columns with trailing empty spaces)
        -- We will add a check to append an empty column at the end if there's a trailing comma
        -- in the original line
        if line:match(",%s*$") then
            table.insert(columns, "")
        end
        -- Rejoin columns back into a single line with commas
        lines[i] = table.concat(columns, ",")
    end
    -- Replace the lines in the buffer with the trimmed lines
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    -- Restore the cursor position
    vim.api.nvim_win_set_cursor(0, cursor_pos)
end

-- Manage custom file type opening in Oil
function OilOpen()
    local entry = require("oil").get_cursor_entry()
    if not entry then
        return
    end
    local dir = require("oil").get_current_dir()
    local filepath = require("plenary.path"):new(dir, entry.name):absolute()
    if entry.type == "file" and entry.name:match("%.pdf$") then
        local cmd = 'tmux new -d sioyek --new-window ' .. filepath .. ' &'
        vim.fn.system(cmd)
        vim.cmd("quit")
    else
        require("oil").select({ horizontal = false, vertical = false })
    end
end
