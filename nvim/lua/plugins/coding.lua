return {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
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
            opts.sources = {
                { name = "nvim_lsp" },
                { name = "buffer" },
		{ name = "luasnip" }
            }
            cmp.setup(opts)
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
    }
}
