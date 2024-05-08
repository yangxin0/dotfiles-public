local map = vim.keymap.set

map({"n", "v"}, ",,", "<Plug>NERDCommenterToggle")
map({"n", "v"}, ",y", "<Plug>NERDCommenterYank")
map("n", "<leader>d", vim.cmd.Ex)
