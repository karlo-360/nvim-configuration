return {
    {
        -- Mason
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "clangd", "phpactor", "jdtls", "omnisharp" },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Define `opts` como una tabla vacía
            local opts = {}

            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.clangd.setup({
                capabilities = capabilities,
            })
            lspconfig.phpactor.setup({
                capabilities = capabilities,
            })
            --lspconfig.jdtls.setup({
                --capabilities = capabilities,
            --})
            lspconfig.omnisharp.setup({
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    -- Mapeos específicos para OmniSharp
                    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
                    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
                    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
                end,
                cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
                enable_roslyn_analyzers = true,
                enable_import_completion = true,
                organize_imports_on_format = true,
            })

            -- keymaps
            vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
            vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
            vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
            vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
            vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
            vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
            vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
            vim.keymap.set("n", "<leader>rr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
            vim.keymap.set("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

            vim.diagnostic.config({
                signs = false,
                virtual_text = true,
                underline = true,
            })
        end,
    },
    {
        -- csharp.nvim
        "iabdelkareem/csharp.nvim",
        config = function()
            require("csharp").setup({
                -- Configuración específica de csharp.nvim si es necesaria
            })
        end,
    },
    {
        -- nvim-dap
        "mfussenegger/nvim-dap",
        config = function()
            -- No hay una función setup para nvim-dap, pero puedes configurar adaptadores aquí
            local dap = require("dap")

            -- Configuración de adaptadores (por ejemplo, para C#)
            dap.adapters.coreclr = {
                type = 'executable',
                command = 'netcoredbg',
                args = {'--interpreter=vscode'}
            }

            dap.configurations.cs = {
                {
                    type = "coreclr",
                    name = "launch - netcoredbg",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
                    end,
                },
            }
        end,
    },
    {
        -- structlog.nvim
        "Tastyep/structlog.nvim",
    },
}
