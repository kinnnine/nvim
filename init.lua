local vim = vim
local Plug = vim.fn['plug#']

-- Vim APIs Helpers
local globalVar = vim.g
local callFunc = vim.call
local execCmd = vim.cmd
local userCmd = vim.api.nvim_create_user_command

-- Plugins
callFunc('plug#begin')
Plug('saghen/blink.cmp', { ['tag'] = 'v1.*' })
Plug('nvim-lualine/lualine.nvim')
Plug('nvim-neo-tree/neo-tree.nvim')
Plug('romgrk/barbar.nvim')
Plug('rebelot/kanagawa.nvim')
Plug('nvim-tree/nvim-web-devicons')
Plug('MunifTanjim/nui.nvim')
Plug('nvim-lua/plenary.nvim')
Plug('rafamadriz/friendly-snippets')
callFunc('plug#end')

-- Alias Commands
userCmd('ReloadConfig', 'source $MYVIMRC', {})
userCmd('Q', 'quitall', {})

-- Neovide-related Configuration
if globalVar.neovide then
	globalVar.neovide_opacity = 0.8
	globalVar.neovide_normal_opacity = 1
	globalVar.neovide_refresh_rate = 60
	globalVar.neovide_theme = 'dark'
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

-- Apply colorscheme
execCmd("colorscheme kanagawa")


