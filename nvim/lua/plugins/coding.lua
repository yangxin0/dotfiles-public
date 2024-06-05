return {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    -- "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    {
        "hrsh7th/nvim-cmp",
        config = function(_, opts)
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            opts.snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            }
            opts.mapping = cmp.mapping.preset.insert({
                ["<CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true
                }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, { "i", "s" })
            })
            opts.completion = {
                keyword_length = 2
            }
            opts.sources = {
                { name = "nvim_lsp" },
                { name = "buffer" },
                { name = "luasnip" },
                { name = "path" }
            }
            opts.view = {
                docs = { auto_open = false }
            }

            opts.enabled = function()
                -- Disable completion in telescope prompt
                local buftype = vim.api.nvim_buf_get_option(0, "buftype")
                if buftype == "prompt" then return false end

                -- Disable completion in comments
                local ctx = require("cmp.config.context")
                return (not ctx.in_treesitter_capture("comment")
                    and (not ctx.in_syntax_group("Comment")))
            end

            opts.formatting = {
                format = function (_, item)
                    local max = 25
                    local abbr = item.abbr
                    local kind = item.kind
                    if #abbr > max then
                        if kind == "Function" then
                            abbr = abbr:match("[a-zA-Z0-9\\-_]+")
                            abbr = abbr .. "( ... )"
                            item.abbr = abbr
                        elseif  kind == "EnumMember" or kind == "Text" then
                            abbr = vim.fn.strcharpart(abbr, #abbr-max, max)
                            abbr = "(abbr)" .. abbr
                            item.abbr = abbr
                        end
                    end
                    return item
                end
            }
            cmp.setup(opts)

            -- Add parentheses after selecting function or method
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
            -- cmp.setup.cmdline({":", "/", "?"}, {
            --     mapping = cmp.mapping.preset.cmdline(),
            --     sources = cmp.config.sources({ { name = 'path' } }, {
            --         {
            --             name = 'cmdline',
            --             option = {
            --                 ignore_cmds = { 'Man', '!' }
            --             }
            --         }
            --     })
            -- })
        end
    },
    {
        "windwp/nvim-autopairs",
        config = function(_, _)
            local autopairs = require("nvim-autopairs")
            autopairs.setup({
                disable_filetype = { "TelescopePrompt", "vim" }
            })
        end
    },
    {
        "andymass/vim-matchup",
        init = function()
            vim.g.matchup_matchparen_deferred = 1
            vim.g.matchup_matchparen_deferred_show_delay = 100
            vim.g.matchup_matchparen_hi_surround_always = 1
            vim.g.matchup_override_vimtex = 1
            vim.g.matchup_delim_start_plaintext = 0
            vim.g.matchup_transmute_enabled = 0
        end
    },
    {
        "preservim/nerdcommenter",
        init = function()
            vim.g.NERDCreateDefaultMappings = 1
            vim.g.NERDSpaceDelims = 1
            vim.g.NERDCompactSexyComs = 1
            vim.g.NERDCommentEmptyLines = 1
            vim.g.NERDTrimTrailingWhitespace = 1
            vim.g.NERDToggleCheckAllLines = 1
            vim.g.NERDDefaultAlign = 'left'
        end
    },
    {
        "chaoren/vim-wordmotion",
        event = "VeryLazy"
    },
    {
        "ggandor/flit.nvim",
        dependencies = {
            "ggandor/leap.nvim",
            "tpope/vim-repeat"
        },
        config = function()
            local opts = {
                  keys = { f = 'f', F = 'F', t = 't', T = 'T' },
                  -- A string like "nv", "nvo", "o", etc.
                  labeled_modes = "v",
                  multiline = true,
                  -- Like `leap`s similar argument (call-specific overrides).
                  -- E.g.: opts = { equivalence_classes = {} }
                  opts = {}
            }
            require("flit").setup(opts)
        end
    }
}
