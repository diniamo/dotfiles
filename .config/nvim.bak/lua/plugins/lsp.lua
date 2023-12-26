return {
    {
        -- The order is important here
        "neovim/nvim-lspconfig",
        event = "BufReadPost",
        dependencies = {
            {
                "williamboman/mason-lspconfig.nvim",
                dependencies = {
                    {
                        "williamboman/mason.nvim",
                        opts = {

                            ui = {
                                icons = {
                                    package_installed = "✓",
                                    package_pending = "➜",
                                    package_uninstalled = "✗"
                                },
                                border = "rounded"
                            }
                        }
                    }
                },
                opts = { automatic_installion = true }
            },
        },
        config = function()
            local on_attach = function(client, bufnr)
                require('nvim-navic').attach(client, bufnr)
                require('nvim-navbuddy').attach(client, bufnr)

                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
                vim.keymap.set('n', '<C-h>', vim.lsp.buf.signature_help, bufopts)
                vim.keymap.set('n', '<Leader>d', vim.lsp.buf.type_definition, bufopts)
                vim.keymap.set('n', '<Leader>r', vim.lsp.buf.rename, bufopts)
                vim.keymap.set('n', '<Leader>a', vim.lsp.buf.code_action, bufopts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
                vim.keymap.set('n', '<Leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
            end

            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local lspconfig = require('lspconfig')

            lspconfig['pylsp'].setup {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    pylsp = {
                        plugins = {
                            pycodestyle = {
                                ignore = { 'F405', 'W503', 'W504' },
                                maxLineLength = 150
                            },
                            flake8 = {
                                ignore = { 'F405', 'W503', 'W504' },
                            },
                            rope_completion = { enabled = true },
                            rope_autoimport = { enabled = true },
                        }
                    }
                }
            }

            lspconfig['lua_ls'].setup {
                on_attach = on_attach,
                capabilities = capabilities,

                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            globals = { 'vim' },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false
                        },
                        telemetry = {
                            enable = false,
                        },
                    }
                }
            }
        end
    },
    {
        url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        event = "VeryLazy",
        config = function()
            require("lsp_lines").setup()

            local lsp_lines_toggle = true
            vim.keymap.set('n', '<leader>l',
                function()
                    lsp_lines_toggle = not lsp_lines_toggle

                    if lsp_lines_toggle then
                        vim.diagnostic.config({ virtual_lines = true })
                    else
                        vim.diagnostic.config({ virtual_lines = false })
                    end
                end)
            vim.api.nvim_create_autocmd("ModeChanged", {
                callback = function()
                    local current_mode = vim.fn.mode()

                    if (current_mode == 'n' or current_mode == 't' or current_mode == 'c') and lsp_lines_toggle then
                        -- This fixes the issue where it doesn't appear for some reason
                        vim.defer_fn(function()
                            vim.diagnostic.config({ virtual_lines = true })
                        end, 0)
                    else
                        vim.diagnostic.config({ virtual_lines = false })
                    end
                end
            })
        end
    },
    {
        "simrat39/rust-tools.nvim",
        ft = "rs",
        event = "BufReadPost",
        opts = {
            server = {
                on_attach = function(client, bufnr)
                    require('nvim-navic').attach(client, bufnr)
                    require('nvim-navbuddy').attach(client, bufnr)

                    local rust_tools = require("rust-tools")

                    local bufopts = { noremap = true, silent = true, buffer = bufnr }

                    vim.keymap.set('n', "<Leader>k", function() rust_tools.move_item.move_item(true) end, bufopts)
                    vim.keymap.set('n', "<Leader>j", function() rust_tools.move_item.move_item(false) end, bufopts)
                    vim.keymap.set('n', "<Leader>J", rust_tools.join_lines.join_lines, bufopts)

                    vim.keymap.set("n", "K", rust_tools.hover_actions.hover_actions, bufopts)
                    vim.keymap.set("n", "<Leader>a", rust_tools.code_action_group.code_action_group, bufopts)

                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
                    vim.keymap.set('n', '<C-h>', vim.lsp.buf.signature_help, bufopts)
                    vim.keymap.set('n', '<Leader>td', vim.lsp.buf.type_definition, bufopts)
                    vim.keymap.set('n', '<Leader>r', vim.lsp.buf.rename, bufopts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
                    vim.keymap.set('n', '<Leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
                end
            }
        }
    },
}
