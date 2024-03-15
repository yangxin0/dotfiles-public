return {
    "williamboman/mason.nvim",
    {
        "williamboman/mason-lspconfig.nvim",
        config = function(_, opts)
            require("mason").setup()
            require("neodev").setup()
            local servers = {
                lua_ls = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false }
                },
                clangd = {},
                pyright = {}
            }
            local mason_lspconfig = require("mason-lspconfig")
            opts.ensure_installed = vim.tbl_keys(servers)
            mason_lspconfig.setup(opts)
            local function on_attach(_, bufnr)
                local nmap = function(keys, func, desc)
                    if desc then
                        desc = "LSP: " .. desc
                    end
                    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
                end
                nmap("gd", vim.lsp.buf.definition, "Goto Definition")
            end
            mason_lspconfig.setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        on_attach = on_attach,
                        settings = servers[server_name]
                    })
                end
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "folke/neodev.nvim"
        }
    }
}
