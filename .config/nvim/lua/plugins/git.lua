return {
    {
        'lewis6991/gitsigns.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            local gitsigns = require('gitsigns')
            gitsigns.setup({
                current_line_blame = true,
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = 'eol',
                    delay = 300,
                    ignore_whitespace = false,
                },
                current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
            })

            -- inline blame
            vim.keymap.set('n', '<leader>gb', gitsigns.toggle_current_line_blame,
                { desc = 'Git toggle inline blame' })
            vim.keymap.set('n', '<leader>gB', function() gitsigns.blame_line({ full = true }) end,
                { desc = 'Git blame line (full popup)' })

            -- hunk navigation
            vim.keymap.set('n', ']c', function() gitsigns.nav_hunk('next') end, { desc = 'Next git hunk' })
            vim.keymap.set('n', '[c', function() gitsigns.nav_hunk('prev') end, { desc = 'Prev git hunk' })

            -- hunk actions
            vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Preview git hunk' })
            vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Stage git hunk' })
            vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Reset git hunk' })
        end
    },
}
