return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  
  -- Theme
  use 'ray-x/starry.nvim'

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

  -- Tree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    }
  }

  -- Completion
  use { 'ms-jpq/coq_nvim', run = ':COQdeps'}
  use { 'ms-jpq/coq.artifacts', run = ':COQsnips compile' }

  -- COQsnips compile

  -- LSP config
  use 'neovim/nvim-lspconfig'

  -- Enable features of rust-analyzer, such as inlay hints, etc.
  use 'simrat39/rust-tools.nvim'
end)
