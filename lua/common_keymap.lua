local os = require("os")
--edit common_keymap.lua
vim.cmd("nnoremap -ek :e ~/.config/nvim/lua/common_keymap.lua<CR>")

-- edit init.lua
vim.cmd(string.format("nnoremap -es :e %s<CR>",os.getenv("NVIMRC")))
-- vim.api.nvim_set_keymap('n',"-es","e " .. os.getenv("NVIMRC") .. "<CR>",{})

-- TODO source init.lua
vim.cmd(string.format(
	"nnoremap -ees :luafile %s<CR>",os.getenv("NVIMRC")
))

-- vsplit windows
vim.cmd("nnoremap -vs :vs<CR><c-w>l")

-- edit ~/.config/nvim/lua
vim.cmd("nnoremap -el :e ~/.config/nvim/lua")

-- quit buffer
vim.cmd("nnoremap -q :q<CR>")

-- update buffer
vim.cmd("nnoremap -w :up<CR>")

-- u1010
vim.cmd("inoremap -ch တ")

-- u1008
vim.cmd("inoremap -yy ဈ")

vim.cmd("nnoremap -tc :terminal<CR>")
-- vim.cmd("inoremap <c-j> <esc>")
    vim.cmd("inoremap <c-j> <Cmd> call TzzEnter()<Cr>")

vim.cmd("tnoremap <c-j> <c-\\><c-n>")

-- တ  cursor move
vim.cmd("inoremap <c-f> <right>")
vim.cmd("inoremap <c-l> <esc>o")
vim.cmd("inoremap <c-e> <esc>A")
vim.cmd("inoremap <c-b> <left>")
vim.cmd("inoremap <c-a> <esc>I")
-- ဈ

vim.cmd("nnoremap -tt :tabnew<CR>:terminal<CR>")

vim.cmd("nnoremap <s-u> :e#<CR>")
vim.cmd("inoremap \" \"\"<Left>")
vim.cmd("inoremap ( ()<Left>")
vim.cmd("inoremap { {}<Left>")

-- တ  unknown option
vim.o.wildignorecase=true
vim.wo.number = true
-- ဈ
vim.cmd("nnoremap -ep :e ~/.config/nvim/lua/plugins.lua<CR>")

vim.cmd("inoremap <c-j> <Down>")
vim.cmd("inoremap <c-k> <Up>")



vim.cmd("inoremap \" \"\"<LEFT>")
vim.cmd("inoremap { {}<LEFT>")
