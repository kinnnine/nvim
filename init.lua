local vim = vim
local Plug = vim.fn['plug#']

-- Vim APIs Helpers
local globals = vim.g
local opts = vim.opt
local keymap = vim.api.nvim_set_keymap
local usercmd = vim.api.nvim_create_user_command
local callfunc = vim.call
local callcmd = vim.cmd

-- Plugins
callfunc('plug#begin')
Plug('saghen/blink.cmp', { ['tag'] = 'v1.*' })
Plug('duane9/nvim-rg')
Plug('nvim-lualine/lualine.nvim')
Plug('nvim-neo-tree/neo-tree.nvim')
Plug('Isrothy/neominimap.nvim')
Plug('romgrk/barbar.nvim')
Plug('rebelot/kanagawa.nvim')
Plug('nvim-tree/nvim-web-devicons')
Plug('MunifTanjim/nui.nvim')
Plug('nvim-lua/plenary.nvim')
Plug('rafamadriz/friendly-snippets')
Plug('nvim-mini/mini.diff')
callfunc('plug#end')

-- Alias commands
usercmd('ReloadConfig', 'source $MYVIMRC', {})
usercmd('Q', 'quitall', {})
usercmd('SS', 'set guifont=CommitMono\\ Nerd\\ Font:h12',{})
usercmd('SD', 'set guifont=CommitMono\\ Nerd\\ Font:h14',{})
usercmd('SE', 'set guifont=CommitMono\\ Nerd\\ Font:h16',{})

-- Override built-in commands
vim.cmd([[cnoremap q BufferClose]])
vim.cmd([[cnoremap !q BufferClose!]])

-- Keymap configuration
keymap('n', 'f', '<C-w>h', {noremap = true, silent = true})
keymap('n', '<C-s>', '<Cmd>w<CR>', {noremap = true, silent = true})
keymap('n', '.', '<C-w><', {noremap = false, silent = true})
keymap('n', ',', '<C-w>>', {noremap = false, silent = true})
keymap('n', '<A-,>', '<Cmd>BufferPrevious<CR>', {noremap = true, silent = true})
keymap('n', '<A-.>', '<Cmd>BufferNext<CR>', {noremap = true, silent = true})
keymap('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', {noremap = true, silent = true})
keymap('n', '<A->>', '<Cmd>BufferMoveNext<CR>', {noremap = true, silent = true})
keymap('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', {noremap = true, silent = true})
keymap('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', {noremap = true, silent = true})
keymap('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', {noremap = true, silent = true})
keymap('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', {noremap = true, silent = true})
keymap('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', {noremap = true, silent = true})
keymap('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', {noremap = true, silent = true})
keymap('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', {noremap = true, silent = true})
keymap('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', {noremap = true, silent = true})
keymap('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', {noremap = true, silent = true})
keymap('n', '<A-0>', '<Cmd>BufferLast<CR>', {noremap = true, silent = true})
keymap('n', '<A-p>', '<Cmd>BufferPin<CR>', {noremap = true, silent = true})
keymap('n', '<A-c>', '<Cmd>BufferClose<CR>', {noremap = true, silent = true})
keymap('n', '<C-p>',   '<Cmd>BufferPick<CR>', {noremap = true, silent = true})
keymap('n', '<C-s-p>', '<Cmd>BufferPickDelete<CR>', {noremap = true, silent = true})
keymap('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', {noremap = true, silent = true})
keymap('n', '<Space>bn', '<Cmd>BufferOrderByName<CR>', {noremap = true, silent = true})
keymap('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', {noremap = true, silent = true})
keymap('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', {noremap = true, silent = true})
keymap('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', {noremap = true, silent = true})

-- Neovim options
globals.clipboard = {
	name = 'win32yank',
	copy = {
		['+'] = 'win32yank -i --crlf',
		['*'] = 'win32yank -i --crlf',
	},
	paste = {
		['+'] = 'win32yank -o --lf',
		['*'] = 'win32yank -o --lf',
	},
	cache_enabled = 0,
}
opts.clipboard = 'unnamedplus'
opts.cmdheight = 0
opts.number = true

-- Neovide-related options
if globals.neovide then
	globals.neovide_opacity = 0.8
	globals.neovide_normal_opacity = 1
	globals.neovide_refresh_rate = 60
	globals.neovide_cursor_trail_size = 1.0
	globals.neovide_cursor_animation_length = 0.050
	globals.neovide_scroll_animation_length = 0.2
	globals.neovide_floating_blur_amount_x = 0.3
	globals.neovide_floating_blur_amount_y = 0.3
	globals.neovide_theme = 'dark'
end

-- Plugins configuration
require('lualine').setup({
	options = {
		globalstatus = true,
		component_separators = { left = '', right = ''},
		section_separators = { left = '', right = ''},
	},
	extensions = {
		'neo-tree',
	}
})
require('neo-tree').setup({
	close_if_last_window = false,
	source_selector = {
		winbar = false,
		statusline = false,
	},
})
require('barbar').setup({
	animate = false,
	sidebar_filetypes = {
		['neo-tree'] = {event = 'BufWipeout'},
	}
})
require('blink.cmp').setup({
  keymap = {
    preset = 'default',
    ['<Tab>'] = { 'select_and_accept', 'snippet_forward', 'fallback' },    
  },
  appearance = {
    nerd_font_variant = 'mono'
  },
  completion = {
    documentation = { auto_show = false }
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  fuzzy = {
    implementation = "prefer_rust_with_warning"
  },
})
globals.neominimap = {
	mini_diff = {
		enabled = true,
	}
}
require('mini.diff').setup()
require('lualine').refresh()

-- Apply colorscheme and font size
callcmd("colorscheme kanagawa")
callcmd("SD")
