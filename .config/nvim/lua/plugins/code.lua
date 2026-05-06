return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")
            -- REQUIRED
            harpoon:setup()
            -- REQUIRED

            vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
            vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

            vim.keymap.set("n", "<C-j>", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<C-k>", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<C-l>", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<C-h>", function() harpoon:list():select(4) end)

            -- Toggle previous & next buffers stored within Harpoon list
            vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
            vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
        end
    },
    {
        'nvim-telescope/telescope.nvim', tag = 'v0.2.2',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
            vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope find git files' })
            vim.keymap.set('n', '<leader>ps', function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") });
            end)
        end
    },
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end
    },
    {
        'tpope/vim-fugitive',
        config = function()
            vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = 'Git Status' })
            --vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', { desc = 'Git Commit' })
            --vim.keymap.set('n', '<leader>gp', ':Git push<CR>', { desc = 'Git Push' })
            --vim.keymap.set('n', '<leader>gP', ':Git pull<CR>', { desc = 'Git Pull' })
        end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        lazy = false,
        build = ':TSUpdate',
        config = function()
            local parsers = {
                'javascript', 'typescript', 'tsx', 'c', 'python', 'rust', 'go',
                'java', 'lua', 'vim', 'vimdoc', 'query', 'markdown',
                'markdown_inline', 'bash', 'json', 'html', 'css', 'scss',
                'yaml', 'toml', 'dockerfile', 'sql',
            }
            require('nvim-treesitter').install(parsers)

            vim.api.nvim_create_autocmd('FileType', {
                callback = function(args)
                    local ft = vim.bo[args.buf].filetype
                    local lang = vim.treesitter.language.get_lang(ft)
                    if lang and vim.treesitter.language.add(lang) then
                        pcall(vim.treesitter.start, args.buf, lang)
                        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
            })
        end
    },
}
