function ColorMyPencils(color)
	color = color or "kanagawa"
	vim.cmd.colorscheme(color)
end

function LineNumberColors()
	local color = '#C8C093'
	vim.api.nvim_set_hl(0, 'LineNrAbove', { fg=color })
	vim.api.nvim_set_hl(0, 'LineNr', { fg=color })
	vim.api.nvim_set_hl(0, 'LineNrBelow', { fg=color })
end


return {
    {
        'rebelot/kanagawa.nvim',
        config = function()
            vim.cmd.colorscheme 'kanagawa'
            ColorMyPencils()
            LineNumberColors()
        end
    }
}

