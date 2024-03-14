return {
    {
        "max397574/better-escape.nvim",
        opts = {
            mapping = { "jk" },
            timeout = vim.o.timeoutlen,
            clear_empty_lines = true,
            keys = "<Esc>"
        }
    },
    {
        "telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make"
            },
            "nvim-telescope/telescope-file-browser.nvim"
        },
        keys = {
            {
                "\\\\",
                function() require("telescope.builtin").find_files() end,
                desc = "Search Files"
            },
            {
                "<leader>b",
                function() require("telescope.builtin").buffers() end,
                desc = "Search Buffers"
            },
            {
                "<leader>?",
                function() require("telescope.builtin").oldfiles() end,
                desc = "Recent Opened Files"
            },
            {
                "<leader>f",
                function()
                    local telescope = require("telescope")
                    local function telescope_buffer_dir()
                        return vim.fn.expand("%:p:h")
                    end
                    telescope.extensions.file_browser.file_browser({
                        path = "%:p:h",
                        cwd = telescope_buffer_dir(),
                        respect_ignore = false,
                        hidden = true,
                        disable_devicons = true,
                        grouped = true,
                        previewer = false,
                        initial_mode = "normal",
                        layout_config = { height = 40 }
                    })
                end,
                desc = "Open File Browser with the path of current buffer"
            }
        },
        config = function(_, opts)
            local telescope = require("telescope")
            opts.pickers = {
                find_files = {
                    theme = "dropdown",
                    previewer = false
                },
                buffers = {
                    theme = "dropdown",
                    previewer = false
                }
            }
            opts.extensions = {
                file_browser = {
                    theme = "dropdown",
                    hijack_netrw = true
                }
            }
            telescope.setup(opts)
            require("telescope").load_extension("fzf")
            require("telescope").load_extension("file_browser")
        end
    }
}
