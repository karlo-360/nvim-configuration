return {
    {
        -- Mason
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        -- Mason LSPConfig
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "clangd", "phpactor", "jdtls", "omnisharp" },
            })
        end,
    },
    {
        -- LSP Config (nueva sintaxis)
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local opts = { noremap = true, silent = true }

            -- Nueva forma de obtener la configuración de LSP
            local lsp = vim.lsp.config

            lsp.lua_ls = {
                capabilities = capabilities,
            }

            lsp.clangd = {
                capabilities = capabilities,
            }

            lsp.phpactor = {
                capabilities = capabilities,
            }

            -- lsp.jdtls = {
            --     capabilities = capabilities,
            -- }

            lsp.omnisharp = {
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    local map = vim.api.nvim_buf_set_keymap
                    map(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
                    map(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
                    map(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
                end,
                cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
                enable_roslyn_analyzers = true,
                enable_import_completion = true,
                organize_imports_on_format = true,
            }

            -- Registrar los servidores
            vim.lsp.start(lsp.lua_ls)
            vim.lsp.start(lsp.clangd)
            vim.lsp.start(lsp.phpactor)
            vim.lsp.start(lsp.omnisharp)

            -- Keymaps globales
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
            vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)

            vim.diagnostic.config({
                signs = false,
                virtual_text = true,
                underline = true,
            })
        end,
    },
    {
        -- C# soporte adicional
        "iabdelkareem/csharp.nvim",
        config = function()
            require("csharp").setup({})
        end,
    },
    {
        -- nvim-dap (depuración)
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")

            dap.adapters.coreclr = {
                type = "executable",
                command = "netcoredbg",
                args = { "--interpreter=vscode" },
            }

            dap.configurations.cs = {
                {
                    type = "coreclr",
                    name = "launch - netcoredbg",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
                    end,
                },
            }
        end,
    },
    {
        -- Logger opcional
        "Tastyep/structlog.nvim",
    },
}
