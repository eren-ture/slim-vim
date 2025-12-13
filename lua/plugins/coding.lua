return {
    -- Snippets
    { "L3MON4D3/LuaSnip", keys = {} },

    -- Auto-complete
    {
        "saghen/blink.cmp",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        version = "*",
        config = function()
            require("blink.cmp").setup({
                snippets = { preset = "luasnip" },
                signature = { enabled = true },
                appearance = {
                    use_nvim_cmp_as_default = false,
                    nerd_font_variant = "normal",
                },
                sources = {
                    default = { "lsp", "path", "snippets", "buffer" },
                    providers = {
                        cmdline = {
                            min_keyword_length = 2,
                        },
                    },
                },
                keymap = {
                    ["<C-f>"] = {},
                },
                cmdline = {
                    enabled = false,
                    completion = { menu = { auto_show = true } },
                    keymap = {
                        ["<CR>"] = { "accept_and_enter", "fallback" },
                    },
                },
                completion = {
                    menu = {
                        border = nil,
                        scrolloff = 1,
                        scrollbar = false,
                        draw = {
                            columns = {
                                { "kind_icon" },
                                { "label",      "label_description", gap = 1 },
                                { "kind" },
                                { "source_name" },
                            },
                        },
                    },
                    documentation = {
                        window = {
                            border = nil,
                            scrollbar = false,
                            winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc',
                        },
                        auto_show = true,
                        auto_show_delay_ms = 500,
                    },
                },
            })

            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },

    -- Pairings
    {
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        opts = {
            modes = { insert = true, command = true, terminal = false },
            -- skip autopair when next character is one of these
            skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
            -- skip autopair when the cursor is inside these treesitter nodes
            skip_ts = { "string" },
            -- skip autopair when next character is closing pair
            -- and there are more closing pairs than opening pairs
            skip_unbalanced = true,
            -- better deal with markdown code blocks
            markdown = true,
        },
    },

    -- Surround
    {
        "kylechui/nvim-surround",
        version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },

    -- Better Commenting
    {
        "folke/ts-comments.nvim",
        opts = {},
        event = "VeryLazy",
        enabled = vim.fn.has("nvim-0.10.0") == 1,
    },

    -- Git Signs
    {
        "lewis6991/gitsigns.nvim",
        opts = {},
        config = function()
            require('gitsigns').setup {
                signs = {
                    add          = { text = '┃' },
                    change       = { text = '┃' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                },
                signs_staged = {
                    add          = { text = '┃' },
                    change       = { text = '┃' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                },
                signs_staged_enable = true,
                signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
                numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
                linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
                word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
                watch_gitdir = {
                    follow_files = true
                },
                auto_attach = true,
                attach_to_untracked = false,
                current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                    delay = 1000,
                    ignore_whitespace = false,
                    virt_text_priority = 100,
                    use_focus = true,
                },
                current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
                sign_priority = 6,
                update_debounce = 100,
                status_formatter = nil, -- Use default
                max_file_length = 40000, -- Disable if file is longer than this (in lines)
                preview_config = {
                    -- Options passed to nvim_open_win
                    style = 'minimal',
                    relative = 'cursor',
                    row = 0,
                    col = 1
                },
                on_attach = function(bufnr)
                    local gitsigns = require('gitsigns')

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']c', function()
                        if vim.wo.diff then
                            vim.cmd.normal({']c', bang = true})
                        else
                            gitsigns.nav_hunk('next')
                        end
                    end, { desc = "Next hunk" })

                    map('n', '[c', function()
                        if vim.wo.diff then
                            vim.cmd.normal({'[c', bang = true})
                        else
                            gitsigns.nav_hunk('prev')
                        end
                    end, { desc = "Previous hunk" })

                    -- Actions
                    map('n', '<leader>hs', gitsigns.stage_hunk, { desc = "Stage hunk" })
                    map('n', '<leader>hr', gitsigns.reset_hunk, { desc = "Reset hunk" })

                    map('v', '<leader>hs', function()
                        gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                    end, { desc = "Stage hunk" })

                    map('v', '<leader>hr', function()
                        gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                    end, { desc = "Reset hunk" })

                    map('n', '<leader>hS', gitsigns.stage_buffer, { desc = "Stage buffer" })
                    map('n', '<leader>hR', gitsigns.reset_buffer, { desc = "Reset buffer" })
                    map('n', '<leader>hp', gitsigns.preview_hunk, { desc = "Preview hunk" })
                    map('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = "Preview hunk inline" })

                    map('n', '<leader>hb', function()
                        gitsigns.blame_line({ full = true })
                    end, { desc = "Blame line" })

                    map('n', '<leader>hd', gitsigns.diffthis, { desc = "Diff this" })

                    map('n', '<leader>hD', function()
                        gitsigns.diffthis('~')
                    end, { desc = "Diff this ~" })

                    map('n', '<leader>hQ', function() gitsigns.setqflist('all') end, { desc = "All hunks to qflist" })
                    map('n', '<leader>hq', gitsigns.setqflist, { desc = "Hunks to qflist" })

                    -- Toggles
                    map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = "Toggle blame" })
                    map('n', '<leader>tw', gitsigns.toggle_word_diff, { desc = "Toggle word diff" })

                    -- Text object
                    map({'o', 'x'}, 'ih', gitsigns.select_hunk, { desc = "Select hunk" })
                end
           }
        end
    },

    -- Guess Indent
    {
        "NMAC427/guess-indent.nvim",
        opts = {},
        config = function()
            require('guess-indent').setup {
                auto_cmd = true,
                override_editorconfig = false, -- Set to true to override settings set by .editorconfig
                filetype_exclude = {  -- A list of filetypes for which the auto command gets disabled
                    "netrw",
                    "tutor",
                },
                buftype_exclude = {  -- A list of buffer types for which the auto command gets disabled
                    "help",
                    "nofile",
                    "terminal",
                    "prompt",
                },
                on_tab_options = { -- A table of vim options when tabs are detected
                    ["expandtab"] = false,
                },
                on_space_options = { -- A table of vim options when spaces are detected
                    ["expandtab"] = true,
                    ["tabstop"] = "detected", -- If the option value is 'detected', The value is set to the automatically detected indent size.
                    ["softtabstop"] = "detected",
                    ["shiftwidth"] = "detected",
                },
            }
        end
    }
}
