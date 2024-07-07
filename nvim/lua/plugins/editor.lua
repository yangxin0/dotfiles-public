return {
    {
        "tpope/vim-fugitive",
        "tpope/vim-rhubarb",
        {
            "lewis6991/gitsigns.nvim",
            opts = {
                signcolumn = false,
                signs = {
                    add = { text = "+" },
                    change = { text = "~" },
                    delete = { text = '_' },
                    topdelete = { text = '‾' },
                    changedelete = { text = '~' }
                }
            }
        }
    },
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
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make"
            }
        },
        keys = {
            {
                "<leader>f",
                function()
                    require("telescope.builtin").find_files({
                        path_display = { "truncate" },
                        layout_config = { width = 0.6, height = 0.6}
                    })
                end,
                desc = "Search Files"
            },
            {
                "<leader>b",
                function()
                    require("telescope.builtin").buffers({
                        path_display = { "truncate" },
                        layout_config = { width = 0.6, height = 0.6}
                    })
                end,
                desc = "Search Buffers"
            },
            {
                "<leader>?",
                function()
                    require("telescope.builtin").oldfiles({
                        path_display = { "truncate" },
                        layout_config = { width = 0.6, height = 0.6}
                    })
                end,
                desc = "Recent Opened Files"
            },
            -- {
            --     "<leader>d",
            --     function()
            --         local telescope = require("telescope")
            --         local function telescope_buffer_dir()
            --             return vim.fn.expand("%:p:h")
            --         end
            --         telescope.extensions.file_browser.file_browser({
            --             path = "%:p:h",
            --             cwd = telescope_buffer_dir(),
            --             respect_ignore = false,
            --             hidden = true,
            --             disable_devicons = true,
            --             previewer = false,
            --             grouped = true,
            --             initial_mode = "normal",
            --             layout_config = { height = 40 }
            --         })
            --     end,
            --     desc = "Open File Browser"
            -- }
        },
        config = function(_, opts)
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            opts.defaults = {
                mappings = {
                    ["i"] = {
                        ["<esc>"] = actions.close
                    }
                },
                file_ignore_patterns = { "third_party" }
            }
            opts.pickers = {
                find_files = {
                    theme = "dropdown",
                    previewer = false
                },
                buffers = {
                    theme = "dropdown",
                    previewer = false
                },
                oldfiles = {
                    theme = "dropdown",
                    previewer = false
                }
            }
            opts.extensions = {
                file_browser = {
                    theme = "dropdown",
                    hijack_netrw = true,
                    mappings = {
                        ["n"] = {
                            ["<C-c>"] = actions.close
                        }
                    }
                }
            }
            telescope.setup(opts)
            require("telescope").load_extension("fzf")
            require("telescope").load_extension("file_browser")
        end
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim"
        }
    }
}
