require "nvchad.mappings"

local map = vim.keymap.set
local unmap = vim.keymap.del

-- unset keys

unmap("n", "<C-n>")

-- Add keys

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>cu", "<cmd>let @+ = expand('<cfile>')<CR>", { desc = "copy url" })
map("n", "<leader>tw", "<cmd>set wrap!<CR>", { desc = "toggle wrap"})
map("n", "<C-m>", "<cmd>NvimTreeToggle<CR>", { desc = "toggle nvimtree"})

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
