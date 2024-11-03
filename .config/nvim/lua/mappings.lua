require "nvchad.mappings"

local map = vim.keymap.set
local unmap = vim.keymap.del

-- unset keys

unmap("n", "<C-n>")
unmap("n", "<M-i>")
unmap("n", "<M-v>")
unmap("n", "<Space>v")
unmap("n", "<Space>h")
unmap("n", "<Space>cc")
unmap("n", "<Space>pt")
unmap("n", "<Space>gt")
unmap("n", "<Space>cm")
unmap("n", "<Space>e")
unmap("n", "&")
unmap("n", "[d")
unmap("n", "]d")
unmap("n", "gc")
unmap("n", "gx")
unmap("n", "<C-W><C-D>")
unmap("n", "<C-W>d")

-- Add keys

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>cu", "<cmd>let @+ = expand('<cfile>')<CR>", { desc = "copy url" })
map("n", "<leader>tw", "<cmd>set wrap!<CR>", { desc = "toggle wrap" })
map("n", "<C-m>", "<cmd>NvimTreeToggle<CR>", { desc = "toggle nvimtree" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
