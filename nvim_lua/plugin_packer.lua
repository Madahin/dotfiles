return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Theme
  --  use 'ray-x/starry.nvim'
   use {'ray-x/starry.nvim', config = function()
   local starry_config = {
  border = false, -- Split window borders
  hide_eob = true, -- Hide end of buffer
  italics = {
    comments = false, -- Italic comments
    strings = false, -- Italic strings
    keywords = false, -- Italic keywords
    functions = false, -- Italic functions
    variables = false -- Italic variables
  },

  contrast = { -- Select which windows get the contrast background
    enable = true, -- Enable contrast
    terminal = true, -- Darker terminal
    filetypes = {}, -- Which filetypes get darker? e.g. *.vim, *.cpp, etc.
  },

  text_contrast = {
    lighter = false, -- Higher contrast text for lighter style
    darker = false -- Higher contrast text for darker style
  },

  disable = {
    background = false, -- true: transparent background
    term_colors = false, -- Disable setting the terminal colors
    eob_lines = false -- Make end-of-buffer lines invisible
  },

  style = {
    name = 'moonlight', -- Theme style name (moonlight, earliestsummer, etc.)
    -- " other themes: dracula, oceanic, dracula_blood, 'deep ocean', darker, palenight, monokai, mariana, emerald, middlenight_blue
    disable = {},  -- a list of styles to disable, e.g. {'bold', 'underline'}
    fix = true,
    darker_contrast = false, -- More contrast for darker style
    daylight_swith = false, -- Enable day and night style switching
    deep_black = false, -- Enable a deeper black background
  },

  custom_colors = {
    variable = '#f797d7',
  },
  custom_highlights = {
    LineNr = { fg = '#777777' },
    Idnetifier = { fg = '#ff4797' },
  }
}
 require('starry').setup(starry_config)
 vim.cmd('colorscheme mariana')
   end
  }


  -- Status bar
  use 'vim-airline/vim-airline'

  -- Icons for file and folders
  use 'ryanoasis/vim-devicons'
  use 'kyazdani42/nvim-web-devicons'
  use {
    "projekt0n/circles.nvim",
    requires = {"kyazdani42/nvim-web-devicons"},
    config = function()
      require("circles").setup()
    end
  }

  -- Git integration
  use 'tpope/vim-fugitive'

  -- Basic configuration
  use 'tpope/vim-sensible'

  -- Allows to use <Tab> for insert completion
  use 'ervandew/supertab'

  -- Auto-close (x)html tags
  use 'alvan/vim-closetag'

  -- Add a vertical line on space indent
  use 'Yggdroot/indentLine'

  -- Fuzzy finder
  use { 'junegunn/fzf', run = './install --bin' }
  use 'junegunn/fzf.vim'

  -- Generic language support
  use 'sheerun/vim-polyglot'

  -- ARM assembly syntax
  use 'ARM9/arm-syntax-vim'

  -- GBA assembly syntax
  use 'vim-scripts/rgbasm.vim'

  -- Z80 assembly syntax
  use 'samsaga2/vim-z80'

  -- Tree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    }
  }

  use 'lervag/vimtex'

  -- Completion
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use { 'ms-jpq/coq_nvim', run = ':COQdeps'}
  use { 'ms-jpq/coq.artifacts', run = ':COQsnips compile' }

  -- Activate python virtualenv when necessary
  use 'jmcantrell/vim-virtualenv'

  -- LSP config
  use 'neovim/nvim-lspconfig'

  -- Enable features of rust-analyzer, such as inlay hints, etc.
  use 'simrat39/rust-tools.nvim'
end)
