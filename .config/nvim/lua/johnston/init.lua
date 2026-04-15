require('johnston.lazy')

-- relative number and absolute number
vim.cmd.set('relativenumber number')
vim.cmd.set('tabstop=4 shiftwidth=4 expandtab')

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
print("loaded johnston/init.lua")
