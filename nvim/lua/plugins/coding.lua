return {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    {
        "windwp/nvim-autopairs",
        config = function(_, _)
            local autopairs = require("nvim-autopairs")
            autopairs.setup({
                disable_filetype = { "TelescopePrompt", "vim" }
            })
        end
    }
}
