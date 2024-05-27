
vim.api.nvim_create_autocmd({ "BufNew", "InsertEnter" }, {
    callback = function(args)
        vim.diagnostic.disable(args.buf)
    end
})

vim.api.nvim_create_autocmd({ "BufWrite" }, {
    callback = function(args)
        vim.diagnostic.enable(args.buf)
    end
})
