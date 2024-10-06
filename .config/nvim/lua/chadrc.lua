-- This file  needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
	theme = "yoru",
	hl_override = {
    Pmenu = { bg = "#0c0705" },
    Visual = { bg = {"grey", -6}},
    Normal = { bg = "#0c0705" },
    LineNr = { fg = {"grey", 16}},
    NvimTreeNormal = { bg = "#0c0705" },
    NvimTreeNormalNC = { bg = "#0c0705" },
    NvimTreeWinSeparator = { bg = "#0c0705" },
    NvimTreeWindowPicker = { bg = "#0c0705" },
    -- NvimTreeCursorLine = { bg = "#0c0705" },
  },
}

return M
