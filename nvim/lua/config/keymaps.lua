local map = vim.keymap.set

map({"n", "v"}, ",,", "<Plug>NERDCommenterToggle")
map({"n", "v"}, ",y", "<Plug>NERDCommenterYank")
map("n", "<leader>d", vim.cmd.Ex)
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("i", "<C-c>", "<Esc>")
