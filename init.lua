----------------
--  Functions --
----------------
function File_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

----------------
--    Hacks   --
----------------

-- Hack around nixos limitation
if File_exists(os.getenv( "HOME" ) .. '/bin/venv/bin/python3') then
    vim.g.python3_host_prog = vim.fn.resolve(os.getenv( "HOME" ) .. '/bin/venv/bin/python3')
end
if File_exists(os.getenv( "HOME" ) .. '/bin/venv2/bin/python2') then
    vim.g.python_host_prog = vim.fn.resolve(os.getenv( "HOME" ) .. '/bin/venv2/bin/python2')
end


--------------------
-- Plugin loading --
--------------------

require('packer/plugins')

----------------
-- Appearance --
----------------

vim.g.starry_style = "mariana"
vim.g.starry_style_fix = true
vim.cmd('colorscheme mariana')
vim.cmd('highlight Pmenu guibg=white guifg=black gui=bold')
vim.cmd('highlight Comment gui=bold')
vim.cmd('highlight Normal gui=none')
vim.cmd('highlight NonText guibg=none')
-- Opaque Background (Comment out to use terminal's profile)
vim.cmd('set termguicolors')
vim.cmd('hi LineNr ctermfg=11 gui=bold guifg=#D8DEE9')
vim.cmd('set completeopt=menuone,noinsert,noselect')
vim.cmd('filetype plugin indent on')
vim.cmd('set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent')
vim.cmd('set incsearch ignorecase smartcase hlsearch')
vim.cmd('set ruler laststatus=2 showcmd showmode')
vim.cmd('set list listchars=trail:»,tab:»-')
vim.cmd('set fillchars+=vert:\\')
vim.cmd('set wrap breakindent')
vim.cmd('set encoding=utf-8')
vim.cmd('set number')
vim.cmd('set title')
vim.cmd('set nolist')

----------------
--  Shortcut  --
----------------
vim.g.mapleader = ","

-- NVIM-Tree
vim.api.nvim_set_keymap('', '<leader>to', ':NvimTreeFocus<CR>', { noremap = true })
vim.api.nvim_set_keymap('', '<leader>tc', ':NvimTreeClose<CR>', { noremap = true })
vim.api.nvim_set_keymap('', '<leader>tr', ':NvimTreeRefresh<CR>', { noremap = true })
vim.api.nvim_set_keymap('', '<leader>fc', ':NvimTreeFind<CR>', { noremap = true })

-- FZF
vim.api.nvim_set_keymap('', '<C-r>', ':FZF<CR>', { noremap = true })


----------------
--   Plugin   --
----------------

-- NVIM-Tree
require("nvim-tree").setup({
	filters = {
		custom = {
			'.git',
			'node_modules',
			'.cache'
		},
	},
})

-- Airline
vim.g.airline_powerline_fonts = 1
vim.g.airline_section_z = ' %{strftime("%-H:%M")}'
vim.g.airline_section_warning = ''

-- IndentLine
vim.g.indentLine_char = '▏'
vim.g.indentLine_color_gui = '#363949'

-- FZF
vim.cmd([[
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'Type'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Character'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
]])

-- vimtex
vim.cmd('syntax enable')
vim.g.vimtex_view_general_viewer = 'okular'
vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'

----------------
--     LSP    --
----------------

require('LSP/plugins')
