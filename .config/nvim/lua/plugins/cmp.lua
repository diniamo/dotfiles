return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        keys = ':',
        dependencies = {
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "dmitmel/cmp-cmdline-history",
            "FelipeLema/cmp-async-path",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",

            {
                "L3MON4D3/LuaSnip",
                dependencies = { "rafamadriz/friendly-snippets" }
            },
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require("cmp")

            local luasnip = require('luasnip')
            require("luasnip.loaders.from_vscode").lazy_load()

            local has_words_before = function()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            local kind_icons = {
                Text = "",
                Method = "󰆧",
                Function = "󰊕",
                Constructor = "",
                Field = "󰇽",
                Variable = "󰂡",
                Class = "󰠱",
                Interface = "",
                Module = "",
                Property = "󰜢",
                Unit = "",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "󰈙",
                Reference = "",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "󰏿",
                Struct = "",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "󰅲",
            }

            vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'noinsert' }
            cmp.setup {
                preselect = cmp.PreselectMode.None,
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
                    ["<CR>"] = cmp.mapping(
                        function(_)
                            if not cmp.confirm({ select = false }) then
                                require("pairs.enter").type()
                            end
                        end
                    ),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp_signature_help' },
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lua' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'async_path' },
                }),
                sorting = {
                    priority_weight = 69,
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,
                        cmp.config.compare.recently_used,
                        -- require("cmp-under-comparator").under,
                        cmp.config.compare.kind,
                    }
                },
                cmp.setup.cmdline(':', {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = cmp.config.sources(
                        { { name = 'async_path' } },
                        { { name = 'cmdline' } },
                        { { name = 'cmdline_history' } }
                    )
                }),
                window = {
                    completion = cmp.config.window.bordered({
                        winhighlight = "FloatBorder:FloatBorder,CmpItemAbbrMatchFuzzy:CmpItemAbbrMatch",
                    }),
                    documentation = cmp.config.window.bordered({
                        winhighlight = "FloatBorder:FloatBorder",
                    }),
                },
                formatting = {
                    fields = { 'menu', 'abbr', 'kind' },
                    format = function(_, item)
                        item.menu = kind_icons[item.kind]

                        return item
                    end,
                },
            }
        end,
    }
}
