local vim = vim
local Plug = vim.fn['plug#']

-- Vim APIs Helpers
local globals = vim.g
local opts = vim.opt
local callFunc = vim.call
local execCmd = vim.cmd
local userCmd = vim.api.nvim_create_user_command

-- Plugins
callFunc('plug#begin')
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
callFunc('plug#end')

-- Alias Commands
userCmd('ReloadConfig', 'source $MYVIMRC', {})
userCmd('Q', 'quitall', {})

-- Neovim Options
opts.cmdheight = 0
opts.number = true

-- Neovide-related Configuration
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

-- Plugins Configuration
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

-- Apply colorscheme
execCmd("colorscheme kanagawa")


