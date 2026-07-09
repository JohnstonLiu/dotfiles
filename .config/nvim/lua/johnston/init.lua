require('johnston.lazy')

-- relative number and absolute number
vim.cmd.set('relativenumber number')
vim.cmd.set('tabstop=4 shiftwidth=4 expandtab')

-- inherit terminal backgrond transparency
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", ctermbg = "NONE" })

-- always show sign column so gitsigns bars don't make the gutter jump
vim.opt.signcolumn = 'yes'

vim.api.nvim_create_autocmd('FileType', {
    pattern = { '*.js', '*.ts', '*.jsx', '*.tsx', },
    command = 'setlocal tabstop=2 shiftwidth=2'
})

vim.api.nvim_create_autocmd('InsertEnter', {
	command = 'set norelativenumber'
})
vim.api.nvim_create_autocmd('InsertLeave', {
	command = 'set relativenumber'
})

-- remappings
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<F2>", ":%y+<CR>")

vim.diagnostic.config({ virtual_text = true })

-- auto-reload buffer when the underlying file changes on disk
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
    callback = function()
        if vim.fn.mode() ~= 'c' and vim.fn.bufexists('[Command Line]') == 0 then
            vim.cmd('checktime')
        end
    end,
})
vim.api.nvim_create_autocmd('FileChangedShellPost', {
    callback = function()
        vim.notify('File changed on disk; buffer reloaded', vim.log.levels.INFO)
    end,
})

print("loaded johnston/init.lua")
