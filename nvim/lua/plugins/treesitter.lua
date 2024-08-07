return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = { "lua", "cmake", "c", "cpp", "python" },
            indent = {
                enable = true,
                disable = { "python" }
            }
        }
    }
}
