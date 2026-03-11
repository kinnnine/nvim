local vim = vim
local Plug = vim.fn['plug#']

-- Vim APIs Helpers
local userCmd = vim.api.nvim_create_user_command

-- Plugins
vim.call('plug#begin')
Plug('saghen/blink.cmp', { ['tag'] = 'v1.*' })
Plug('nvim-lualine/lualine.nvim')
Plug('nvim-neo-tree/neo-tree.nvim')
Plug('romgrk/barbar.nvim')
Plug('nvim-tree/nvim-web-devicons')
Plug('MunifTanjim/nui.nvim')
Plug('nvim-lua/plenary.nvim')
Plug('rafamadriz/friendly-snippets')
vim.call('plug#end')

-- Alias Commands
userCmd('ReloadConfig', 'source $MYVIMRC', {})
userCmd('Q', 'quitall', {})

-- Neovide-related Configuration
if vim.g.neovide then
	vim.g.neovide_opacity = 0.8
	vim.g.neovide_normal_opacity = 1
	vim.g.neovide_refresh_rate = 60
	vim.g.neovide_theme = 'dark'
end

-- Load Plugins
require('lualine').setup()
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

