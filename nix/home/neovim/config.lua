local env = vim.env
local opt = vim.opt
local api = vim.api
local bo = vim.bo
local keymap = api.nvim_set_keymap
local mkAutocmd = api.nvim_create_autocmd

opt.mouse = ''
opt.showmode = false
opt.tabstop = 4
opt.shiftwidth = 0
opt.syntax = 'enable'
opt.smartindent = true
opt.smartcase = true
opt.number = true
opt.relativenumber = true
opt.compatible = false
opt.wildmode = 'longest,list,full'
opt.background = 'dark'
opt.clipboard:append('unnamedplus')
opt.complete:append('kspell')
opt.signcolumn = 'yes'

keymap('n', 'ZW', ':w<CR>', { noremap = true, })
keymap('n', 'ZE', ':e<CR>', { noremap = true, })

mkAutocmd('FileType', {
	callback = function()
		bo.formatoptions = bo.formatoptions:gsub('[cro]', '')
	end,
})

mkAutocmd('FileType', {
	callback = function()
		opt.colorcolumn = 76
		opt.textwidth = 75
		opt.spell = true
		opt.spelllang = 'en'
	end,

	pattern = {
		'mail',
	},
})

mkAutocmd('VimEnter', {
	callback = function()
		opt.termguicolors = env.TERM == 'tmux-256color'
	end,
})
