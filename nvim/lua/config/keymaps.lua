local map = vim.keymap.set
local local_map = vim.api.nvim_buf_set_keymap

map({"n", "v"}, ",,", "<Plug>NERDCommenterToggle")
map({"n", "v"}, ",y", "<Plug>NERDCommenterYank")
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("i", "<C-c>", "<Esc>")
map({ "n", "i" }, "<C-l>", "zz")
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


map("n", "<C-p>", function()
    require("telescope.builtin").find_files({
        path_display = { "truncate" },
        layout_config = { width = 0.6, height = 0.6 }
    })
end, { desc = "Find Files"})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp" },
    callback = function()
        local_map(0, "n", "<leader>i", ':normal cs"><CR>', { desc = "#include<header.h>" })
        local_map(0, "n", "<leader>I", ':normal cs>"<CR>', { desc = "#include\"header.h\"" })
        local_map(0, "n", "<leader>\\", ":normal glip\\", { desc = "Align backslash" })
    end
})
