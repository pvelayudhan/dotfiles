local M = {
    "gbrlsnchs/winpick.nvim",
    commit = "044623e236750a2f61a2cb96ce0833e113921b88",
    cmd = {"PickWin", "SwapWin"}
}

function M.config()
    local winpick = require("winpick")
    winpick.setup {
	    border = "double",
	    filter = nil,                                  -- doesn't ignore any window by default
	    prompt = "Pick a window: ",
	    format_label = winpick.defaults.format_label,  -- formatted as "<label>: <buffer name>"
	    chars = nil,
    }
end

return M
