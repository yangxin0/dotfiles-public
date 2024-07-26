local map = vim.keymap.set

map({"n", "v"}, ",,", "<Plug>NERDCommenterToggle")
map({"n", "v"}, ",y", "<Plug>NERDCommenterYank")
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("i", "<C-c>", "<Esc>")
map("n", "<C-l>", "zz")
map("n", "K", vim.lsp.buf.hover, { desc = "Show hover" })
map("n", "<leader>d", vim.cmd.Ex, { desc = "File explorer" })
map("n", "\\\\", function ()
    local active = (vim.fn.bufwinnr("neo-tree") ~= -1)
    if active then
        vim.cmd("Neotree close")
    else
        vim.cmd("Neotree reveal")
    end
end, { noremap = true, silent = true, desc = "File tree"})

map("n", "<leader>gb", ":e ++enc=gb2312<CR>:set fileencoding=utf-8<CR>:w<CR>", {
    noremap = true, silent = true, desc = "GB2312 to UTF8"
})

map("n", "<leader>\\", "glip\\", { desc = "Align backslash" })
map("n", "<leader>rci", "cs\"<", { desc = "Replace double quote with angle brackets" })
map("n", "<leader>rcI", "cs<\"", { desc = "Replace angle brackets with double quote" })

map("n", "<C-p>", require("telescope.builtin").find_files)
