return require("packer").startup(function()
    use {'wbthomason/packer.nvim', opt = true}
     use { 'sainnhe/gruvbox-material' } 
	 -- LSP and completion
	 use { 'neovim/nvim-lspconfig' }
	 use { 'nvim-lua/completion-nvim' }




end)
