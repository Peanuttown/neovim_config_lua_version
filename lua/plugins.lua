return require("packer").startup(function()
    use {'wbthomason/packer.nvim', opt = true}
     use { 'sainnhe/gruvbox-material' } 
	 -- LSP and completion
	 use { 'neovim/nvim-lspconfig' }
	 use { 'nvim-lua/completion-nvim' }
     use {'dart-lang/dart-vim-plugin'}
	 -- use {
	 --     'nvim-telescope/telescope.nvim',
	 --     requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
	 -- }
     use {'preservim/nerdtree'}
     use {'junegunn/fzf'} -- fzf#install()
     use {'junegunn/fzf.vim'}
     use {'MattesGroeger/vim-bookmarks'}

    use {'easymotion/vim-easymotion'}
    -- use {"akinsho/flutter-tools.nvim", requires = {"neovim/nvim-lspconfig"}}
    -- use {'Peanuttown/tzzNvimPlugin'}
	 -- use'kyazdani42/nvim-web-devicons' -- for file icons
	 -- use 'kyazdani42/nvim-tree.lua'
end)
