return {

    -- Colorschemes
    {
        "rebelot/kanagawa.nvim",
        enabled = true,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme "kanagawa-wave"
        end,
    },

    -- Neo Tree (File Explorer)
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        lazy = false,
        config = function()
            require("neo-tree").setup({
                filesystem = {
                    group_empty_dirs = true,
                },
            })
            vim.keymap.set('n', '<leader>e', ":Neotree filesystem reveal left<CR>", {})
        end
    },

    -- Lua Line (Line at the bottom)
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require("lualine").setup({
                options = {theme='dracula'}
            })
        end
    },

    -- Telescope (File Search + Grep)
    {
        {
            'nvim-telescope/telescope.nvim', tag = '0.1.8',
            dependencies = { 'nvim-lua/plenary.nvim' },
            config = function()
                local builtin = require("telescope.builtin")
                vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Telescope Find Files" })
                vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Telescope Live Grep" })
            end
        },
        {
            'nvim-telescope/telescope-ui-select.nvim',
            config = function()
                -- This is your opts table
                require("telescope").setup {
                    extensions = {
                        ["ui-select"] = {
                            require("telescope.themes").get_dropdown {
                            }
                        }
                    }
                }
                require("telescope").load_extension("ui-select")
            end
        }
    },

    -- Whick-Key (Vim Helper)
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    }
}
