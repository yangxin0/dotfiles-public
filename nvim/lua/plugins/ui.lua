return {
    {
        "navarasu/onedark.nvim",
        priority = 1000,
        config =function()
            vim.cmd.colorscheme("onedark")
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                icons_enabled = false,
                theme = "onedark",
                component_separators = "|",
                section_separators = ""
            },
            sections = {
                lualine_c = {
                    {
                        "filename",
                        path = 1 -- Absolute path
                    }
                }
            }
        }
    },
    { "folke/which-key.nvim", opts = {} }
}
